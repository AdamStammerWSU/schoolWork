package edu.os.as;

public class Semaphore {

	protected int value = 0;
	Main main;

	protected Semaphore(Main main, int initial) {
		value = initial;
		this.main = main;
	}

	public synchronized void Wait(int val, Job job) {
		//get the required value to avoid deadlock
		int required = main.getSmallestAvoidDeadlockValue(this, job);
		//if the request is more than what's available
		//or not enough to finish to this job, and if allocated does not leave enough for another job to finish
		if (value < val || ((value - val) < required && ((val + job.heldResources) < val))) {
			try {
				System.out.println("Job " + job.name + " waiting for " + val);
				wait(); //wait until notified
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			Wait(val, job); //and then try again
		} else {
			value -= val; //allocate the value just fine
		}
	}

	public synchronized void Signal(int val, Job job) {
		value += val;
		notifyAll();
	}

}
