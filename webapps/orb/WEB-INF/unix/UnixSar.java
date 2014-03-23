package com.orb.unix;

import java.util.*;
import com.orb.sys.*;

public class UnixSar extends Thread{
	private String CLASSNAME = this.getClass().getName();

	private UnixSharedData usd = new UnixSharedData();
	private TelnetClient tc;
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



    public UnixSar(String host, String username, String password,
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

//		notifyAll();

	}

	public synchronized String get(String colName) {
/*
		if (!hasFirstOne) {
			try {
                wait();
				hasFirstOne = true;
            } catch (InterruptedException e) { }
		}
*/
		Hashtable dataTab = (Hashtable) statTab.get(host);
		if (dataTab == null)
			return "0";

		String retStr = (String) dataTab.get(colName);
		if (retStr != null && !retStr.equals(""))
			return retStr;
		else {
//			System.out.println("==============");
			return "0";
		}
	}


	public String getStatus() {
		return status;
	}


	public void run() {
		String METHODNAME = "run";

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

		if (!tc.connect(host, port)) {
			String message = "Error connecting to server: " + host + " on port: " + port
							+ "by: " + username;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			// @@@ stop???
			return;
		}

		if (!tc.login(username, password)) {
			String message = "Error logging to server: " + host + " on port: " + port
							+ " by login: " + username;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			// @@@ stop???
			return;
		}
		String command = "";

		if (option.equals(""))
			command = "sar" + option
					+ " " + interval
					+ " " + count;
		else
			command = "sar -" + option
								+ " " + interval
					+ " " + count;

//System.out.println(command);
		if (!tc.execute(command)) {
			String message = "Error executing command: " + command + " on host: " + host
							+ "by: " + username;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			// @@@ stop???
			return;
		}

		if(!tc.execute("echo status=$?")) {
			String message = "Error executing command: " + "echo status=$?"
							+ " to retrieve status from " + " on host: " + host;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			// @@@ stop???
			return;
		}


		boolean loop = true;
		boolean start = false;

		while(loop) {
			String outStr = usd.get();
			byte[] b = {10};
			byte[] buff = {10, 13};
			String eof = new String(buff);
			StringTokenizer st = new StringTokenizer(outStr, eof);

			while (st.hasMoreTokens()) {

				String tmpStr = st.nextToken();

				// @@@
//System.out.println("next: ->" + tmpStr + "|");

				// column names
				//if (!start && (tmpStr.indexOf("bread/s") != -1)) {
				if (!start && (tmpStr.indexOf("%usr") != -1)) {
					start = true;

					StringTokenizer st1 = new StringTokenizer(tmpStr);

					String timeStamp = st1.nextToken();
					colVect.add("Time");
					dataTab.put("Time", timeStamp);

					while (st1.hasMoreTokens()) {
						String colName = st1.nextToken();
//System.out.println(colName);

						colVect.add(colName);		// we want the order
						dataTab.put(colName, "");  	// init the table
					}

					// we don't want this line to be added to the data hash table
					continue;
				}

				// We are done!!
				if (start && (tmpStr.indexOf("Average") != -1))
					start = false;

				// data
				if (start) {

					//System.out.println("|" + tmpStr+ "+");
					StringTokenizer st1 = new StringTokenizer(tmpStr);

					for (int i=0;i<colVect.size();i++) {
						String colName = (String) colVect.elementAt(i);
						String data = st1.nextToken();

						this.put(colName, data);
						//System.out.println(colName + " : " + data);
					}
				}

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					status = tmpStr.substring(7);
					//System.out.println("*****status = " + status);

					if (!tc.close()) {
						String message = "Error closing connection from: " + host;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									null,
									message);
						// @@@ stop???
						return;
					}

					loop = false;
					break;
				}

			}
		}

		// this one is done
		statTab.remove(host);

	}

	public boolean close() {
		String METHODNAME = "run";

		if(!tc.close()) {
			String message = "Error closing connection from: " + host;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return false;
		}

		return true;
	}

	public String getHtmlTextField(String colName) {

		String retStr = "<FORM NAME=form1>"
			+ "<INPUT TYPE=\"text\" NAME=text1 value=\"" + this.get(colName) + "\"><BR>"
			+ "</FORM>";
		return retStr;
	}


	public static void main(String args[]) {

		// first
		UnixSar us = new UnixSar("devdcx", "oracle", "oracle00", "", "5", "50");
		us.start();

		UnixSar us1 = new UnixSar("devsql", "oracle", "oracle00", "", "5", "50");
		us1.start();


		for (int i=0;i<10;i++) {
			try { Thread.sleep(7000); } catch (java.lang.InterruptedException e) {}

			String idle = us.get("%idle");
			String usr = us.get("%usr");
			System.out.print("devdcx: " + idle + "," + usr);

			idle = us1.get("%idle");
			usr = us1.get("%usr");
			System.out.println("  devsql: " + idle + "," + usr);


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
