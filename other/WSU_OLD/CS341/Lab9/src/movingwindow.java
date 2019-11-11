import javax.swing.JFrame;

public class movingwindow {

	public static void main(String[] args) throws InterruptedException {
		// TODO Auto-generated method stub

		
		JFrame win = new JFrame("moving?");
		
		win.setSize(100, 100);
		
		win.setVisible(true);
		
		int xloc = 50, yloc = 50;
		
		win.setLocation(xloc, yloc);
		
		for (int i = 0; ; i++)
		{
			
			yloc += 10;
			xloc += 10;
			
			Thread.currentThread().sleep(100);// auto refresh
			
			win.setLocation(xloc, yloc);
			
		}
		
		
		
		
	}

}
