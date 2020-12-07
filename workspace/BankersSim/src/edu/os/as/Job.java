package edu.os.as;

public class Job extends Thread {

	Clock clock;
	Semaphore resources, multiplicity;
	String name;
	int[] data;
	int totalRequired;
	int heldResources = 0;
	boolean loaded = false;

	public Job(Clock clock, Semaphore resources, Semaphore multiplicity, String name, int[] data) {
		//initialize all values
		this.clock = clock;
		this.resources = resources;
		this.multiplicity = multiplicity;
		this.name = name;
		this.data = data;
		for (int i = 1; i < data.length - 1; i += 2) { //calculate total required pages from data
			totalRequired += data[i];
		}
	}

	public void run() {
		//try to start the job
		clock.announce("Job " + name + " reporting in");
		multiplicity.Wait(1, this);
		clock.announce("Job " + name + " starting");
		loaded = true;
		/// do job stuff
		for (int i = 0; i < data.length - 1; i += 2) {
			int cpuBurst = data[i]; //grab burst time
			int pageRequest = data[i + 1]; //grab memory request value
			try {
				clock.announce("Job " + name + " bursting " + cpuBurst); //anounce the burst
				Thread.sleep(cpuBurst); //wait for burst time
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			clock.announce("Job " + name + " requesting " + pageRequest); //announce page request
			synchronized (resources) { //request page value (includes waiting for it)
				resources.Wait(pageRequest, this);
			}
			heldResources += pageRequest; //record allocated quantity
			clock.announce("Job " + name + " now holding " + heldResources); //announce resource reception

		}
		//do final cpu burst
		clock.announce("Job " + name + " bursting final " + data[data.length - 1]);
		try {
			Thread.sleep(data[data.length - 1]);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		// ---end job stuff and release all resources
		clock.announce("Job " + name + " releasing pages");
		resources.Signal(heldResources, this);
		clock.announce("Job " + name + " releasing process slot");
		multiplicity.Signal(1, this);
		loaded = false;
	}

	public boolean isLoaded() {
		return loaded;
	}

}
