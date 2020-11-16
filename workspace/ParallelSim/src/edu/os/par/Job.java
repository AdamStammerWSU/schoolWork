package edu.os.par;

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

public class Job implements Comparable<Object> {
	static enum TYPE { // type of interaction
		CPU, IO, INTERACT
	}

	String name; // name of job
	Queue<Interaction> interactions; // stores this job's interactions
	Integer priority = 0; // jobs priority

	final int ioTime = 50; // how long does input/output take?
	final int tTime = 200; // how long does interactive io take?

	TYPE lastInteractionType = TYPE.CPU; // what was the last type of interaction?

	int ioDoneWitingTime = 0; // when is this job done waiting for io?
	int interactionCount = 0; // how many interactions is this job composed of

	// Job constructor (job data line, timeslice)
	public Job(String jobString, int slice) {
		interactions = new ConcurrentLinkedQueue <Interaction>(); // create a list to store the interactions
		String[] inters = jobString.trim().split(" "); // separate the job data line into pieces
		name = inters[0]; // first data piece is the job name
		//priority = Integer.parseInt(inters[1]); // next is the job priority
		boolean lastInteraction = false; // is this the last interaction?
		
		int lastPriority = 0;

		for (int i = 2; i < inters.length; i++) { // loop through the rest of the data line
			if (i == inters.length - 1) { // if it's the last piece, it's the last interaction
				// it's the last part of the job
				lastInteraction = true;
			}
			if (inters[i].equals("I") || inters[i].equals("O")) { // if it's input or output
				interactions.add(new Interaction(this, lastPriority, TYPE.IO, slice, lastInteraction, interactionCount++)); // add
																														// the
																														// interaction
																														// to
																														// the
																														// list

			} else if (inters[i].equals("T")) { // interactive interaction
				interactions.add(
						new Interaction(this, lastPriority, TYPE.INTERACT, slice, lastInteraction, interactionCount++)); // add
																														// the
																														// interaction
																														// to
																														// the
																														// list

			} else {
				// assume it's a cpu time
				int cpu = Integer.parseInt(inters[i]); // convert to integer
				lastPriority = cpu;
				int cpuInterCount = (int) Math.ceil((float) cpu / slice); // how many slices to finish this cpu burst?
				for (int j = 0; j < cpuInterCount; j++) { // loop through and create enough cpu interactions to do this
					boolean last = false;
					if (lastInteraction && j == cpuInterCount - 1)
						last = true;
					interactions.add(new Interaction(this, lastPriority, TYPE.CPU, slice, last, interactionCount++));
				}
			}
		}
	}

	// get the next interaction from the list(queue)
	public Interaction remove() {
		return interactions.remove();
	}

	// name getter
	public String getName() {
		return name;
	}

	@Override
	public int compareTo(Object o) {
		return this.getPriority().compareTo(((Job) o).getPriority());
	}

	// priority getter
	public Integer getPriority() {
		return priority;
	}

	// print out the job interactions
	public void printJob() {
		Object[] interArray = interactions.toArray();
		for (int i = 0; i < interactions.size(); i++) {
			System.out.println(interArray[i].toString());
		}
	}

	// return job name
	public String toString() {
		return getName();
	}

	// interaction class defines possible interactions and relevant data
	public class Interaction implements Comparable<Object> {

		TYPE type = TYPE.CPU; // type
		int time = 0; // time to complete
		boolean lastInteraction = false; // is this the final interaction of the job?
		Integer priority; // priority of interaction
		Job parentJob = null; // which job does this interaction belong to?
		int interactionNumber = 0; // which interaction is this in the job?

		// simple constructor
		public Interaction(Job parentJob, Integer priority, TYPE type, int time, boolean lastInteraction,
				int interactionNumber) {
			this.type = type;
			this.time = time;
			this.lastInteraction = lastInteraction;
			this.priority = priority;
			this.parentJob = parentJob;
			this.interactionNumber = interactionNumber;
		}

		// return string of interaction data
		public String toString() {
			return "ParentJob:" + parentJob.getName() + " Type:" + type.toString() + " Priority:" + priority + " Time:"
					+ time + " Last:" + lastInteraction + " Number:" + interactionNumber;
		}

		public int compareTo(Object i) {

			return this.getPriority().compareTo(((Interaction) i).getPriority());
		}

		// priority getter
		public Integer getPriority() {
			return priority;
		}

		// parentjob getter
		public Job getParentJob() {
			return parentJob;
		}
	}

}
