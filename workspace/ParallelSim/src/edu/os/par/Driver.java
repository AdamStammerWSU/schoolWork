package edu.os.par;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.PriorityQueue;
import java.util.Scanner;

public class Driver {

	public static void main(String[] args) {
		PriorityQueue<Job> jobs = new PriorityQueue<Job>(); // queue for jobs to load
		String fileLocation = "data.txt"; // data file containing jobs
		Scanner scanner = null; // scanner to read jobs
		try {
			scanner = new Scanner(new File(fileLocation)); // open the data file
		} catch (FileNotFoundException e) {
			System.out.println(fileLocation + " could not be opened.");
			System.exit(0);
		}
		int slice = Integer.parseInt(scanner.nextLine().trim()); // read in the time slice size
		int multi = Integer.parseInt(scanner.nextLine().trim()); // read in how many jobs can run at the same time
		while (scanner.hasNext()) { // for each addition (job) line
			Job job = new Job(scanner.nextLine(), slice); // create the job using the line
			job.printJob(); // print out the job details
			jobs.add(job); // add the job to the queue
		}

		Processor processor = new Processor(slice, multi, jobs); // create a processor system to run the jobs
		processor.loadJobs(); // load as many jobs as possible
		// processor.printQueue(); // print out the beginning queue
		processor.process(); // start processing the jobs
		processor.announce("\tAll Jobs Finished"); // all the jobs are now done
	}

}
