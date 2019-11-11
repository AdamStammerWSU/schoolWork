
/*
 * 
 * Adam Stammer
 * 12/3/2018
 * Coded for Exam 4 of Data Structures (Iyengar, Winona State University)
 * 
 */

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class Main {

	public static void main(String[] args) {
		NodeMap nodeMap = readLists("Edge.dat"); // read the data and store the NodeMap
		nodeMap.removeHighestNode(); // remove the highest Node
		nodeMap.islandNodes();// and check for island nodes
	}

	// read the nodes from the file and store them in a hashmap
	public static NodeMap readLists(String fileName) {
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
		String nodeNames = "";
		for (int x = 0; x < lists.length; x++) { // loop through each string list
			String[] data = lists[x].split(" "); // pull each data point out into a list
			String nodeNameOne = data[0].toUpperCase();
			String nodeNameTwo = data[1].toUpperCase();

			// now check to see if the first node exists
			if (!nodeNames.contains(nodeNameOne)) { // it the node hasn't been found yet
				nodeNames += nodeNameOne; // add the node name to the list
			}

			// now do it all again with the second node
			if (!nodeNames.contains(nodeNameTwo)) { // it hasn't been seen yet
				nodeNames += nodeNameTwo; // add the nodeName to the list
			}
		}
		// now we have built the node name list

		// so now loop through the data again to actually add the edge data
		NodeMap nodeMap = new NodeMap(nodeNames);
		for (int x = 0; x < lists.length; x++) { // loop through each string list
			String[] data = lists[x].split(" "); // pull each data point out into a list
			String nodeNameOne = data[0].toUpperCase();
			String nodeNameTwo = data[1].toUpperCase();
			int pathWeight = Integer.parseInt(data[2]);

			nodeMap.addEdge(nodeNameOne, nodeNameTwo, pathWeight); // add the edge with the known nodes
		}

		return nodeMap; // return the collected nodes
	}
}
