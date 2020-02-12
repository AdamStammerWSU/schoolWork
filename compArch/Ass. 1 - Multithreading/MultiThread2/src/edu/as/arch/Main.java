
package edu.as.arch;

import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.ReentrantLock;

class MultithreadingDemo extends Thread {

	AtomicInteger counter;
	String name = "Thread x";
	int startTime = 0;
	int time = 0;
	long id = -1L;
	boolean running = false;
	ReentrantLock lock;

	public MultithreadingDemo(AtomicInteger counter, String name) {
		this.name = name;
		this.counter = counter;
		startTime = (int) System.currentTimeMillis();
		time = startTime;
		id = Thread.currentThread().getId();
		lock = new ReentrantLock();
		announce("Initialized");
		running = true;
	}

	public void run() {
		try {
			announce("I'm running!");

			while (counter.get() < 0) {
				Thread.sleep(1); // wait for the counter to be zeroed out
			}

			for (int j = 0; j < 100; j++) {
				for (int i = 0; i < 100; i++) {
					lock.lock(); // lock the counter
					counter.addAndGet(1); // add 1 to it
					lock.unlock(); // unlock it
				}
				if (!running) // exit this looping if the parent thread says so
					break;
				Thread.sleep(10); // wait 10 milliseconds
			}

		} catch (Exception e) {
			System.out.println("Exception is caught");
		}
		announce("Thread Closing");
	}

	public void announce(String s) {
		System.out.println("Thread " + id + " (" + name + "): " + s);
	}
}

// Main Class 
public class Main {
	static AtomicInteger counter;

	public static void main(String[] args) {
		counter = new AtomicInteger(-1);
		MultithreadingDemo andy = new MultithreadingDemo(counter, "Andy");
		MultithreadingDemo nathan = new MultithreadingDemo(counter, "Nathan");
		MultithreadingDemo carl = new MultithreadingDemo(counter, "Carl");
		MultithreadingDemo funk = new MultithreadingDemo(counter, "Funk");
		int startTime = (int) System.currentTimeMillis();

		try {
			Thread.sleep(100); // give the threads a chance to initialize
			andy.start();
			nathan.start();
			carl.start();
			funk.start(); // start all of the threads
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}

		counter.addAndGet(1); // tell the threads to start counting

		int lastCount = 0;

		boolean running = true;
		do {
			try {
				Thread.sleep(500);
				lastCount = counter.get();
				System.out.println("Last Count: " + lastCount);

				if (lastCount >= 40000) {
					nathan.running = false;
					andy.running = false;
					carl.running = false;
					funk.running = false;
					running = false;
				}

				if (System.currentTimeMillis() > (startTime + 20000)) {
					// this program has been running for more than 2 seconds

					nathan.running = false;
					andy.running = false;
					carl.running = false;
					funk.running = false;
					running = false;
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		} while (running);
		System.out.println("Final Count: " + counter.get());
		System.out.println("All Threads Done. Program Exiting.");
	}
}
