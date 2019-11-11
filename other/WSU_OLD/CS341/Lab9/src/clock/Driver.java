package clock;
import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;

import javax.swing.JFrame;

/*
 * 
 * creates the buttonpanel, the drawingpanel, the listener and hooks them up 
 * 
 * 
 * 
 */
public class Driver {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		buttonpanel bpanel = new buttonpanel();
		drawingPanel dpanel = new drawingPanel();
		
		listener mylistener = new listener();
		
		bpanel.setlistener(mylistener);
		
		mylistener.setdpanel(dpanel);
		
		JFrame window = new JFrame();
		
		window.setVisible(true);
		
		window.setSize(new Dimension(500,500));
		
		Container canvas = window.getContentPane();
		
		canvas.setLayout(new BorderLayout());
		canvas.add(bpanel, BorderLayout.WEST);
		canvas.add(dpanel, BorderLayout.EAST);
		
		
		window.pack();
		
	}

}
