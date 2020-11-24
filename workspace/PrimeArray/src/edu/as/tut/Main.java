package edu.as.tut;

public class Main {

	public static void main(String[] args) {
		int N = 4000; //which prime do you want? (10th prime)
		int[] PRIMES = new int[4000]; //list of primes found
		
		int PCOUNT = 0;
		int I = 1; //is this number a prime?
		while(PCOUNT < N) { //keep looping until you find the nth prime
			I++;
			//check to see if currentNumber is prime
			boolean isPrime = true;
			for (int j = 0; j < PCOUNT; j = j + 1) { //divide the number by every prime we've already found
				if ((I % PRIMES[j]) == 0) //if it divides evenly, then currentNumber is not prime
					isPrime = false; //increment i and restart while loop
			}
			
			if(isPrime) {
				//add it to the prime list
				PRIMES[PCOUNT] = I;
				PCOUNT += 1;
			}
		}
		for(int i = 0; i < N; i++) {
			System.out.println((i+1) + ": " + PRIMES[i]);
		}
		
		System.out.println(48);
		System.out.println(48<<1);
	}
}