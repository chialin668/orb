import java.util.*;
import java.sql.*;

/**
*
* check in & check out db connection or unix connection
*
**/
public class CheckInOut {
	private String CLASSNAME = this.getClass().getName();
	private int HIGHT_WATER_MARK = 5;

	private static Hashtable typeTab = new Hashtable();


	public synchronized Connection checkOut(String serverType, String machineName,
								String serverName,
								String username, String password) {
		String 	METHODNAME = "checkOut";

		Hashtable serverTab = (Hashtable) typeTab.get(serverType);
		if (serverTab == null) {
			serverTab = new Hashtable();
			typeTab.put(serverType, serverTab);
		}

		Vector connVect = (Vector) serverTab.get(serverName);
		if (connVect == null) {
			connVect = new Vector();
			serverTab.put(serverName, connVect);
		}

		// get the first one
		Connection conn = null;
		if (connVect.size() > 0) {
			conn = (Connection) connVect.elementAt(0);
			connVect.remove(0);
			//System.out.println("Found a connection for: " + serverName);
			return conn;

		} else {

			String port = null;
			if (serverType.equals("ORACLE"))
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
		}
	}


	public synchronized boolean checkIn(String serverType, String serverName, Connection conn) {
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

		Vector connVect = (Vector) serverTab.get(serverName);
		if (connVect == null) {
			String message = "Error checking in the connection for name: " + serverName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		int count = this.getPoolSize(serverType, serverName);
		if (count > HIGHT_WATER_MARK) {
			for (int i=HIGHT_WATER_MARK;i<count;i++)
				connVect.remove(i);
		}

		connVect.add(conn);
		return true;
	}


	public synchronized int getPoolSize(String serverType, String serverName) {
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

		Vector connVect = (Vector) serverTab.get(serverName);
		if (connVect == null) {
			String message = "Connection vector should not be null but it is.  server name: " + serverName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return -1;
		}

		return connVect.size();
	}



	public static void main(String args[])  {
		CheckInOut cio = null;
		Connection conn = null;

		for (int i=0;i<5;i++) {
			try {
				System.out.println("----->" + System.currentTimeMillis()/1000);
				cio = new CheckInOut();

				//conn = cio.checkOut("ORACLE", "devdcx", "DNAC", "system", "oracle00");
				conn = cio.checkOut("ORACLE", "172.16.1.20", "DGTL", "system", "systempass");

				if (conn == null) System.exit(-1);

				Statement stmt = conn.createStatement ();

				ResultSet rset = stmt.executeQuery ("select username from dba_users");
				while (rset.next ())
				  System.out.println (rset.getString (1));

			} catch (SQLException e) {
					e.printStackTrace();
			}

			cio.checkIn("ORACLE", "DGTL", conn);
		}


//		System.out.println(cio.getPoolSize("ORACLE", "DNAC"));
		System.out.println(cio.getPoolSize("ORACLE", "DGTL"));
	}


}