package edu.as.tftp;

public class TFTP {

	public static void main(String[] args) {
		if (args.length < 2) {
			System.out.println("More information needed. Printing help (--?, --help)");
			printHelp();
		}

	}

	public static void printHelp() {
		System.out.println("Help");
	}

}
