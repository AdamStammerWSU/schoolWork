package edu.wsu.se;

import java.awt.List;
import java.util.LinkedList;
import java.util.Random;
import java.util.Set;
import java.util.TreeSet;
public class Game {

	boolean[] p1Matrix = new boolean[4];
	boolean[] p2Matrix = new boolean[4];
	boolean[] p3Matrix = new boolean[4];
	boolean[] p4Matrix = new boolean[4];
	
	boolean gameEnd = false;
	int turnNumber = 1;
	int whoseTurn = 1;
	int whomWon = -1;
	boolean alreadyWon = false;
	
	Set<Integer> player1 = new TreeSet<Integer>();
	Set<Integer> player2 = new TreeSet<Integer>();
	Set<Integer> player3 = new TreeSet<Integer>();
	Set<Integer> player4 = new TreeSet<Integer>();
	
	public Game(Set<Integer> hand, Set<Integer> hand2, Set<Integer> hand3, Set<Integer> hand4) {
		player1 = hand;
		player2 = hand2;
		player3 = hand3;
		player4 = hand4;
	}
	
	public void startGame()
	{
		p1Matrix[0] = true;
		p2Matrix[1] = true;
		p3Matrix[2] = true;
		p4Matrix[3] = true;
		
			Random rand = new Random();
			for(int i = 0; i < 3; i++)
			{
				player1.add(rand.nextInt(20)+1);
			}	
		
	}
	
	public void newTurn(int player, int wanted,Set<Integer> p1,Set<Integer> p2,Set<Integer> p3,Set<Integer> p4)
	{
		
		switch (whoseTurn) {
        case 1:  whoseTurn = 1;
			player1.add(wanted);
			updateMatrix(p1,p2,p3,p4);
			checkWin();
			checkgameEnd();
			whoseTurn = 2;
			break;
        case 2:  whoseTurn = 2;	
			player2.add(wanted);
			updateMatrix(p1,p2,p3,p4);
			checkWin();
			checkgameEnd();
			whoseTurn = 3;
			break;
        case 3:  whoseTurn = 3;	
			player3.add(wanted);
			updateMatrix(p1,p2,p3,p4);
			checkWin();
			checkgameEnd();
			whoseTurn = 4;
			break;
        case 4:  whoseTurn = 4;	
			player4.add(wanted);
			updateMatrix(p1,p2,p3,p4);
			checkWin();
			checkgameEnd();
			incrementTurn();
			whoseTurn = 1;
			break;
			}
		
	}
	public void updateMatrix(Set<Integer> p1,Set<Integer> p2,Set<Integer> p3,Set<Integer> p4)
	{
		switch (whoseTurn) {
        case 1:  whoseTurn = 1;
	        if(p1.containsAll(p2)){
	    		p1Matrix[1] = true;
	    	}
	        else{
	        	p1Matrix[1] = false;
	        }
	    	if(p1.containsAll(p3)){
	    		p1Matrix[2] = true;	    		
	    	}
	    	else{
	    		p1Matrix[2] = false;	    		
	        }
	    	if(p1.containsAll(p4)){
	    		p1Matrix[3] = true;	    		
	    	}
	    	else{
	    		p1Matrix[3] = false;	
	        }
                 break;
        case 2:  whoseTurn = 2;
	        if(p2.containsAll(p1)){
	    		p2Matrix[0] = true;
	    	}
	        else
	        {
	    		p2Matrix[0] = false;
	        }
	    	if(p2.containsAll(p3)){
	    		p2Matrix[2] = true;
	    	}
	    	else
	        {
	    		p2Matrix[2] = false;
	        }
	    	if(p2.containsAll(p4)){
	    		p2Matrix[3] = true;
	    	}
	    	else
	        {
	    		p2Matrix[3] = false;
	        }
	                 break;
        case 3:  whoseTurn = 3;
	        if(p3.containsAll(p1)){
	    		p3Matrix[0] = true;
	    	}else
	        {
	    		p3Matrix[0] = false;
	        }
	    	if(p3.containsAll(p2)){
	    		p3Matrix[1] = true;
	    	}else
	        {
	    		p3Matrix[1] = false;
	        }
	    	if(p3.containsAll(p4)){
	    		p3Matrix[3] = true;
	    	}else
	        {
	    		p3Matrix[3] = false;
	        }
                 break;
        case 4:  whoseTurn = 4;
	        if(p4.containsAll(p1)){
	    		p4Matrix[0] = true;
	    	}else
	        {
	    		p4Matrix[0] = false;
	        }
	    	if(p4.containsAll(p2)){
	    		p4Matrix[1] = true;
	    	}else
	        {
	    		p4Matrix[1] = false;
	        }
	    	if(p4.containsAll(p3)){
	    		p4Matrix[2] = true;
	    	}else
	        {
	    		p4Matrix[2] = false;
	        }
                 break;
        default: whoseTurn = -1;
                 break;
    }
		
	}
	public void checkWin()
	{
		if(p1Matrix[1] == true & p1Matrix[2] == true & p1Matrix[3] == true)
		{
			whomWon = 1;
			gameEnd = true;
		}
		if(p2Matrix[0] == true & p2Matrix[2] == true & p2Matrix[3] == true)
		{
			whomWon = 2;
			gameEnd = true;
		}
		if(p3Matrix[0] == true & p3Matrix[1] == true & p3Matrix[3] == true)
		{
			whomWon = 3;
			gameEnd = true;
		}
		if(p4Matrix[0] == true & p4Matrix[1] == true & p4Matrix[2] == true)
		{
			whomWon = 4;
			gameEnd = true;
		}
		
	}
	public void checkgameEnd()
	{
		if(gameEnd == true)
		{
			if(whoseTurn != -1 & alreadyWon == false) {
				System.out.println("Player " + whoseTurn + " has won on turn " +turnNumber);
				alreadyWon = true;
			}
				if(whoseTurn == -1)
					System.out.println("The game has run out of turns");
		}
	}
	public void incrementTurn()
	{
		turnNumber++;
		if(turnNumber >= 17) {
			whoseTurn = -1;
			gameEnd = true;
		}
	}	
	///////////////////////////////////////////////////Hand and Matrix Display
	public String displayMatrix()
	{
		String matrix = "P1: [";
		for(int i = 0; i < 4; i++)
		{
			matrix += p1Matrix[i] + " ";	
		}
		matrix += "]\n";
		matrix += "P2: [";
		for(int i = 0; i < 4; i++)
		{
			matrix += p2Matrix[i] + " ";	
		}
		matrix += "]\n";
		matrix += "P3: [";
		for(int i = 0; i < 4; i++)
		{
			matrix += p3Matrix[i] + " ";	
		}
		matrix += "]\n";
		matrix += "P4: [";
		for(int i = 0; i < 4; i++)
		{
			matrix += p4Matrix[i] + " ";	
		}
		matrix += "]\n";
		
		return matrix;
	}
///////////////////////////////////////////////////Getters and Setters
	public int getTurnNumber()
	{
		return turnNumber;
	}
	public int getwhoseTurn()
	{
		return whoseTurn;
	}
	public boolean[] getP1Matrix() {
		return p1Matrix;
	}
	public boolean[] getP2Matrix() {
		return p2Matrix;
	}
	public boolean[] getP3Matrix() {
		return p3Matrix;
	}

	public void setP3Matrix(boolean[] p3Matrix) {
		this.p3Matrix = p3Matrix;
	}

	public boolean[] getP4Matrix() {
		return p4Matrix;
	}

	public void setP4Matrix(boolean[] p4Matrix) {
		this.p4Matrix = p4Matrix;
	}

	public boolean isGameEnd() {
		return gameEnd;
	}

	public void setGameEnd(boolean gameEnd) {
		this.gameEnd = gameEnd;
	}

	public int getWhoseTurn() {
		return whoseTurn;
	}

	public void setWhoseTurn(int whoseTurn) {
		this.whoseTurn = whoseTurn;
	}

	public int getWhomWon() {
		return whomWon;
	}

	public void setWhomWon(int whomWon) {
		this.whomWon = whomWon;
	}

	public void setP1Matrix(boolean[] p1Matrix) {
		this.p1Matrix = p1Matrix;
	}

	public void setP2Matrix(boolean[] p2Matrix) {
		this.p2Matrix = p2Matrix;
	}

	public void setTurnNumber(int turnNumber) {
		this.turnNumber = turnNumber;
	}
	public void startGame2()
	{
			p1Matrix[0] = true;
			p2Matrix[1] = true;
			p3Matrix[2] = true;
			p4Matrix[3] = true;
		
			player1.add(1);
			player2.add(1);
			player3.add(1);
			player4.add(1);
		
			player1.add(2);
			player2.add(2);
			player3.add(2);
			player4.add(2);
			
			player1.add(3);
			player2.add(4);
			player3.add(5);
			player4.add(6);
	}

	


	
}