package edu.os.as;

public class MySystem extends Thread {
	


	Systhread m1, m2, m3, m4;
	PCB p1, p2, p3, p4;
	int processcount;
	Semaphore cpu;
	Clock sysclock;
	
	public MySystem() {
		
	}

	public void run() {

		cpu = new Semaphore(1);
		processcount = 1;
		sysclock = new Clock();

		System.out.println("Hello system is starting " + sysclock.getTime());

		p1 = new PCB(processcount, 50, 100, sysclock, cpu);
		m1 = new Systhread(p1);
		processcount++;

		p2 = new PCB(processcount, 20, 500, sysclock, cpu);
		m2 = new Systhread(p2);
		processcount++;

		p3 = new PCB(processcount, 100, 500, sysclock, cpu);
		m3 = new Systhread(p3);
		processcount++;

		p4 = new PCB(processcount, 30, 30, sysclock, cpu);
		m4 = new Systhread(p4);
		processcount++;

		System.out.println("Time	Requesting		In			Out");
		System.out.println("");

		m1.start();
		m2.start();
		m3.start();
		m4.start();

	}

}
