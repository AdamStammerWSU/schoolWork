package edu.os.as;

public class Systhread extends Thread {
	PCB mypcb;

	public Systhread(PCB p) {
		mypcb = p;

		System.out.println("Process # " + mypcb.pid + ": Starting at " + mypcb.myclock.getTime());

	}

	public void run() {

		while (true) {
			long t;

			System.out.println(mypcb.myclock.getTime() + "		" + mypcb.pid);

			mypcb.mysemaphore.Wait();
			System.out.println(mypcb.myclock.getTime() + "		                 " + mypcb.pid);

			try {
				sleep(mypcb.cstime);
			} catch (InterruptedException e) {
			} // using CPU

			System.out.println(mypcb.myclock.getTime() + "				                     " + mypcb.pid);
			mypcb.mysemaphore.Signal(); // releases CPU

			try {
				sleep(mypcb.outsidetime);
			} catch (InterruptedException e) {
			} // doing other stuff

		}

	}

}
