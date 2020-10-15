package edu.wsu.os;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.StringTokenizer;

public class DataManager {

	int firstTransferSize;
	int firstTransferTime;
	int diskSize;

	int secondTransferSize;
	int secondTransferTime;
	int memorySize;

	int inputSpace;
	int DMA;
	//////////////////////////////////
	int runningSize1;
	int runningTime1;
	int Disk = 0;

	int runningCPUTime;

	int runningSize2;
	int runningTime2;
	int overlappingTime;
	int MainMemoryCode;
	int MainMemoryData;
	int MainMemoryCodeMax;
	int MainMemoryDataMax;
	int TIME;
	int[] jobLine;

	int jobDataRequired;
	String jobName = "";

	public void retrieveFile() throws FileNotFoundException {

		Scanner scan = new Scanner(new File("data.txt"));
		String returnValue = "";
/////////////////////////////////////////////////////////////////////////////////TRANSFER 1
		// secondary(tape) to primary(disk) transfer SIZE
		firstTransferSize = scan.nextInt();
		returnValue += "Tape to Disk Transfer Size: " + firstTransferSize + "\n";

		// secondary(tape) to primary(disk) transfer TIME
		firstTransferTime = scan.nextInt();
		returnValue += "Tape to Disk Transfer Time: " + firstTransferTime + "\n";

		// primary(disk) SIZE
		diskSize = scan.nextInt();
		returnValue += "Disk Size: " + diskSize + "\n";
/////////////////////////////////////////////////////////////////////////////////TRANSFER 2
		// primary(disk) to memory transfer SIZE
		secondTransferSize = scan.nextInt();
		returnValue += "Disk to Memory Transfer Size: " + secondTransferSize + "\n";

		// primary(disk) to memory transfer TIME
		secondTransferTime = scan.nextInt();
		returnValue += "Disk to Memory Transfer Time: " + secondTransferTime + "\n";

		// memory SIZE
		memorySize = scan.nextInt();
		returnValue += "Memory Size: " + memorySize + "\n";
////////////////////////////////////////////////////////////////////////////////////DETAILS		
		// job input space
		inputSpace = scan.nextInt();
		returnValue += "Job Input Space Size: " + inputSpace + "\n";

		// DMA buffer transfer SIZE
		DMA = scan.nextInt();
		returnValue += "DMA Buffer Transfer Size: " + DMA + "\n";

		// Running Units
		runningSize1 = 0;
		runningTime1 = 0;
		Disk = diskSize;
		runningSize2 = 0;
		runningTime2 = 0;
		MainMemoryCodeMax = (int) (memorySize * (2.0 / 3));
		MainMemoryDataMax = (int) (memorySize * (1.0 / 3));
		MainMemoryCode = MainMemoryCodeMax;
		MainMemoryData = MainMemoryDataMax;

		// count Tokens in job line
		scan.nextLine();
		String str = scan.nextLine();
		StringTokenizer line = new StringTokenizer(str);
		int lineSize = line.countTokens();
////////////////////////////////////////////////////////////////////////////////////JOB(S) DESCRIPTION		
		// initialize job array
		jobLine = new int[lineSize];
		int counter = 0;
		boolean time = true;
		jobName = line.nextToken();
		for (int i = 1; i < (lineSize); i++) {
			if (time) {
				// cpu burst time conversion
				String before = line.nextToken();
				int cpuBurstTime = Integer.parseInt(before);
				returnValue += "CPU Burst Time: " + cpuBurstTime + "|	";
				// add to jobLine
				jobLine[counter] = cpuBurstTime;
				counter++;
			} else {
				// job units of data conversion
				String before2 = line.nextToken();
				int dataUnits = Integer.parseInt(before2);
				returnValue += "Units of Data: " + dataUnits + "\n";
				// add to jobLine
				jobLine[counter] = dataUnits;
				counter++;
			}
			time = !time;
		}
		// output returnValue
		scan.close();
		System.out.println(returnValue);
	}

/////////////////////////////////////////////////////////////////////////////////PERFORM TASKS
	public void performTasks() {
		loadJob(); // load the job in based on machine specs
		boolean time = true;
		// loop through each number in the line
		for (int i = 0; i < jobLine.length - 1; i += 1) {

			// grab the current number in the sequence
			int currentNumber = jobLine[i];

			// loop back and forth between time and data values
			if (time) {
				runningCPUTime += currentNumber; // add time to cpu burst
				System.out.println("Bursting " + currentNumber); // indicate as such
				
				int nextData = 0;
				if(i < jobLine.length - 1) {
					//there is another number
					nextData = jobLine[i+1];
				}
				//if we are going to need more input data, buffer it
				if(nextData > 0 && (MainMemoryDataMax - MainMemoryData) < nextData) {
					//we still need to consume more and we don't have enough in memory right now
					if (Disk > (diskSize - 50)) { // if there isn't enough data on disk
						//we need to read more from tape
						transfer1();
					}	
					transfer2(false);	
					//now do the time calculations
					if(currentNumber >= secondTransferTime) {
						// the burst will take longer than the transfer
						overlappingTime -= secondTransferTime;
					} else {
						//we need to calculate the difference
						if(secondTransferTime >= currentNumber) {
							//the entire cpu was an overlap because the transfer takes longer
							overlappingTime -= currentNumber;
						} else {
							// the entire transfer time was an overlap because the cpu burst is longer
							overlappingTime -= secondTransferTime;
						}
					}
				}
			} else {
				System.out.println("Consuming " + currentNumber + " Input Data");
				// currentNumber is how much data we need to consume
				while (currentNumber > 0) {
					// check for negative
					if (MainMemoryDataMax - currentNumber >= MainMemoryData) { //if we have enough in memory to finish this consumption task
						MainMemoryData += currentNumber;// then consume it
						currentNumber = 0; // and we don't need to consume more
					} else { // there is not enough in memory to finsh this consumation task
						currentNumber -= MainMemoryDataMax - MainMemoryData; //consume what is there
						MainMemoryData = MainMemoryDataMax; //and empty the mainmemory data space
					}
					
					if (currentNumber > 0) { //if there is still something to consume (meaning mainmemorydata space is also empty)
						if (Disk <= (diskSize - secondTransferSize)) { //if there is enough on disk to transfer to mainmemory
							transfer2(false); //then do so

						} else { //otherwise, there is not enough on disk
							transfer1(); //so transfer to disk
							transfer2(false); //and then transfer to mainmemory
						}
					}
				}
			}

			time = !time;
		}

	}

/////////////////////////////////////////////////////////////////////////////////TRANSFER 1
	public void transfer1() {

		runningTime1 += firstTransferTime;
		Disk -= firstTransferSize;
	}
	
/////////////////////////////////////////////////////////////////////////////////DMA TANSFER
	public void transferDMA() {
		
	}
/////////////////////////////////////////////////////////////////////////////////TRANSFER 2
	public void transfer2(boolean code) {

		// restore disk storage
		Disk += secondTransferSize;

		// carry out second transfer
		// runningSize2 = secondTransferSize - Disk;
		runningTime2 += secondTransferTime;
		if (code) {
			MainMemoryCode -= secondTransferSize;
		} else
			MainMemoryData -= secondTransferSize;
	}

/////////////////////////////////////////////////////////////////////////////////TRANSFER 3
	public void transfer3() {
		// restore memory storage
		MainMemoryCode = memorySize;
	}

	public void loadJob() {
		// transfer 200 into MainMemoryCode
		System.out.println("Loading Job");
		// how many transfer1s?
		int t1s = (int) Math.ceil(200.0 / firstTransferSize);

		// runningTime1 += t1s * firstTransferTime;
		for (int i = 0; i < t1s; i++) {
			transfer1();
		}
		// how many transfer2s?
		int t2s = (int) Math.ceil(200.0 / secondTransferSize);

		// runningTime2 += t2s * secondTransferTime;
		for (int i = 0; i < t2s; i++) {
			transfer2(true);
		}
		MainMemoryCode -= 200;
	}

/////////////////////////////////////////////////////////////////////////////////FINAL TIME
	public void finalTime() {
		TIME += runningTime1 + runningTime2 + runningCPUTime + overlappingTime;
		System.out.println();
		System.out.println("Run1 Time: " + runningTime1);
		System.out.println("Run2 Time: " + runningTime2);
		System.out.println("CPU  Time: " + runningCPUTime);
		System.out.println("Overlapping Time: " + overlappingTime);
		System.out.println("TOTAL Time: " + TIME);
	}

}