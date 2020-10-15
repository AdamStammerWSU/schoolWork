package edu.wsu.se;
import java.io.FileNotFoundException;


public class Driver {

	
	public static void main(String[] args) throws FileNotFoundException {
		// TODO Auto-generated method stub
		
		
		
		//Start
		Player p1 = new Player();
		p1.Player(1, "");
		Player p2 = new Player();
		p2.Player(2, "");
		Player p3 = new Player();
		p2.Player(3, "");
		Player p4 = new Player();
		p2.Player(4, "");
		
		Game g = new Game(p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		g.startGame2();
		//g.startGame();
		System.out.println("Start");
		System.out.println("Turn Number: "+g.turnNumber);
		System.out.println(p1.displayHand());
		System.out.println(p2.displayHand());
		System.out.println(p3.displayHand());
		System.out.println(p4.displayHand());
		System.out.println(g.displayMatrix());
		
		//Turn 1
		g.newTurn(1, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p1.addNumber(1);
		g.newTurn(2, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p2.addNumber(1);
		g.newTurn(3, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p3.addNumber(1);
		g.newTurn(4, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p4.addNumber(1);
		System.out.println("Turn 1");
		System.out.println("Turn Number: "+g.turnNumber);
		System.out.println(p1.displayHand());
		System.out.println(p2.displayHand());
		System.out.println(p3.displayHand());
		System.out.println(p4.displayHand());
		System.out.println(g.displayMatrix());
		
		
		//Turn 2
		g.newTurn(1, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p1.addNumber(1);
		g.newTurn(2, 3,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p2.addNumber(3);
		g.newTurn(3, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p3.addNumber(1);
		g.newTurn(4, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p4.addNumber(1);
		System.out.println("Turn 2");
		System.out.println("Turn Number: "+g.turnNumber);
		System.out.println(p1.displayHand());
		System.out.println(p2.displayHand());
		System.out.println(p3.displayHand());
		System.out.println(p4.displayHand());
		System.out.println(g.displayMatrix());
		
		//Turn 3
		g.newTurn(1, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p1.addNumber(1);
		g.newTurn(2, 5,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p2.addNumber(5);
		g.newTurn(3, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p3.addNumber(1);
		g.newTurn(4, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p4.addNumber(1);
		System.out.println("Turn 3");
		System.out.println("Turn Number: "+g.turnNumber);
		System.out.println(p1.displayHand());
		System.out.println(p2.displayHand());
		System.out.println(p3.displayHand());
		System.out.println(p4.displayHand());
		System.out.println(g.displayMatrix());
		
		//Turn 4
		g.newTurn(1, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p1.addNumber(1);
		g.newTurn(2, 6,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p2.addNumber(6);
		g.newTurn(3, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p3.addNumber(1);
		g.newTurn(4, 1,p1.getHand(),p2.getHand(),p3.getHand(),p4.getHand());
		p4.addNumber(1);
		System.out.println("Turn 4");
		System.out.println(p1.displayHand());
		System.out.println(p2.displayHand());
		System.out.println(p3.displayHand());
		System.out.println(p4.displayHand());
		System.out.println(g.displayMatrix());
	}
}
