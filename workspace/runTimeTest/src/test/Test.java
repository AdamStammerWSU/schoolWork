package test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Test {

	public static void main(String[] args) {
		String i = "56u";
		System.out.println(i.substring(i.length() - 1));
		System.out.println(i.substring(0, i.length() - 1));
		Process p = null;
		try {
			p = Runtime.getRuntime().exec("cmd /c convert -density 300 test.pdf output-%04d.png");
		} catch (IOException e) {
			System.out.println("failed");
			e.printStackTrace();
		}
		
		while(p.isAlive()) {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

//		ProcessBuilder pb = new ProcessBuilder("convert -density 300 test.pdf output-%04d.png");
//		pb.redirectErrorStream(true);
//		Process process = null;
//		try {
//			process = pb.start();
//		} catch (IOException e) {
//			System.out.println("Could not start conversion process");
//			e.printStackTrace();
//		}
//		BufferedReader inStreamReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
//
//		String line = "";
//		try {
//			while ((line = inStreamReader.readLine()) != null) {
//				System.out.println(line);
//			}
//		} catch (IOException e) {
//			System.out.println("Error reading output");
//			e.printStackTrace();
//		}

		System.out.println("Done");
	}

}
