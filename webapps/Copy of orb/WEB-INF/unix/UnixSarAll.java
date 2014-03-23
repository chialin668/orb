package com.orb.unix;

import java.util.*;

public class UnixSarAll extends Thread{

	private UnixSharedData usd = new UnixSharedData();
	private Vector colVect = new Vector();
	private static Hashtable statTab = new Hashtable();
//	private Hashtable dataTab = new Hashtable();
	private String host;
	private int port = 23;
	private String username;
	private String password;
	private String option;
	private String interval;
	private String count;

    private WebSharedData wsd;
    private String data;
    private String status;
	private boolean hasFirstOne = false;



    public UnixSarAll(String host, String username, String password,
    			String option, String interval, String count) {
        this.host = host;
        this.username = username;
        this.password = password;
        this.option = option;
        this.interval = interval;
        this.count = count;

    }

	public synchronized void put(String colName, String data) {
		Hashtable dataTab = (Hashtable) statTab.get(host);

		String avgData = (String) dataTab.get(colName);

		// first time
		if (avgData.equals("")) {
			dataTab.put(colName, data);
			return;
		}

		// time stamp
		if (colName.equals("Time")) {
			dataTab.put(colName, data);
			return;
		}

		//float avg = new Float(avgData).floatValue();
		//float newData = new Float(data).floatValue();
		//avg = (avg + newData) / 2;
		//dataTab.put(colName, new Float(avg).toString());
		dataTab.put(colName, data);
//		System.out.println("put: " + colName + ":" + data);

		notifyAll();

	}

	public synchronized String get(String colName) {

		if (!hasFirstOne) {
			try {
                wait();
				hasFirstOne = true;
            } catch (InterruptedException e) { }
		}

		Hashtable dataTab = (Hashtable) statTab.get(host);
		if (dataTab == null)
			return "0";

		String retStr = (String) dataTab.get(colName);
		if (retStr != null && !retStr.equals(""))
			return retStr;
		else {
			System.out.println("==============");
			return "0";
		}
	}


	public String getStatus() {
		return status;
	}


	public void run() {
		Hashtable dataTab = (Hashtable) statTab.get(host);

		// a thread has already be running?
		if (dataTab != null) {
			return;

		} else {
			dataTab = new Hashtable();
			statTab.put(host, dataTab);
		}

		// ---------------------
		TelnetClient tc = new TelnetClient(System.in, usd);
		tc.connect(host, port);
		tc.login(username, password);
		String command = "";

		if (option.equals(""))
			command = "sar" + option
					+ " " + interval
					+ " " + count;
		else
			command = "sar -" + option
								+ " " + interval
					+ " " + count;

		System.out.println(command);
		tc.execute(command);
		tc.execute("echo status=$?");


		boolean loop = true;
		boolean start = false;
		String myStr = "";

		while(loop) {
			String outStr = usd.get();
			byte[] b = {10};
			byte[] buff = {10, 13};
			String eof = new String(buff);
			StringTokenizer st = new StringTokenizer(outStr, eof);

			while (st.hasMoreTokens()) {

				String tmpStr = st.nextToken();

				StringTokenizer st1 = new StringTokenizer(tmpStr);
				System.out.println(st1.countTokens());

				if (tmpStr.length() > 3 && tmpStr.substring(2,3).equals(":")) {
					System.out.println("New One!!!!!!!!!!!");
					myStr = "";
				}

				System.out.println("next: ->" + tmpStr + "|");

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					status = tmpStr.substring(7);
					//System.out.println("*****status = " + status);
					tc.close();
					loop = false;
					break;
				}

			}
		}

		// this one is done
		statTab.remove(host);

	}


	public String getHtmlTextField(String colName) {

		String retStr = "<FORM NAME=form1>"
			+ "<INPUT TYPE=\"text\" NAME=text1 value=\"" + this.get(colName) + "\"><BR>"
			+ "</FORM>";
		return retStr;
	}


	public static void main(String args[]) {

		// first
		UnixSarAll us = new UnixSarAll("devdcx", "oracle", "oracle00", "A", "5", "50");
		us.start();

		for (int i=0;i<10;i++) {
			try { Thread.sleep(7000); } catch (java.lang.InterruptedException e) {}
			String idle = us.get("%idle");
			if (idle != null)
				System.out.print(idle + ",");

			String usr = us.get("%usr");
			if (usr != null)
				System.out.println(usr);
		}
/*
		// second
		UnixSar us1 = new UnixSar("devdcx", "oracle", "oracle00", "b", "5", "50");
		us1.start();

		for (int i=0;i<3000;i++) {
			try { Thread.sleep(5000); } catch (java.lang.InterruptedException e) {}
			String retStr = us1.get("lread/s");
			if (retStr != null)
				System.out.println("-->" + retStr);
		}
*/


	}
}
