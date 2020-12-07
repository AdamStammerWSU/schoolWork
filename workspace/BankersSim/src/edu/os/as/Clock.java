package edu.os.as;

import java.util.Calendar;

public class Clock {
	long stime;

	public void start() {
		stime = Calendar.getInstance().getTime().getTime(); //set start time
	}

	public void announce(String s) {
		System.out.println(getTime() + ": " + s); //announce with time
	}

	public long getTime() {
		return Calendar.getInstance().getTime().getTime() - stime; //how long has it been since the clock was started
	}
}
