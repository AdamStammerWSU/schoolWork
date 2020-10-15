package com.as.nt;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;

public class Main {

	public static boolean server = true;

	public static void main(String[] args) {
		if (!server) {
			// client code
			InetAddress host = null;
			try {
				host = InetAddress.getLocalHost();
			} catch (UnknownHostException e) {
				System.out.println("Failed to get local host address");
				e.printStackTrace();
			}
			Socket socket = null;

			DataOutputStream dos = null;
			DataInputStream dis = null;
			boolean running = true;
			try {
				socket = new Socket(host.getHostName(), 9876);
				dos = new DataOutputStream(socket.getOutputStream());
				dis = new DataInputStream(socket.getInputStream());
			} catch (IOException e) {
				System.out.println("Failed to connect to server");
				e.printStackTrace();
				System.exit(0);
			}
			while (running) {
				for (int i = 0; i < 5; i++) {
					try {
						if (i == 4) {
							System.out.println("Sending 'exit' to the server");
							running = false;
							dos.writeUTF("exit");
						} else {
							System.out.println("Sending '" + i + "' to the server");
							dos.writeUTF(i + "");
						}

					} catch (IOException e) {
						System.out.println("Failed to send message to server");
						e.printStackTrace();
						System.exit(0);
					}

					String s;
					try {
						s = dis.readUTF();
						System.out.println("Message Received From Server: " + s);
					} catch (IOException e) {
						System.out.println("Failed to read response from server");
						e.printStackTrace();
						System.exit(0);
					}
				}
			}
		} else {
			// server code
			ServerSocket servSoc = null;
			int port = 9876;
			DataInputStream dis = null;
			DataOutputStream dos = null;

			try {
				servSoc = new ServerSocket(port);
				Socket socket = servSoc.accept();
				dis = new DataInputStream(socket.getInputStream());
				dos = new DataOutputStream(socket.getOutputStream());
				System.out.println("client connected");
			} catch (IOException e) {
				System.out.println("Failed to open server");
				e.printStackTrace();
				System.exit(0);
			}

			boolean running = true;
			while (running) {
				String s = "";
				try {
					s = dis.readUTF();
				} catch (IOException e) {
					System.out.println("Failed to read from client");
					e.printStackTrace();
					System.exit(0);
				}
				System.out.println("Message Received From Client: " + s);
				
				if(s.equals("exit")) {
					running = false;
				}

				try {
					dos.writeUTF("Server: Received " + s);
				} catch (IOException e) {
					System.out.println("Failed to write to client");
					e.printStackTrace();
					System.exit(0);
				}
			}
		}
	}
}
