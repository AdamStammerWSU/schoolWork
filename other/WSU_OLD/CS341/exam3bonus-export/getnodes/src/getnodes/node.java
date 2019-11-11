package getnodes;

public class node {

	String name = "";
	int connect = 0, totw = 0;

	String[] adjNodes = new String[20];

	public void addAdjNode(String n) {
		for (int i = 0; i < adjNodes.length; i++) {
			if (adjNodes[i] == null) {
				adjNodes[i] = n;
				break;
			}
		}
	}

	public void addConnection(String name, int weight) {
		connect++;
		addAdjNode(name);
		totw += weight;
	}

	public String toString() {
		return name;
	}

	public String[] adjNodes() {
		return adjNodes;
	}

}
