package edu.os.as;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class Main extends Thread {

	public static void main(String[] args) {
		Main main = new Main();
		System.out.println("Done");
	}

	ArrayList<Job> jobs = new ArrayList<Job>(); // list of jobs
	Clock clock = new Clock(); // clock and announcments
	Semaphore multiplicity = null, resources = null; // semaphores for process count and page requests

	public Main() {
		//read in datafile information
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(new File("jobs.dat")));
		} catch (FileNotFoundException e) {
			System.out.println("Failed to open jobs.dat file");
		}
		try {
			resources = new Semaphore(this, Integer.parseInt(reader.readLine().trim())); //first line is page quantity
			multiplicity = new Semaphore(this, Integer.parseInt(reader.readLine().trim()));//second line is multiplicity
		} catch (NumberFormatException | IOException e) {
			System.out.println("Failed to read resource and/or multiplicity value");
		}
		String s = "";
		try {
			while (((s = reader.readLine().trim()) != null)) {
				String[] jobLine = s.split(" "); //split values
				String jobName = jobLine[0]; // first value is job name
				int[] jobData = new int[jobLine.length - 1]; //separate the rest of the values
				for (int i = 0; i < jobData.length; i++) {
					jobData[i] = Integer.parseInt(jobLine[i + 1]);
				}

				System.out.print("Creating Job: " + jobName); //anounce job
				for (int i = 0; i < jobData.length; i++) {
					System.out.print(" " + jobData[i]);
				}
				System.out.println("");
				jobs.add(new Job(clock, resources, multiplicity, jobName, jobData)); //add job to list
			}
		} catch (IOException e) {
			System.out.println("Failed to read job data");
		} catch (NullPointerException e) {
			System.out.println("Jobs Read Successfully");
		}

		clock.start(); //start clock
		clock.announce("Starting Jobs");
		for (int i = 0; i < jobs.size(); i++) {
			jobs.get(i).start();
		}
		//wait for the jobs to finish
		for (int i = 0; i < jobs.size(); i++) {
			try {
				jobs.get(i).join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

	// calculates how many page resources must be left available to avoid deadlock, only looking at other jobs
	public int getSmallestAvoidDeadlockValue(Semaphore sem, Job job) {
		if (sem.equals(multiplicity))
			return 0;
		int val = Integer.MAX_VALUE;
		boolean atLeastOneJobLoaded = false;
		for (int i = 0; i < jobs.size(); i++) {
			if (jobs.get(i).isAlive() && jobs.get(i).isLoaded() && !jobs.get(i).equals(job)) {
				atLeastOneJobLoaded = true;
				int dataLeft = jobs.get(i).totalRequired - jobs.get(i).heldResources;
				if (dataLeft < val)
					val = dataLeft;
			}
		}
		int ret = val;
		if (!atLeastOneJobLoaded)// i think this is unnecessary because this method would only be called by a
									// loaded job
			ret = 0; // but i want to avoid return Integer.MAX_VALUE as the minimum required
		return ret;
	}
}
