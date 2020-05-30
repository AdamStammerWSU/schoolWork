package edu.as.dbs;

import java.util.Random;

public class UI {

	public static void main(String[] args) {
		Database primary, replicate;
		primary = new Database("database.txt", false);
		replicate = primary.replicate();

		Random rand = new Random();
		int src, dst;
		float amount;

		for (int i = 0; i < rand.nextInt(5) + 1; i++) {
			for (int j = 0; j < rand.nextInt(4) + 1; j++) {
				src = 42001 + rand.nextInt(18);
				dst = 42001 + rand.nextInt(18);
				amount = rand.nextInt(1000000) * rand.nextFloat();
				primary.addTransaction(src, dst, amount);
			}
			primary.commit();
		}
	}

}
