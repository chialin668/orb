package com.orb.sys;

import java.util.Vector;

public class Record {

	private Vector recVect = new Vector();

	public void add(String field) {
		recVect.add(field);
	}

	public String get(int i) {
		return (String) recVect.elementAt(i);
	}


}