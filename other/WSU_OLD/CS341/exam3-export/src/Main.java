
/*
 * 
 * Adam Stammer
 * 12/3/2018
 * Coded for Exam 3 of Data Structures (Iyengar, Winona State University)
 * 
 */

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;

public class Main {

	public static void main(String[] args) {
		HashMap<String, Node> nodes = readLists("Edge.dat"); // read in the data
		String nodeNames = nodes.get("nodeNames").name; // get the names of the nodes gathered
		for (int i = 0; i < nodeNames.length(); i++) { // loop through each node by name
			String nodeName = nodeNames.substring(i, i + 1); // get the name of the node
			System.out.print(nodeName); // and print it
			Node n = nodes.get(nodeName); // get the node from the list
			System.out.print(" " + n.degree); // and print the degree
			System.out.print(" " + n.totalWeight + "\n"); // and the total weight
		}
	}
	
	//read the nodes from the file and store them in a hashmap
	public static HashMap<String, Node> readLists(String fileName) {
		FileReader fr = null; // setup a file reader and open the file
		try {
			fr = new FileReader(fileName);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		char c[] = new char[500];
		try {
			fr.read(c);
		} catch (IOException e) {
			e.printStackTrace();
		} // read from the file and then split the data into a string list
		String s = new String(c); // this is our string of data
		String lists[] = s.split("\n");
		for (int i = 0; i < lists.length; i++) {
			lists[i] = lists[i].trim();
		}
		// now we have a list of strings for each line ([node] [node] [weight])

		// now lets create a list of nodes
		HashMap<String, Node> nodes = new HashMap<String, Node>();
		String nodeNames = "";
		for (int x = 0; x < lists.length; x++) { // loop through each string list
			String[] data = lists[x].split(" "); // pull each data point out into a list
			String nodeNameOne = data[0].toUpperCase();
			String nodeNameTwo = data[1].toUpperCase();
			int pathWeight = Integer.parseInt(data[2]);

			// now check to see if the first node exists
			Node n = null;
			boolean newN = false;
			if (nodeNames.contains(nodeNameOne)) { // it does exist
				n = nodes.get(nodeNameOne);
			} else { // it doesn't exist
				// make the node
				n = new Node(nodeNameOne);
				newN = true;
				nodeNames += nodeNameOne; // add the node name to the list
			}
			// now add the path the node
			n.addPath(pathWeight);
			if (newN)
				nodes.put(nodeNameOne, n);

			// reset variables
			n = null;
			newN = false;

			// now do it all again with the second node
			if (nodeNames.contains(nodeNameTwo)) { // it does exist
				n = nodes.get(nodeNameTwo);
			} else { // it doesn't exist
				// make the node
				n = new Node(nodeNameTwo);
				newN = true;
				nodeNames += nodeNameTwo; //add the nodeName to the list
			}
			// now add the path the node
			n.addPath(pathWeight);
			if (newN) // and the node to the list if necessary
				nodes.put(nodeNameTwo, n);
		}

		// add placeholder node to pass along the names of all the nodes
		nodes.put("nodeNames", new Node(nodeNames));

		return nodes; //return the collected nodes
	}
}
