import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.StringTokenizer;

public class Driver {

	
	
	public static void main(String[] args) throws FileNotFoundException {
		// TODO Auto-generated method stub
		DataManager dm = new DataManager();
		
		//Get File and Put into Lists
		dm.countJobs();
		dm.retrieveFile();
		
		//Start Transfer
		dm.FCFSRound();
		
		//Final Time
		dm.finalTime();
	}

}
