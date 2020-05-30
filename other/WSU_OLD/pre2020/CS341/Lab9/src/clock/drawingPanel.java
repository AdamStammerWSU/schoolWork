package clock;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;

import javax.swing.JPanel;
/*
 * 
 * to display the drawing (or not) as expected by the application
 * 
 * 
 */

public class drawingPanel extends JPanel {

	int x1, y1, x2, y2;
	
	
	public drawingPanel()
	{
		x1 = 50;
		y1 = 100;
		x2 = 50;
		y2 = 200;
		
		


		this.setPreferredSize(new Dimension(200,200));
	}
	

	boolean clear = false;

	
	public void paintComponent(Graphics g)
	{
		super.paintComponent(g);
		
		if (!clear)
		{
			Graphics2D g2d = (Graphics2D) g;
			
			g2d.setColor(Color.RED);
			
			g2d.setStroke(new BasicStroke(5));
			
			g2d.drawLine(x1, y1, x2, y2);
			
			
			g2d.setColor(Color.BLUE);

		}
	}
	
}
