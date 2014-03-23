package com.orb.sys;

/*
class Poing {
	private int x;
	private int y;

	public void put(int x, int y) {
		this.x = x;
		this.y = y;
	}

	public int getX() {return x; }
	public int getY() {return y; }

}
*/


// save all the data retrieved from sar here!!

import java.util.Hashtable;
import java.util.Vector;

public class SarData {
	private String CLASSNAME = this.getClass().getName();
	private static int MAX	= 150; //@@@

	private static Hashtable machineTab = new Hashtable();

	public void put(String machine, String tag, String value) {
		Hashtable dataTab = (Hashtable) machineTab.get(machine);
		if (dataTab == null) {
			dataTab = new Hashtable();
			machineTab.put(machine, dataTab);
		}

		Vector valueVect = (Vector) dataTab.get(tag);
		if (valueVect == null) {
			valueVect = new Vector();
			dataTab.put(tag, valueVect);
		}

		int size = valueVect.size();
		if (size >= MAX)
			valueVect.removeElementAt(0);  //remove the first one

		valueVect.add(value);
	}

	public Vector getDataVect(String machine, String tag) {
		String METHODNAME = "getDataVect";
		Hashtable dataTab = (Hashtable) machineTab.get(machine);
		if (dataTab == null) {
			String message = "Machine:" + machine + " not found from the data table"
							+ " Add the data first!";
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return null;
		}
		Vector valueVect = (Vector) dataTab.get(tag);
		return valueVect;
	}

	public static void main(String args[]) {

		// first
		UnixSar us = new UnixSar("devdcx", "oracle", "oracle00", "", "5", "50");
		us.start();

		for (int i=0;i<25;i++) {
			try { Thread.sleep(7000); } catch (java.lang.InterruptedException e) {}

			SarData s = new SarData();
			s.put("devdcx", "%idle", us.get("%idle"));
			s.put("devdcx", "%usr", us.get("%usr"));

			// generate points on the fly...
			CordConverter cc = new CordConverter();
			String retStr = "";
			Vector v = s.getDataVect("devdcx", "%idle");
			for (int j=0;j<v.size();j++) {


				retStr = retStr + cc.getX() + " "
					+ cc.getY(Integer.parseInt((String) v.elementAt(j))) + " ";
			}
			System.out.println(retStr);

		}


	}

}