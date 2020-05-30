package clock;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.Timer;
/*
 * 
 * responds to events as programmed/expected - manipulates the drawing on the drawingpanel
 * 
 * 
 */

public class listener implements ActionListener {

	drawingPanel panel;
	
	
	public listener()
	{
		
	}
	
	
	@Override
	public void actionPerformed(ActionEvent arg0) {
		// TODO Auto-generated method stub

		JButton clicked = (JButton) arg0.getSource();
		
		String txt = clicked.getText();
		
		if (txt.equals("Draw"))
		{
			panel.clear = false;
		}
		else
		{
			panel.clear = true;
		}
		panel.repaint();

	}

	public void setdpanel(drawingPanel dpanel) {
		// TODO Auto-generated method stub
		
		panel = dpanel;
	}

}
