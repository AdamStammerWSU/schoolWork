import java.util.LinkedList;

public class Job {

	String jobName;
	int jobPriority;
	int index = 0;
	
	int currentTIO = 0;
	boolean checker = false;
	
	LinkedList<String> list = new LinkedList<String>();
	
	Job nextJob;
	Job prevJob;
	
	Job nextPrio;
	Job prevPrio;
	
	
}

