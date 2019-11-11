package animationpackage;
import java.awt.Dimension;
import java.awt.Graphics;

import javax.swing.JFrame;
import javax.swing.JPanel;


public class movingwindow {

	public static void main(String[] args) throws InterruptedException 
	{
		// TODO Auto-generated method stub

		JFrame win = new JFrame();
		
		win.setSize(new Dimension(400,400));
		
		win.setLocation(0, 100);
		
		win.setVisible(true);
		
		JPanel myPanel = new JPanel() {

		    protected void paintComponent(Graphics g) {
		        super.paintComponent(g);
		        g.drawLine(0,0, 200, 300);
		       
		    }
		};
		
		JPanel mypanel = new JPanel()
		{
		
		    protected void paintComponent(Graphics g) {
		        super.paintComponent(g);
//		        g.drawLine(0,0, 200, 200);
		       
		    }
		};
		
		// sleeptime is an int and represents time in milliseconds

		win.getContentPane().add(myPanel);
		Thread.currentThread().sleep(1000);  // sleeptime is an int and represents time in milliseconds
//		win.getContentPane().remove(mypanel);
		win.remove(myPanel);
		
		win.getContentPane().add(mypanel);
		win.getContentPane().repaint();
//		win.getContentPane().invalidate();
//		win.getContentPane().validate();
		Thread.currentThread().sleep(1000);  // sleeptime is an int and represents time in milliseconds
		
		
		/*		win.getContentPane().remove(myPanel);

		System.out.println("hello " + i);
		myPanel = new JPanel() {
		    protected void paintComponent(Graphics g) {
		        super.paintComponent(g);
//		        g.drawLine(0,0, 200, 350);
		    }
		};
		win.getContentPane().add(myPanel);
		Thread.currentThread().sleep(1000);  // sleeptime is an int and represents time in milliseconds
		System.out.println("hello " + i);

	*/	
		}
		    /*	
		
		int x = 0;
		
		int sleeptime = 10;
		
		for (int i = 0; i < 1000; i++)
		{
			Thread.currentThread().sleep(sleeptime);  // sleeptime is an int and represents time in milliseconds
			
			x += 1;
			
			win.setLocation(x, 100);
		}
		*/
	}
	

