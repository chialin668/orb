package com.orb.sys;

import java.util.*;

public class Connections {

	public static void main(String args[]) {


		Vector v = new Vector();
		v.add("1");
		v.add("2");
		v.add("3");
		v.add("4");
		v.add("5");
		v.add("6");


		for (int i=0;i<v.size();i++)
			System.out.println(i + ": " + v.elementAt(i));

		v.remove(3);

		for (int i=0;i<v.size();i++)
			System.out.println(i + ": " + v.elementAt(i));


	}

}