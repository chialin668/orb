package com.orb.unix;

import java.util.*;
//import java.io.*;
import javax.servlet.jsp.JspWriter;

public class UnixCommand {
	private String CLASSNAME = this.getClass().getName();

	protected static Hashtable connectionTab = new Hashtable();
	protected static Hashtable sharedDataTab = new Hashtable();
	protected UnixSharedData usd = new UnixSharedData();
	protected TelnetClient telClient;
	protected String host;
	protected String username;
	protected String password;
	protected String retStr;
	protected String status;

	public UnixCommand(String host, String username, String password) {
		this.host = host;
		this.username = username;
		this.password = password;
	}

	public boolean connect() {
		String METHODNAME = "connect";

		telClient = (TelnetClient) connectionTab.get(host);
		if (telClient != null) {
			usd = (UnixSharedData) sharedDataTab.get(host);
			return true;
		}

		telClient = new TelnetClient(System.in, this.usd);
		if(!telClient.connect(host, 23)) {
			String message = "Error connecting to server: " + host;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return false;
		}

		if (!telClient.login(username, password)) {
			String message = "Error logging to server: " + host
							+ " login: " + username
							+ " password: " + password;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return false;
		}

		connectionTab.put(host, telClient);
		sharedDataTab.put(host, usd);
		return true;
	}

	public boolean run(String command) {
		return this.run(command, null);
	}

	/**
	*
	* print right away?
	*
	**/
	public boolean run(String command, JspWriter out) {
		String METHODNAME = "run";

		retStr = "";
		if (!telClient.execute(command)) {
			String message = "Error executing command: " + command
							+ " on server: " + host
							+ " login: " + username
							+ " password: " + password;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return false;
		}

		if (!telClient.execute("echo status=$?")) {
			String message = "Error retrieve status for: " + command
							+ " on server: " + host
							+ " login: " + username
							+ " password: " + password;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return false;
		}

		boolean loop = true;
		while(loop) {
			String outStr = usd.get();
			byte[] buff = {10, 13};
			String eof = new String(buff);

			StringTokenizer st = new StringTokenizer(outStr, eof);
			while (st.hasMoreTokens()) {
				String tmpStr = st.nextToken();
				//System.out.println(tmpStr);
				if (out != null)
					try {
						out.println(tmpStr + "<br>\n");
					} catch (java.io.IOException e) {
						String message = "Error writing the output for command: " + command;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
						return false;
					}
				else
					retStr = retStr + tmpStr + "<br>\n";

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					status = tmpStr.substring(7);
					//System.out.println("*****status = " + status);
					//telClient.close();
					loop = false;
					break;
				}
			}
		}

		return true;
	}


	public String getHtmlTable(String command) {
		String METHODNAME = "getHtmlTable";

		String retStr = "";
		retStr = retStr + "<SCRIPT LANGUAGE=\"JScript\">\n"
						+ "tblUpdate.outerHTML=\"<TABLE ID='tblUpdate' BORDER='1' STYLE='border-collapse:collapse'></TABLE>\";\n"
						+ " var row;\n"
						+ " var cell;\n"
						+ " var tbody = tblUpdate.childNodes[0];\n"
						+ " tblUpdate.appendChild( tbody );\n";

		if (!telClient.execute(command)) {
			String message = "Error executing command: " + command
							+ " on server: " + host
							+ " login: " + username
							+ " password: " + password;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return null;
		}

		if (!telClient.execute("echo status=$?")) {
			String message = "Error retrieve status for: " + command
							+ " on server: " + host
							+ " login: " + username
							+ " password: " + password;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return null;
		}

		boolean loop = true;
		while(loop) {
			String outStr = usd.get();
			byte[] buff = {10, 13};
			String eof = new String(buff);

			retStr = retStr + "  row = document.createElement( \"TR\" );\n"
							+ "  tbody.appendChild( row );\n";

			StringTokenizer st = new StringTokenizer(outStr, eof);
			while (st.hasMoreTokens()) {
				String tmpStr = st.nextToken();
				//System.out.println(tmpStr);
//				retStr = retStr + tmpStr + "\n";

				retStr = retStr + "  row = document.createElement( \"TR\" );\n"
								+ "  tbody.appendChild( row );\n";

				StringTokenizer st1 = new StringTokenizer(tmpStr);
				while (st1.hasMoreTokens()) {
					String nextToken = st1.nextToken();
					retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
									+ "		row.appendChild( cell );\n"
									+ "		cell.innerText = \"" + nextToken + "\";\n";
				}

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					status = tmpStr.substring(7);
					//System.out.println("*****status = " + status);
					//telClient.close();
					loop = false;
					break;
				}
			}
		}

		retStr = retStr + "</SCRIPT>\n";

		return retStr;

	}


	public String getResult() {
		return retStr;
	}

	public String getStatus() {
		return status;
	}

	public boolean close() {

		telClient.close();

		return true;
	}

	public static void main(String args[]) {
/*
		ServerInfo si = new ServerInfo();
		si.init();
		Server s = si.getServerBySid("devdcx");

		UnixCommand tt = new UnixCommand(s.getMachine(),
											s.getUsername(),
											s.getPassword());
		tt.connect();
		tt.run("df -k");
		if (tt.getStatus().equals("0"))
			System.out.println(tt.getResult());

		UnixCommand tt1 = new UnixCommand(s.getMachine(),
											s.getUsername(),
											s.getPassword());
		tt1.connect();
		tt1.run("ls -al");
		if (tt1.getStatus().equals("0"))
			System.out.println(tt1.getResult());

		UnixCommand tt2 = new UnixCommand(s.getMachine(),
											s.getUsername(),
											s.getPassword());
		tt2.connect();
		tt2.run("ls");
		if (tt2.getStatus().equals("0"))
			System.out.println(tt2.getResult());

		UnixCommand tt3 = new UnixCommand(s.getMachine(),
											s.getUsername(),
											s.getPassword());
		tt3.connect();
		tt3.run("ps -ef");
		if (tt3.getStatus().equals("0"))
			System.out.println(tt3.getResult());

		tt.close();
*/
	}
}