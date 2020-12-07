package edu.os.as;

import java.util.Calendar;

public class Clock {

	long stime;

	public Clock() {
		stime = Calendar.getInstance().getTime().getTime();
	}

	long getTime() {
		return Calendar.getInstance().getTime().getTime() - stime;

	}

}
