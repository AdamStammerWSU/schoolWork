package edu.os.par;

import java.util.PriorityQueue;
import java.util.Queue;

import edu.os.par.Job.Interaction;
import edu.os.par.Job.TYPE;

public class Processor {

	int slice, multi; // system info
	PriorityQueue<Job> jobs; // job queue
	PriorityQueue<Job> loadedJobs; // queue of jobs already loaded

	int numberOfJobs = 0; // how many are there?

	int time = 0; // what time is it currently

	int jobsLoaded = 0; // how many jobs are loaded
	Queue<Interaction> queue = new PriorityQueue<Interaction>(); // queue of job interactions

	// simple constructor
	public Processor(int slice, int multi, PriorityQueue<Job> jobs) {
		this.slice = slice;
		this.multi = multi;
		this.jobs = jobs;
		this.numberOfJobs = jobs.size();
		this.loadedJobs = new PriorityQueue<Job>();
	}

	// load jobs according to system specs
	public void loadJobs() {
		// printJobs(); //print out job data
		// System.out.println("------------Loading Jobs-----------");
		// System.out.println(jobsLoaded + " " + multi + " " + numberOfJobs);
		while (jobsLoaded < multi && jobsLoaded < numberOfJobs && jobs.size() > 0) { // while we can still load a job
			// load in as many jobs as allowed and available
			Job j = jobs.remove();
			queue.add(j.remove());
			announce("Job " + j.getName() + " loaded and queued");
			loadedJobs.add(j);

			jobsLoaded++;
			// printJobs();

			// numberOfJobs = jobs.size();
		}
		// System.out.println(jobsLoaded + " " + multi + " " + numberOfJobs);
		// System.out.println("------------Jobs Loaded------------");
	}

	// system annoncement
	public void announce(String s) {
		System.out.println(time + ":\t" + s);
	}

	// job based announcement
	public void announce(Job j, String s) {
		System.out.println(time + "(" + j + ")" + ":\t" + s);
	}

	// print out the current queue of interactions
	public void printQueue() {
		Object[] q = queue.toArray();
		System.out.println("Current Queue: ");
		for (int i = 0; i < q.length; i++) {
			System.out.println("\t" + q[i].toString());
		}
	}

	// print all loaded job data
	public void printJobs() {
		Object[] j = jobs.toArray();
		System.out.println("Current Job List: ");
		for (int i = 0; i < j.length; i++) {
			System.out.println("\t" + j[i].toString());
		}
	}

	// process the jobs
	public void process() {
		boolean io = false;
		while (queue.size() > 0) {
			io = false;
			// grab the first interaction in the queue
			Interaction i = queue.poll();

			// process the interaction
			announce(i.getParentJob(), "Running");

			time += slice;
			announce(i.getParentJob(), "Timed Out");

			// look at the next interaction for this job and process it if it's io
			if (!i.lastInteraction) {
				// System.out.println("This I Number: " + i.getParentJob().getName() + "," +
				// i.interactionNumber);
				// System.out.println(i.getParentJob());
				// System.out.println(i.getParentJob().interactions);
				// System.out.println(i.getParentJob().interactions.peek());
				if (i.getParentJob().interactions.peek().type == TYPE.IO) {
					i.getParentJob().ioDoneWitingTime = time + 50;
					// i.getParentJob().interactions.remove();
					announce(i.getParentJob(), "Requesting IO");
					io = true;
				} else if (i.getParentJob().interactions.peek().type == TYPE.INTERACT) {
					i.getParentJob().ioDoneWitingTime = time + 200;
					// i.getParentJob().interactions.remove();
					announce(i.getParentJob(), "Requesting Terminal IO");
					io = true;
				}
			}

			// check to see if anyone is done waiting for io
			for (Job j : loadedJobs) {
				if (j.ioDoneWitingTime == time) {
					announce(j, "Done Waiting For IO");
					announce(j, "Ready");
					// System.out.println(j.interactions);
					Interaction inter = j.remove();
					// System.out.println("Adding " + inter.toString());
					// System.out.println(j.interactions);
					queue.add(inter);
				}
			}

			if (!io) { // if a cpu burst
				// queue the next interaction of this job
				if (!i.lastInteraction) {
					queue.add(i.getParentJob().remove());
				} else {// or end job if it's the last interaction of the job
					announce(i.getParentJob(), "Job Finished");
					// unload job
					// loadedJobs.remove(i.getParentJob());
					jobsLoaded--;
					// load next job
					loadJobs();
				}
			}
		}
	}

}
