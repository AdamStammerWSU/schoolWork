package getnodes;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class collectnodes {

	public static void main(String[] arg) throws FileNotFoundException {
		Scanner inp = new Scanner(new File("edges.dat"));

		node[] nodes = new node[20];
		int count = 0;

		while (inp.hasNext()) {
			String s = inp.next();

			String d = inp.next();

			int v = inp.nextInt();

			boolean f = false;

			int i = 0;
			while (i < count) {
				if ((nodes[i].name).equals(s)) {
					f = true;
					break;
				} else
					i++;
			}

			if (!f) {
				nodes[count] = new node();
				nodes[count].name = s;
				nodes[count].addConnection(d, v);
//				nodes[count].connect = 1;
//				nodes[count].totw = v;
				count++;
			} else {
				// nodes[i].connect++;
				// nodes[i].totw += v;
				nodes[i].addConnection(d, v);

			}

			f = false;
			i = 0;
			while (i < count) {
				if ((nodes[i].name).equals(d)) {
					f = true;
					break;
				} else
					i++;
			}

			if (!f) {
				nodes[count] = new node();
				nodes[count].name = d;
				nodes[count].addConnection(s, v);
//				nodes[count].connect = 1;
//				nodes[count].totw = v;
				count++;
			} else {
//				nodes[i].connect++;
//				nodes[i].totw += v;

				nodes[i].addConnection(s, v);
			}

		}

		for (int j = 0; j < count; j++) {
			System.out.println(nodes[j].name + " " + nodes[j].connect + " " + nodes[j].totw);
		}

		System.out.println("New Output (Bonus):");
		node degree = nodes[0];
		node averageW = nodes[0];
		node least = nodes[0];
		for (int i = 1; i < nodes.length; i++) { // loop through the nodes
			if (nodes[i] != null) {
				node iN = nodes[i];
				if (iN.connect > degree.connect)
					degree = nodes[i];

				if ((iN.totw / iN.connect) > (averageW.totw / averageW.connect)) {
					averageW = nodes[i];
				}

				if (iN.connect < least.connect)
					least = iN;
			}
		}
		System.out.println("Node " + degree.name + " has the most connections with a degree of " + degree.connect);
		System.out.println(
				"Node " + averageW.name + " has the highest average weight of " + (averageW.totw / averageW.connect));
		System.out.println("Node " + least.name + " has the least number of adjacent nodes. They are as follows: ");
		for (int i = 0; i < least.adjNodes().length; i++) {
			if (least.adjNodes()[i] != null)
				System.out.println("\t" + least.adjNodes()[i]);
		}
	}

}
