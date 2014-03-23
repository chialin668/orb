package com.orb.sys;

import java.util.*;
import java.sql.*;

/**
*
* check in & check out db connection or unix connection
*
**/
public class CheckInOut {
	private String CLASSNAME = this.getClass().getName();
	public static String ORACLE = "ORACLE";
	public static String UNIX 	= "UNIX";

	private int HIGHT_WATER_MARK = 5;

	private static Hashtable typeTab = new Hashtable();
//	private UnixSharedData usd;

	public synchronized Object checkOut(String serverType, String machineName,
								String serverName,
								String username, String password) {
		String 	METHODNAME = "checkOut";

		Hashtable serverTab = (Hashtable) typeTab.get(serverType);
		if (serverTab == null) {
			serverTab = new Hashtable();
			typeTab.put(serverType, serverTab);
		}

		Vector connVect = (Vector) serverTab.get(serverName+username);
		if (connVect == null) {
			connVect = new Vector();
			serverTab.put(serverName+username, connVect);
		}

		// get the first one
		Object conn = null;
		if (connVect.size() > 0) {
			conn = connVect.elementAt(0);
			connVect.remove(0);
			// System.out.println("Found a connection for: " + serverName);
			return conn;

		} else {

			String port = null;
			if (serverType.equals(CheckInOut.ORACLE)) {
				port = "1521";

				try {
					//System.out.println("Create a new connection for: " + serverName);

					DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
					conn = DriverManager.getConnection (
									"jdbc:oracle:thin:@"
										+ machineName + ":" + port + ":" + serverName,
										username, password);
				} catch (SQLException e) {
					String message = "Error getting a connection for type: " + serverType
										+ ", machine: " + machineName
										+ ", server name: " + serverName
										+ ", username: " + username;
					SysLog log = new SysLog();
					log.write(CLASSNAME, METHODNAME,
										SysLog.ML_SEVERE,
										e,
										message);
					return null;
				}
				return conn;

			} else if (serverType.equals(CheckInOut.UNIX)) {
/*				usd = new UnixSharedData();
				TelnetClient tc = new TelnetClient(System.in, usd);

				tc.connect("devdcx", 23);
				tc.login("oracle", "oracle00");
				return tc;
*/
				return null;
			}
		}

		// @@@ Error message
		return null;
	}

//	public UnixSharedData getUnixSharedData() {
//		return usd;
//	}

	public synchronized boolean checkIn(String serverType, String serverName, Object conn, String username) {
		String 	METHODNAME = "checkIn";

		Hashtable serverTab = (Hashtable) typeTab.get(serverType);
		if (serverTab == null) {
			String message = "Error checking in the connection for type: " + serverType;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
            return false;
		}

		Vector connVect = (Vector) serverTab.get(serverName+username);
		if (connVect == null) {
			String message = "Error checking in the connection for name: " + serverName
								+ "username: " + username;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		int count = this.getPoolSize(serverType, serverName, username);
		if (count > HIGHT_WATER_MARK) {
			for (int i=HIGHT_WATER_MARK;i<count;i++)
				connVect.remove(i);
		}

		connVect.add(conn);
		return true;
	}


	public synchronized int getPoolSize(String serverType, String serverName, String username) {
		String 	METHODNAME = "getPoolSize";

		Hashtable serverTab = (Hashtable) typeTab.get(serverType);
		if (serverTab == null) {
			String message = "Server hash table should Not be null but it is.  server type: " + serverType;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
            return -1;
		}

		Vector connVect = (Vector) serverTab.get(serverName+username);
		if (connVect == null) {
			String message = "Connection vector should not be null but it is.  server name: " + serverName
																			+ ", username: " + username;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return -1;
		}

		return connVect.size();
	}


/*

	public static void main(String args[])  {

		CheckInOut cio = null;
		Connection conn = null;

		for (int i=0;i<2;i++) {
			try {
				System.out.println("----->" + System.currentTimeMillis()/1000);
				cio = new CheckInOut();

				conn = (Connection) cio.checkOut(CheckInOut.ORACLE, "devdcx", "DNAC", "system", "oracle00");
				//conn = cio.checkOut("ORACLE", "172.16.1.20", "DGTL", "system", "systempass");

				if (conn == null) System.exit(-1);

				Statement stmt = conn.createStatement ();
				ResultSet rset = stmt.executeQuery ("select username from dba_users");
				while (rset.next ())
				  System.out.println (rset.getString (1));

			} catch (SQLException e) {
					e.printStackTrace();
			}

			cio.checkIn("ORACLE", "DNAC", conn, "system");
		}


		System.out.println(cio.getPoolSize("ORACLE", "DNAC", "system"));
//		System.out.println(cio.getPoolSize("ORACLE", "DGTL", "system"));


		//////////////////////////////////////////////////////////////////////
		for (int i=0;i<4;i++) {
			System.out.println("----->" + System.currentTimeMillis()/1000);
			TelnetClient tc1 = (TelnetClient) cio.checkOut(CheckInOut.UNIX,
							"devdcx", "devdcx", "oracle", "oracle00");
//			tc1.connect("devdcx", 23);
//			tc1.login("oracle", "oracle00");
			tc1.execute("df -k");
			tc1.execute("echo status=$?");
			UnixSharedData usd = cio.getUnixSharedData();

			boolean loop = true;
			while(loop) {
				String outStr = usd.get();
				byte[] buff = {10, 13};
				String eof = new String(buff);

				StringTokenizer st = new StringTokenizer(outStr, eof);
				while (st.hasMoreTokens()) {
					String tmpStr = st.nextToken();
					System.out.println(tmpStr);

					if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
						String status = tmpStr.substring(7);
						System.out.println("*****status = " + status);
						//tc1.close();
						loop = false;
						break;
					}
				}
			}

			cio.checkIn("UNIX", "devdcx", tc1, "system");
		}


		System.out.println("We are here!!");
	}

*/

}