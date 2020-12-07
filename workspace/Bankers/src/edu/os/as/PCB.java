package edu.os.as;

public class PCB {

	public PCB(int count, int cs, int out, Clock gclock, Semaphore gsem) {
		cstime = cs;
		outsidetime = out;
		pid = count;
		myclock = gclock;
		mysemaphore = gsem;
	}

	int pid;
	int cstime, outsidetime;
	Clock myclock;
	Semaphore mysemaphore;

}
