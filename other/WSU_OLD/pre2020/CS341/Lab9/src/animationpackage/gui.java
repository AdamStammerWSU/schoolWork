package animationpackage;

import java.awt.*;

import javax.swing.*;

public class gui extends JFrame {
	
	JButton draw = new JButton ("Draw");
	JButton clear = new JButton ("Clear");

	
	JPanel buttonpanel = new JPanel();
	JPanel drawingpanel = new JPanel();
	
	public gui()
	{
		this.setSize(500,500);
		
		Container canvas = this.getContentPane();
		
		buttonpanel.setPreferredSize(new Dimension(200,200));
		drawingpanel.setPreferredSize(new Dimension(200,200));
		
		buttonpanel.add(draw);
		buttonpanel.add(clear);
		buttonpanel.setBorder(BorderFactory.createLineBorder(Color.red));
		
		canvas.add(buttonpanel, BorderLayout.WEST);
		canvas.add(drawingpanel, BorderLayout.EAST);
		
		
		this.setVisible(true);
		
	}
	
	listener l;
	
	public void setlistener(listener list)
	{
		l = list;
		draw.addActionListener(l);
		clear.addActionListener(l);
	}

}
