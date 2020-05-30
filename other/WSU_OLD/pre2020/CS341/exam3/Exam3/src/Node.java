
public class Node {
	
	int degree, totalWeight; // store the relevant information
	String name = ""; // and the name of the node
	
	public Node(String name) { //create a new node with the given name
		degree = totalWeight = 0; // zero out the storage data
		this.name = name; // set the name to what was given
	}
	
	public void addPath(int weight) { //add a path to the node
		totalWeight += weight; // by increasing the total weight
		degree++; // and increasing the degree
	}
	
}
