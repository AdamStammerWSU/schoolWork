
public class NodeMap {

	int[][] adjMatrix;
	String nodeNames;

	public NodeMap(String nodeNames) {
		this.nodeNames = nodeNames; // initialize the nodeNameList
		adjMatrix = new int[nodeNames.length()][nodeNames.length()]; // and the adjacency matrix
		for (int i = 0; i < nodeNames.length(); i++) { // fill the matrix with a bunch of non edges
			for (int j = 0; j < nodeNames.length(); j++) {
				adjMatrix[i][j] = -1;
			}
		}
	}

	public void addEdge(String node1, String node2, int distance) {
		int indexNode1 = nodeNames.indexOf(node1); // find the index of each given node
		int indexNode2 = nodeNames.indexOf(node2);
		if (indexNode1 != -1) { // if the node is known to exist
			adjMatrix[indexNode1][indexNode2] = distance;
			adjMatrix[indexNode2][indexNode1] = distance;// add the edge to the nodes
		} else { // otherwise complain (this is really a debug statement)
			System.out.println("The requested Node does not exist.");
		}
	}

	public void removeHighestNode() {
		// start by finding the highest node
		// so loop through all the nodes string the index of which ndoe has the highest
		// degree
		int highestDegree = 0;
		int highestDegreeIndex = 0;
		int currentDegree = 0;
		for (int i = 0; i < nodeNames.length(); i++) {
			currentDegree = degree(nodeNames.charAt(i));
			if (currentDegree > highestDegree) { // we have a new higest node
				highestDegree = currentDegree; // so store the index and degree
				highestDegreeIndex = i;
			}
		}

		// Now we should have the highest degree node
		System.out.println("Node with the highest degree is " + nodeNames.charAt(highestDegreeIndex) + ".");

		// now lets remove it
		for (int i = 0; i < nodeNames.length(); i++) {
			if (adjMatrix[highestDegreeIndex][i] > 0) { // there is an edge here at the highest node
				// remove that edge from both nodes and mark the highest node as removed (-2
				// instead of -1)
				adjMatrix[highestDegreeIndex][i] = -2;
				adjMatrix[i][highestDegreeIndex] = -1;
			}
		}
		System.out.println("Node " + nodeNames.charAt(highestDegreeIndex) + " has been removed.");
	}

	public void islandNodes() {
		String islandNodes = "";
		for (int i = 0; i < nodeNames.length(); i++) { // loop through each node
			// and check if it's degree is 0 (island node)
			if (degree(nodeNames.charAt(i)) == 0) {
				islandNodes += nodeNames.charAt(i); // add the island node the island node list
			}
		}
		if (islandNodes.length() <= 0) { // check to see if there actually are any island node
			System.out.println("There are no nodes with no edges!");
		} else { // if there are, print them out
			System.out.print("Nodes with no edges: ");
			for (int i = 0; i < islandNodes.length(); i++) {
				System.out.print(islandNodes.charAt(i) + " ");
			}
			System.out.print("\n");
		}
	}

	public int degree(char node) {
		int indexNode = nodeNames.indexOf(node); // find the index of the node to check
		int degree = 0;
		for (int i = 0; i < adjMatrix[indexNode].length; i++) { // count how many edges there are
			int adjMat = adjMatrix[indexNode][i];
			if (adjMat > 0)
				degree++;
			else if (adjMat == -2) {// this node has been removed
				return -2;
			}
		}
		return degree;
	}

}
