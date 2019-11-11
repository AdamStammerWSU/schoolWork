/*
 * 
 * Adam Stammer
 * CS 341 - Data Structures
 * Exam 1 - Project
 * 10/1/2018
 * 
 */
package exam1;

import ars.linkedlist.NodeList;
import ars.linkedlist.NodePoint;

public class main {

	public static void main(String[] args) {
		NodeList n = new NodeList();
		n.append(8, 34);
		n.append(4, 4);
		n.append(3, -1);
		
		NodePoint p = null;
		while((p = n.next()) != null) {
			System.out.println("X: " + p.getX() + "Y: " + p.getY());
		}
	}

}
