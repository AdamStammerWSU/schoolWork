package edu.as.dbs;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

public class Database extends Thread {

	// Setup Data and Log File streams
	String dataFileLoc, logFileLoc;
	BufferedReader readDataFileBuf, readLogFileBuf;
	FileReader readDataFile, readLogFile;

	BufferedWriter writeDataFileBuf, writeLogFileBuf;
	FileWriter writeDataFile;
	FileWriter writeLogFile;

	// FIFO list of transactions and logs
	Queue<String> newTransactions;
	Queue<String> logQueue;

	// place to store existing data and log when read from file
	ArrayList<String> data, log;

	//
	boolean hasReplicate = false, isReplicate = false;
	Database replicate;

	// declare server streams and settings
	private ServerSocket serverSocket = null;
	private InputStream inputStream = null;
	private OutputStream outputStream = null;
	private Socket socket = null;
	private int parentPort = 2420;

	// initialize socket and input output streams
	private Socket socketAsClient = null;
	private InputStream inputStreamAC = null;
	private OutputStream outputStreamAC = null;
	private String address = "127.0.0.1";

	// used to format network read data
	BufferedReader in = null;

	// constructor
	public Database(String dataFileLoc, boolean isReplicate, int parentPort) {
		// set local variables
		this.isReplicate = isReplicate;
		this.parentPort = parentPort;
		this.dataFileLoc = dataFileLoc;
		logFileLoc = "";

		// initialize queues and stacks
		newTransactions = new LinkedList<String>();
		logQueue = new LinkedList<String>();

		// create log file name from data file name
		logFileLoc = dataFileLoc.substring(0, dataFileLoc.length() - 3) + "log";

		// make sure data files are actually there
		if (!existingDataFiles()) {
			System.out.println("Error. Cannot find data files. Blank Files will be created.");
			openWritePipes();
			closeWritePipes();
			System.exit(0);
		}
	}

	public void run() {
		// if you have a parent
		if (isReplicate) {
			try {
				// wait for the parent's server to start up
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				System.out.println("Thread Don't Want To Sleep");
				e1.printStackTrace();
			}

			// setup client network connection
			System.out.println("Client: Trying to connect to server...");
			try {
				// try to connect
				socketAsClient = new Socket(address, parentPort);

				// get streams from connection
				inputStreamAC = socketAsClient.getInputStream();
				outputStreamAC = socketAsClient.getOutputStream();
			} catch (IOException e) {
				System.out.println("Error connecting to parent");
				e.printStackTrace();
			}
			System.out.println("Client: Connected");

			// start loop
			boolean running = true;
			String messageFromParent = "";
			while (running) {
				try {
					// free up resources and slow down the loop
					Thread.sleep(10);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}

				// wait for a message to come in
				messageFromParent = networkReadAsClient();

				// look at the message header to decide how to handle it
				// TRAN 420xx 420xx [x..x]
				// transaction src dst amount
				// COMM
				// commit
				// QUIT
				// close all network streams and end thread
				switch (messageFromParent.substring(0, 4)) {
				case "TRAN":
					// grab the separate pieces from the message
					String[] transactionList = messageFromParent.split(" ");
					int src = Integer.parseInt(transactionList[1]);
					int dst = Integer.parseInt(transactionList[2]);
					float amount = Float.parseFloat(transactionList[3]);
					// and add the transaction to your queue
					addTransaction(src, dst, amount);
					break;
				case "COMM":
					// commit all of the gathered transactions
					commit();
					break;
				case "QUIT":
					// send back a bye message and kill this thread
					System.out.println("Replicate Trying to Shutdown");
					networkWriteAsClient("BYE\n");
					closeNetworkStreams();
					running = false;
					break;
				default:
					System.out.println("Message from parent not recognized [" + messageFromParent + "]");
				}
			}
		}
	}

	public void commit() {
		// make sure there are transactions on the queue
		if (newTransactions.size() <= 0) {
			System.out.println("No new transactions to commit.");
			return;
		}

		// open read pipes and read in data
		openReadPipes();
		readData();
		readLog();
		closeReadPipes();

		// loop through the transaction queue
		while (newTransactions.size() > 0) {
			// grab the transaction and split all the data pieces apart
			String s = newTransactions.poll();
			String[] transactionData = s.split(" ");

			int src = Integer.parseInt(transactionData[0]);
			int dst = Integer.parseInt(transactionData[1]);
			float amount = Float.parseFloat(transactionData[2]);

			// parent message
			if (!isReplicate)
				System.out.println("Transacting: " + s);

			// execute the transaction from the pieces
			transact(src, dst, amount);
		}

		// add the commit to the log queue
		logQueue.add("<COMMIT>");

		// add logs to loaded log data
		processLogs();

		// write data and logs to files
		openWritePipes();
		writeData();
		writeLog();
		closeWritePipes();

		if (hasReplicate) {
			// tell replicate to commit too
			networkWriteAsParent("COMM\n");
			// wait for a thumbs up from the client
			String response = networkReadAsParent();
			if (!response.equals("GOOD")) {
				System.out.println("Unexpected Replicate Response on Commit: " + response);
			}
		}

		if (isReplicate) {
			// inform the parent of a good commit
			networkWriteAsClient("GOOD\n");
		}

		// parent message
		if (!isReplicate)
			System.out.println("Commit Successful!");
	}

	public void addTransaction(int src, int dst, float amount) {
		// construct the transaction message
		String s = src + " " + dst + " " + amount;
		// add it to the queue
		newTransactions.add(s);

		// if you have a replicate, send it to them too
		if (hasReplicate) {
			networkWriteAsParent("TRAN " + s + "\n");
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

	private void transact(int src, int dst, float amount) {

		// if the accounts don't exist, the transaction still continues
		// so if the src exists but not the dst, the src still loses money

		// we don't know if the accounts even exist yet
		boolean srcFound = false;
		boolean dstFound = false;

		// subtract amount from source account
		for (int i = 0; i < data.size(); i++) {
			// line by line
			String[] account = data.get(i).split("\t");
			// check to see if the account is the one we're looking for
			if (Integer.parseInt(account[1]) == src) {
				srcFound = true;
				// we found our source account
				// subtract the ammount from the value
				account[2] = "" + (Float.parseFloat(account[2]) - amount);
				// and store it back in the data arraylist
				data.set(i, account[0] + "\t" + account[1] + "\t" + account[2]);
			}

		}

		// couldn't find the account
		if (srcFound == false) {
			System.out.println("Account source[" + src
					+ "] not found. This does not stop the rest of the transaction. Transaction still logged.");
		}

		// add amount to destination account
		for (int i = 0; i < data.size(); i++) {
			// line by line
			String[] account = data.get(i).split("\t");

			// check to see if the account matches what we're looking for
			if (Integer.parseInt(account[1]) == dst) {
				dstFound = true;
				// we found our destination account
				// add the ammount from the value
				account[2] = "" + (Float.parseFloat(account[2]) + amount);
				// and store it back in the data arraylist
				data.set(i, account[0] + "\t" + account[1] + "\t" + account[2]);
			}

		}

		// didn't find the account
		if (dstFound == false) {
			System.out.println("Account destination[" + dst
					+ "] not found. This does not stop the transaction though. Transaction still logged.");
		}

		// assuming the transaction was successful
		// log the transaction
		logQueue.add("<UPDATE>" + src + "," + dst + "," + amount);
	}

	private void processLogs() {
		// take the log stack and add it to the log data
		while (logQueue.size() > 0) {
			log.add(logQueue.poll());
		}
	}

	private boolean existingDataFiles() {
		// check to see if the database file already exists
		File f = new File(dataFileLoc);
		return f.exists();
	}

	private void writeData() {
		// loop through all of the data
		for (int i = 0; i < data.size(); i++) {
			try {
				// and write it to the data file
				writeDataFileBuf.write(data.get(i) + "\n");
			} catch (IOException e) {
				System.out.println("Error Writing Data");
				e.printStackTrace();
			}
		}
	}

	private void readData() {
		data = new ArrayList<String>();

		String s = "";
		try {
			// read in all the data abailable and store it in the data arraylist
			while ((s = readDataFileBuf.readLine()) != null) {
				data.add(s);
			}
		} catch (IOException e) {
			System.out.println("Error Reading Data File [" + dataFileLoc + "]");
		}
	}

	private void writeLog() {
		// assumes write pipes are already open
		for (int i = 0; i < log.size(); i++) {
			try {
				// write everything in the log list to file
				writeLogFileBuf.write(log.get(i) + "\n");
			} catch (IOException e) {
				System.out.println("Failed to write log");
				e.printStackTrace();
			}
		}
	}

	private void readLog() {
		// assumes read pipes are already open
		log = new ArrayList<String>();

		String s = "";
		try {
			// read in each line from the log and store it in the log arraylist
			while ((s = readLogFileBuf.readLine()) != null) {
				log.add(s);
			}
		} catch (IOException e) {
			System.out.println("Error Reading Log File [" + dataFileLoc + "]");
		}
	}

	private void openWritePipes() {
		// initialize all of the file write pipes
		try {
			writeDataFile = new FileWriter(dataFileLoc);
			writeDataFileBuf = new BufferedWriter(writeDataFile);
			writeLogFile = new FileWriter(logFileLoc);
			writeLogFileBuf = new BufferedWriter(writeLogFile);
		} catch (IOException e) {
			System.out.println("There was an issue opening files[write] for database[" + dataFileLoc + "]");
//		System.exit(0);
			e.printStackTrace();
		}
	}

	private void openReadPipes() {
		// initialize all of the file read pipes
		try {
			readDataFile = new FileReader(dataFileLoc);
			readDataFileBuf = new BufferedReader(readDataFile);
			readLogFile = new FileReader(logFileLoc);
			readLogFileBuf = new BufferedReader(readLogFile);
		} catch (FileNotFoundException e) {
			System.out.println("There was an issue opening files[read] for database[" + dataFileLoc + "]");
//		System.exit(0);
			e.printStackTrace();
		}
	}

	private void closeWritePipes() {
		// close all file write pipes
		try {
			writeDataFileBuf.close();
			writeDataFile.close();
			writeLogFileBuf.close();
			writeLogFile.close();
		} catch (IOException e) {
			System.out.println("There was an issue closing the write pipes");
//		System.exit(0);
			e.printStackTrace();
		}
	}

	private void closeReadPipes() {
		// close all file read pipes
		try {
			readDataFileBuf.close();
			readDataFile.close();
			readLogFileBuf.close();
			readLogFile.close();
		} catch (IOException e) {
			System.out.println("There was an issue closing the read pipes");
//		System.exit(0);
			e.printStackTrace();
		}
	}

	public Database replicate() {
		// setup for creating a replicate database
		String repDataFileLoc = dataFileLoc;
		// make name the existing name with "-rep" appended
		repDataFileLoc = repDataFileLoc.substring(0, repDataFileLoc.length() - 4);
		repDataFileLoc += "-rep.txt";
		// now we do have a replicate
		hasReplicate = true;

		// setup server on port+1
		try {
			// setup server
			serverSocket = new ServerSocket(parentPort + 1);

			// create replicate
			System.out.println("Waiting for replicate to connect...");
			replicate = new Database(repDataFileLoc, true, parentPort + 1);
			replicate.start();
			// wait for the replicate to connect to the server
			socket = serverSocket.accept();

			// grab the network streams
			inputStream = socket.getInputStream();
			outputStream = socket.getOutputStream();

			System.out.println("Replicate connected");

		} catch (IOException e) {
			System.out.println("Server Setup Error");
			e.printStackTrace();
		}

		return replicate;
	}

	private String networkReadAsParent() {
		// network read with server stream
		return networkRead(inputStream);
	}

	private void networkWriteAsParent(String s) {
		// network write with server stream
		networkWrite(s, outputStream);
	}

	private String networkReadAsClient() {
		// network read with client stream
		return networkRead(inputStreamAC);
	}

	private void networkWriteAsClient(String s) {
		// network read with client stream
		networkWrite(s, outputStreamAC);
	}

	private String networkRead(InputStream is) {
		// setup string and formatting stream
		String readString = "Default String";

		in = new BufferedReader(new InputStreamReader(is));

		try {
			// read network until the next new line
			readString = in.readLine();
			// if that causes an error, tell the user and exit
			if (readString.length() < 0 || readString.equals(null) || readString.equals("")) {
				System.out.println("Server: Read Buffer Error. Trying to exit cleanly.");
				closeNetworkStreams();
				System.exit(0);
			}
			return readString;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "Message Failure";
	}

	private void networkWrite(String s, OutputStream os) {
		try {
			// use the outputstream to write the given string as bytes
			os.write((s).getBytes());
			os.flush();
		} catch (IOException e) {
			System.out.println("Failed to network write as Parent");
			e.printStackTrace();
		}
	}

	// close the streams and socket, and exit as gracefully as possible
	private void closeNetworkStreams() {
		// close network pipes based on what connections are open
		try {
			if (hasReplicate) {
				inputStream.close();
				outputStream.close();
				socket.close();
				serverSocket.close();
			}
			if (isReplicate) {
				inputStreamAC.close();
				outputStreamAC.close();
				socketAsClient.close();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// announce this
		String type = "Server";
		if (isReplicate)
			type = "Replicate";
		System.out.println(type + ": Network Connection Successfully Closed");
	}

	public void shutDown() {
		// tell your replicate to shutdown if need be and close down the network
		if (hasReplicate) {
			System.out.println("Telling Replicate to Shutdown");
			networkWriteAsParent("QUIT\n");
			String s = networkReadAsParent();
			if (s.equals("BYE"))
				System.out.println("Replicate shutdown properly");
			else
				System.out.println("Something wrong with client shutdown: " + s);
		}
		closeNetworkStreams();

	}

}
