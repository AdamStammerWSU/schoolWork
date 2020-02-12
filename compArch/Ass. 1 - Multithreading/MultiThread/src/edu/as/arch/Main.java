
package edu.as.arch;

class MultithreadingDemo extends Thread 
{ 
	
	int counter = 0;
	String name = "Thread x";
	int startTime = 0;
	int time = 0;
	long id = -1L;
	boolean running = false;
	
	public MultithreadingDemo(String name) {
		this.name = name;
		startTime = (int) System.currentTimeMillis();
		time = startTime;
		id = Thread.currentThread().getId();
		announce("Initialized");
		running = true;
	}

	public void run() 
    { 
        try
        { 
            announce("I'm running!");
            
            while ((time = (int) System.currentTimeMillis()) < (startTime + 20000) && running) {
            	if(time - (startTime + (counter * 1000)) >= 1000) {
            		counter++;
            		announce("Count " + counter);
            	}
            	Thread.sleep(100);
            }
  
        } 
        catch (Exception e) 
        { 
            System.out.println ("Exception is caught"); 
        }
        announce("Thread Closing");
    } 
    
    public void announce(String s) {
    	System.out.println("Thread " + id + " (" + name + "): " + s);
    }
} 
  
// Main Class 
public class Main 
{ 
    public static void main(String[] args) 
    {
        MultithreadingDemo andy = new MultithreadingDemo("Andy");
        andy.start();
        MultithreadingDemo nathan = new MultithreadingDemo("Nathan");
        nathan.start();
        
        boolean running = true;
        do {
        	try {
				Thread.sleep(500);
				if(andy.counter >= 4 && nathan.counter >= 4) {
					nathan.running = false;
					andy.running = false;
					running = false;
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
        } while (running);
        System.out.println("All Threads Done. Program Exiting.");
    } 
} 
