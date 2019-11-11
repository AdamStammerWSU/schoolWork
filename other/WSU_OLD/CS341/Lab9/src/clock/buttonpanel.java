package clock;

import java.awt.Dimension;

import javax.swing.JButton;
import javax.swing.JPanel;
/*
 * 
 * a panel that will be used to display buttons
 * 
 */

public class buttonpanel extends JPanel {
	
	JButton draw = new JButton("Draw");
	JButton clear = new JButton("Clear");
	
	listener list;
	
	public buttonpanel()
	{
		this.setPreferredSize(new Dimension(100,100));
		
		Dimension d = new Dimension(50,50);
		
		draw.setSize(d);
		clear.setSize(d);
		
		this.add(draw);
		this.add(clear);
		
		
	}
	

	public void setlistener(listener mylistener) {
		// TODO Auto-generated method stub
		
		list = mylistener;
		
		draw.addActionListener(list);
		clear.addActionListener(list);
		
	}

}
