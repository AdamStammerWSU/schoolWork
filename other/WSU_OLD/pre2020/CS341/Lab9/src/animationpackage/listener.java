package animationpackage;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class listener implements ActionListener {

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub

		JButton clicked = (JButton) e.getSource();
		
		String txt = clicked.getText();
		
		JPanel panel;
		if (txt.equals("Draw"))
		{
			System.out.println(txt);
			
			panel = new JPanel() 
			{
				protected void paintComponent(Graphics g)
				{
					super.paintComponent(g);
					g.drawLine(50, 50, 100, 100);
					
				}
			};

		}
		else
		{
			System.out.println(txt);
			panel = new JPanel() 
			{
				protected void paintComponent(Graphics g)
				{
					super.paintComponent(g);
//					g.drawLine(0, 0, 200, 200);
					
				}
			};
		}

		panel.setSize(250, 250);
		g.drawingpanel.removeAll();
		g.drawingpanel.add(panel);

		g.drawingpanel.repaint();

	}
		


	gui g;
	
	public void setgui(gui G)
	{
		g = G;
	}
}
