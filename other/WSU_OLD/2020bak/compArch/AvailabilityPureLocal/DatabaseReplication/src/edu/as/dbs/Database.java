package edu.as.dbs;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

public class Database {

	String dataFileLoc, logFileLoc;
	BufferedReader readDataFileBuf, readLogFileBuf;
	FileReader readDataFile, readLogFile;

	BufferedWriter writeDataFileBuf, writeLogFileBuf;
	FileWriter writeDataFile;
	FileWriter writeLogFile;

	Queue<String> newTransactions, logQueue;

	ArrayList<String> data, log;

	boolean hasReplicate = false;
	Database replicate;

	public Database(String dataFileLoc, boolean isReplicate) {
		newTransactions = new LinkedList<String>();
		logQueue = new LinkedList<String>();

		this.dataFileLoc = dataFileLoc;
		logFileLoc = "";

		for (int i = 0; i < dataFileLoc.length() - 3; i++) {
			logFileLoc += dataFileLoc.charAt(i);
		}
		logFileLoc += "log";

		// make sure data files are actually there
		if (!existingDataFiles()) {
			System.out.println("Error. Cannot find data files. Blank Files will be created.");
			openWritePipes();
			closeWritePipes();
			System.exit(0);
		}

		// now open up write pipes for new data
	}

	public void commit() {
		// make sure there are transactions on the queue
		if (newTransactions.size() <= 0) {
			System.out.println("No new transactions to commit.");
			return;
		}

		if (hasReplicate) {
			replicate.setTransactionQueue(new LinkedList<>(newTransactions));
			replicate.commit();
		}

		// open read pipes and read in data
		openReadPipes();
		readData();
		readLog();
		closeReadPipes();

		// send all transactions to replicate if there is one

		while (newTransactions.size() > 0) {
			String s = newTransactions.poll();
			String[] transactionData = s.split(" ");

			int src = Integer.parseInt(transactionData[0]);
			int dst = Integer.parseInt(transactionData[1]);
			float amount = Float.parseFloat(transactionData[2]);

			transact(src, dst, amount);
		}

		// add logs to loaded log data
		processLogs();

		// write data and logs to files
		openWritePipes();
		writeData();
		writeLog();
		closeWritePipes();

		if (hasReplicate) {
			// wait for thumbs up from replicate
		}
	}

	public void addTransaction(int src, int dst, float amount) {
		String s = src + " " + dst + " " + amount;
		newTransactions.add(s);
	}

	public void setTransactionQueue(Queue<String> q) {
		newTransactions = q;
	}

	private void transact(int src, int dst, float amount) {
		// assumes database array list is up to date

		boolean srcFound = false;
		boolean dstFound = false;

		// subtract amount from source account
		for (int i = 0; i < data.size(); i++) {
			// line by line
			String[] account = data.get(i).split("\t");

//			for (int j = 0; j < account.length; j++) {
//				System.out.println("[" + j + "]: " + account[j]);
//			}

			if (Integer.parseInt(account[1]) == src) {
				srcFound = true;
				// we found our source account
				// subtract the ammount from the value
				account[2] = "" + (Float.parseFloat(account[2]) - amount);
				// and store it back in the data arraylist
				data.set(i, account[0] + "\t" + account[1] + "\t" + account[2]);

				System.out.println("Successfully subtracted " + amount + " from " + src);
			}

		}

		if (srcFound == false) {
			System.out.println("Account source[" + src
					+ "] not found. This does not stop the rest of the transaction. Transaction still logged.");
		}

		// add amount to destination account
		for (int i = 0; i < data.size(); i++) {
			// line by line
			String[] account = data.get(i).split("\t");

//			for (int j = 0; j < account.length; j++) {
//				System.out.println("[" + j + "]: " + account[j]);
//			}

			if (Integer.parseInt(account[1]) == dst) {
				dstFound = true;
				// we found our destination account
				// add the ammount from the value
				account[2] = "" + (Float.parseFloat(account[2]) + amount);
				// and store it back in the data arraylist
				data.set(i, account[0] + "\t" + account[1] + "\t" + account[2]);

				System.out.println("Successfully added " + amount + " to " + dst);
			}

		}

		if (dstFound == false) {
			System.out.println("Account destination[" + dst
					+ "] not found. This does not stop the transaction though. Transaction still logged.");
		}

		// assuming the transaction was successful
		// log the transaction
		logQueue.add("<UPDATE>" + src + "," + dst + "," + amount);
	}

	private void processLogs() {
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
		for (int i = 0; i < data.size(); i++) {
			try {
				writeDataFileBuf.write(data.get(i) + "\n");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println("Error Writing Data");
				e.printStackTrace();
			}
		}
	}

	private void readData() {
		data = new ArrayList<String>();

		String s = "";
		try {
			while ((s = readDataFileBuf.readLine()) != null) {
				data.add(s);
			}
		} catch (IOException e) {
			System.out.println("Error Reading Data File [" + dataFileLoc + "]");
		}
	}

	private void writeLog() {
		log.add("<COMMIT>");

		// assumes write pipes are already open
		for (int i = 0; i < log.size(); i++) {
			try {
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
			while ((s = readLogFileBuf.readLine()) != null) {
				log.add(s);
			}
		} catch (IOException e) {
			System.out.println("Error Reading Log File [" + dataFileLoc + "]");
		}
	}

	private void openWritePipes() {
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
		String repDataFileLoc = dataFileLoc;
		repDataFileLoc = repDataFileLoc.substring(0, repDataFileLoc.length() - 4);
		repDataFileLoc += "-rep.txt";
		replicate = new Database(repDataFileLoc, true);
		hasReplicate = true;

		return replicate;
	}
}
