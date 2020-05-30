package ars.linkedlist;

public class NodeList {

	NodePoint first, end, pointer;

	public NodeList() {
		first = null;
		end = first;
		pointer = first;
	}

	public void append(NodePoint n) {
		if (first == null) {
			first = n;
			end = first;
			pointer = first;
		} else {
			end.next = n;
			end = end.next;
		}
	}

	public void append(int x, int y) {
		append(new NodePoint(x, y));
	}

	public NodePoint next() {
		NodePoint p = pointer;
		pointer = pointer.next;
		return p;
	}

	public void resetPointer() {
		pointer = first;
	}
}
