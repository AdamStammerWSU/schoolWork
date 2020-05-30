package edu.as.dbs;

import java.util.Random;

public class UI {

	public static void main(String[] args) {
		// create the primary database and point to the local datafile
		Database primary;
		primary = new Database("database.txt", false, 4200);
		// replicate it
		primary.replicate();

		// get the thread to start
		primary.start();

		// setup random and variable locations
		Random rand = new Random();
		int src, dst;
		float amount;

		// create random transactions with random commits
		for (int i = 0; i < rand.nextInt(5) + 1; i++) {
			for (int j = 0; j < rand.nextInt(4) + 1; j++) {
				src = 42001 + rand.nextInt(18);
				dst = 42001 + rand.nextInt(18);
				amount = rand.nextInt(1000000) * rand.nextFloat();
				primary.addTransaction(src, dst, amount);
			}
			primary.commit();
		}

		// wait for any replicates to catch up and such
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// try to shut everything down
		System.out.println("Trying to shutdown Primary Database");
		primary.shutDown();
	}

}
