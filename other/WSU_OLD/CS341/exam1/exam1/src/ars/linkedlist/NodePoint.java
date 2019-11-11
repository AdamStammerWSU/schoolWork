package ars.linkedlist;

public class NodePoint {
	
	int x, y;
	NodePoint next, parent;
	
	public NodePoint(int x, int y) {
		this.x = x;
		this.y = y;
	}
	public NodePoint(int x, int y, NodePoint parent) {
		this(x, y);
		this.parent = parent;
	}
	public NodePoint(int x, int y, NodePoint parent, NodePoint next) {	
		this(x, y, parent);
		this.next = next;
	}
	
	public void setNext(NodePoint next ) {
		this.next = next;
	}
	public void setParent(NodePoint parent) {
		this.parent = parent;
	}
	public void setPoint(int x, int y) {
		this.x = x;
		this.y = y;
	}
	
	public int getX() {
		return x;
	}
	public int getY() {
		return y;
	}
}
