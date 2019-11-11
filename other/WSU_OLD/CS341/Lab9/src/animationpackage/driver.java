package animationpackage;

public class driver {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		gui g = new gui();
		listener l = new listener();
		g.setlistener(l);
		l.setgui(g);
	}

}
