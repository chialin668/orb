package com.orb.oracle;

import java.util.*;
import java.sql.*;
import com.orb.sys.*;


/**
*
drop table dbstat;
create table dbstat (sid char(8),
						type char(16),
						timestamp date,
						name varchar2(128),
						value varchar2(128));

create index dbstat_sid on dbstat(sid) tablespace indx;
create index dbstat_type on dbstat(type) tablespace indx;
create index dbstat_ts on dbstat(timestamp) tablespace indx;
create index dbstat_name on dbstat(name) tablespace indx;

insert into dbstat values('Test', 'STAT', sysdate, 'aname', 123);

*
**/

public class OraStat extends Thread {
	private String CLASSNAME = this.getClass().getName();
	private String fileName = "test.cfg";


	public static final int YEAR 	= -1;
	public static final int QUARTER = 1;
	public static final int MONTH 	= 2;
	public static final int WEEK 	= 3;
	public static final int DAY 	= 4;
	public static final int HOUR 	= 5;
	public static final int MINUTE 	= 6;

	private static boolean stop = false;

	private CheckInOut cio;
	protected Connection conn;
	protected Statement stmt;
    protected PreparedStatement pstmt;
	protected ResultSet rset;
	protected ResultSetMetaData rsmd;
	protected String sqlStr;
	protected Hashtable lastStatTab = new Hashtable();

	private String machine;
	private String port = "1521";
	private String username;
	private String password;
	private String sid;
	private boolean needDiff = true;
	private String sqlTag;
	private int interval = 60;

	//
	// Repository information
	//
	public static String reposMachine;
	public static String reposPort;
	public static String reposUsername;
	public static String reposPassword;
	public static String reposSid;

	/////////////////////////////////////////////////////////////////////////////////////


	public OraStat() {}
	public void setReposServer(String reposMachine,
									String reposPort,
									String reposUsername,
									String reposPassword,
									String reposSid) {
		this.reposMachine = reposMachine;
		this.reposPort = reposPort;
		this.reposUsername = reposUsername;
		this.reposPassword = reposPassword;
		this.reposSid = reposSid;
	}


	// default 1 hour
	public OraStat (String machine, String port,
					String username, String password, String sid,
					String sqlTag) {
		this(machine, port, username, password, sid, sqlTag, 60*60, true);
	}

	public OraStat (String machine, String port,
					String username, String password, String sid,
					String sqlTag, int interval) {
		this(machine, port, username, password, sid, sqlTag, interval, true);
	}

	// diff will be use for Oracle stat
	public OraStat (String machine, String port,
					String username, String password, String sid,
					String sqlTag, int interval, boolean needDiff) {
		this.machine = machine;
		if (port != null)
			this.port = port;

		this.username = username;
		this.password = password;
		this.sid = sid;
		this.sqlTag = sqlTag;
		this.interval = interval;
		this.needDiff = needDiff;
	}

	public void setInterval() {
		this.interval = interval;
	}

	// stop the thread
	public void stopIt() {
		stop = true;
	}

	public void run() {
		while(!stop) {
			System.out.println("get stat: " + sqlTag);
			this.executeSQL(sqlTag);
			try { Thread.sleep(interval*1000); }
				catch (java.lang.InterruptedException e) {}
		}
	}


	public void readConfig() {


	}

	//
	// Going to write: sid, interval, needDiff
	//
	public void writeConfig() {


	}


	//////////////////////////////////////////////////////////////////////////////////
	public boolean init(String sqlTag) {
		String METHODNAME = "init";

		cio = new CheckInOut();
		conn = (Connection) cio.checkOut(CheckInOut.ORACLE, machine, sid, username, password);
		if (conn == null) {
			String message = "Error checking out aOraStat connection!!\n"
						+ "machine = " + machine
						+ ", port = " + port
						+ ", username = " + username
						+ ", SID = " + sid + "\n";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		// read the sql
		SQLReader sr = new SQLReader();
		if (!sr.readFile(Environment.SQL_FILE)) {
			String message = "Error reading SQL file: " + Environment.SQL_FILE;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								null,
								message);
			return false;
		}

		sqlStr = sr.getSQL(sqlTag);

		if (sqlStr == null) {
			String message = "SQL String is null for SQL TAG: " + sqlTag;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		return true;
	}


	public boolean executeSQL(String sqlTag) {
		String METHODNAME = "executeSQL";

		if(!this.init(sqlTag)) {
			String message = "Error initializing a Oracle connection!!";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		String name = null;
		String value = null;

		try {
			Connection reposConn =
					(Connection) cio.checkOut(CheckInOut.ORACLE,
													reposMachine,
													reposSid,
													reposUsername,
													reposPassword);
			stmt = reposConn.createStatement();
			rset = stmt.executeQuery(sqlStr);
			rsmd = rset.getMetaData();

			// for inserting
			sqlStr = "insert into dbstat values (?, ?, ?, ?, ?)";
      		pstmt = reposConn.prepareStatement(sqlStr);

			while (rset.next()) {

				name = rset.getString(1);
				value = rset.getString(2);

//				System.out.println("name = " + name + "\tvalue = " + value);

				if (needDiff) {
					String lastValue = (String) lastStatTab.get(name);
					lastStatTab.put(name, value);

					if (lastValue == null)
						// do not insert this record
						continue;


					long diff = Long.parseLong(value) - Long.parseLong(lastValue);
					value = new Long(diff).toString();
				}

//				System.out.println(name + ":" + value);

				// insert the data
				pstmt.setString(1, sid);
				pstmt.setString(2, sqlTag.substring("STAT_".length()));
				pstmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
				pstmt.setString(4, name);
				pstmt.setString(5, value);
				pstmt.addBatch();

			}

			pstmt.executeBatch();

			pstmt.close();
			reposConn.close();

		} catch (SQLException e) {
			String message = "Error executing SQL: " + sqlStr
							+ "\n\t\tfor username: " + username
							+ " on server sid: " + sid
							+ "\n\t\t name = " + name
							+ " value = " + value;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			//
			if (!this.close()) {
				message = "Error closing a OraStat connection!!";

				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									null,
									message);
				return false;
			}

			return false;
		}

		if (!this.close()) {
			String message = "Error closing a OraStat connection!!";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								null,
								message);
			return false;
		}

		return true;
	}


	protected boolean close() {
		String METHODNAME = "close";

		try {
			if (stmt != null) stmt.close();
			if (pstmt != null) pstmt.close();
//			if (conn != null) conn.close();

			if (!cio.checkIn(CheckInOut.ORACLE, sid, conn)) {
				String message = "Error checking the OraStat connection!!\n"
							+ "machine = " + machine
							+ ", port = " + port
							+ ", username = " + username
							+ ", SID = " + sid + "\n";

				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									null,
									message);
				return false;
			}

		} catch (SQLException e) {
			String message = "Error closing the OraStat connection!!\n"
						+ "machine = " + machine
						+ ", port = " + port
						+ ", username = " + username
						+ ", SID = " + sid + "\n";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			return false;
		}

		return true;
	}

///////////////////////////////////////////////////////////////////////////////////////

/*

col value for a50
select to_char(timestamp, 'MM-DD-YYYY HH24:MI:SS'), value
from dbstat
where name = 'SQL*Net roundtrips to/from client';


// date
select to_char(timestamp, 'MM-DD-YYYY'), sum(value)
from dbstat
where name = 'SQL*Net roundtrips to/from client'
and to_char(timestamp, 'MM-DD-YYYY') = '06-08-2001'
group by to_char(timestamp, 'MM-DD-YYYY')

// hour
select to_char(timestamp, 'MM-DD-YYYY HH24'), sum(value)
from dbstat
where name = 'SQL*Net roundtrips to/from client'
and to_char(timestamp, 'MM-DD-YYYY') = '06-08-2001'
group by to_char(timestamp, 'MM-DD-YYYY HH24')

// minute
select to_char(timestamp, 'MM-DD-YYYY HH24:MI'), sum(value)
from dbstat
where name = 'SQL*Net roundtrips to/from client'
and to_char(timestamp, 'MM-DD-YYYY') = '06-08-2001'
group by to_char(timestamp, 'MM-DD-YYYY HH24:MI')

*/

	public String getData(String serverId, int type, String year, String month, String day, String hour, String statName) {
		String METHODNAME = "getData";

		if(!this.init(sqlTag)) {
			String message = "Error initializing a database connection!!";
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return null;
		}

		String retStr = "";

		try {
			String formatStr = "";
			String criStr = "";
			String criFormatStr = "";

			switch (type) {
				case OraStat.MINUTE:
					if (year == null || month == null || day == null) {
						String message = "One of the following is null!!"
									+ "\nyear = " + year
									+ ", month = " + month
									+ ", day = " + day
									+ ", hour = " + hour;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
											SysLog.ML_SEVERE,
											null,
											message);
						return null;
					} else if (hour == null) {
						formatStr = "YYYYMMDDHH24MI";
						criFormatStr = "YYYYMMDD";
						criStr = year + month + day;
					} else {
						formatStr = "YYYYMMDDHH24MI";
						criFormatStr = "YYYYMMDDHH24";
						criStr = year + month + day + hour;
					}
					break;

				case OraStat.HOUR:
					if (year == null || month == null || day == null ) {
						String message = "One of the following is null!!"
									+ "\nyear = " + year
									+ ", month = " + month
									+ ", day = " + day;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
											SysLog.ML_SEVERE,
											null,
											message);
						return null;
					} else {
						formatStr = "YYYYMMDDHH24";
						criFormatStr = "YYYYMMDD";
						criStr = year + month + day;
					}
					break;

				case OraStat.DAY:
					if (year == null || month == null) {
						String message = "One of the following is null!!"
									+ "\nyear = " + year
									+ ", month = " + month;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
											SysLog.ML_SEVERE,
											null,
											message);
						return null;
					} else {
						formatStr = "YYYYMMDD";
						criFormatStr = "YYYYMM";
						criStr = year + month;
					}
					break;

				case OraStat.MONTH:
					if (year == null) {
						String message = "One of the following is null!!"
									+ "\nyear = " + year;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
											SysLog.ML_SEVERE,
											null,
											message);
						return null;
					} else {
						formatStr = "YYYYMM";
						criFormatStr = "YYYY";
						criStr = year;
					}
					break;

				case OraStat.YEAR:
					formatStr = "YYYY";
					break;

				default:
					break;
			}


			if (type == OraStat.YEAR)
				sqlStr = "select to_char(timestamp, '" + formatStr + "'), sum(value)"
						+ "\n from dbstat"
						+ "\n where sid = '" + serverId + "'"
						+ "\n and name = '" + statName + "'"
						+ "\n group by to_char(timestamp, '" + formatStr + "')"
						+ "\n";
			else
				sqlStr = "select to_char(timestamp, '" + formatStr + "'), sum(value)"
						+ "\n from dbstat"
						+ "\n where sid = '" + serverId + "'"
						+ "\n and name = '" + statName + "'"
						+ "\n and to_char(timestamp, '" + criFormatStr + "') = '" + criStr + "'"
						+ "\n group by to_char(timestamp, '" + formatStr + "')"
						+ "\n";
//
			System.out.println(sqlStr);

			stmt = conn.createStatement();
			rset = stmt.executeQuery(sqlStr);
			rsmd = rset.getMetaData();

			while (rset.next()) {
				String value = rset.getString(2);

				retStr = retStr + "," + value;
			}

		} catch (SQLException e) {
			String message = "Error executing SQL: \n" + sqlStr
								+ "\n sid: " + sid
								+ "\n username: " + username
								+ "\n password: " + password;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			//
			if (!this.close()) {
				message = "Error closing a database connection!!";
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									null,
									message);
				return null;
			}
			return null;
		}

		if (!this.close()) {
			String message = "Error closing a database connection!!";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								null,
								message);
			return null;
		}

		if (retStr.length()>=1)
			return retStr.substring(1);
		else return retStr;


	}


	public static void main(String args[]) {

		Vector vect = new Vector();
		vect.add("STAT_STAT");
		vect.add("STAT_DF_SIZE");
		vect.add("STAT_DF_FREE");

		// repository
		OraStat stat = new OraStat();
		stat.setReposServer("orb", "1521", "system", "oracle00", "REPOS");

		for (int i=0;i<vect.size();i++) {
			String sqlTag = (String) vect.elementAt(i);
			boolean needDiff = true;
			if (!sqlTag.equals("STAT_STAT"))
				needDiff = false;

//			stat = new OraStat("Chialin", "1521", "system", "oracle00", "CHIALIN", sqlTag , 60, needDiff);

			stat = new OraStat("orb", "1521", "system", "oracle00", "REPOS", sqlTag , 5, needDiff);
			stat.start();

			stat = new OraStat("devdcx", "1521", "system", "oracle00", "DNAC", sqlTag , 5, needDiff);
			stat.start();

		}



/*
		stat = new OraStat("orb", "1521", "system", "oracle00", "REPOS",
									"STAT_DF_SIZE" , 60, needDiff);
		while(true) {
			try { Thread.sleep(60*1000); }
				catch (java.lang.InterruptedException e) {}
			//
			System.out.println(stat.getData(OraStat.MINUTE, "2001", "06", "19", "8", "SQL*Net roundtrips to/from client"));
			//System.out.println(stat.getData(OraStat.MINUTE, "2001", "06", "11", null, "SQL*Net roundtrips to/from client"));
			//System.out.println(stat.getData(OraStat.HOUR, "2001", "06", "11", null, "SQL*Net roundtrips to/from client"));
			//System.out.println(stat.getData(OraStat.MONTH, "2001", "06", null, null, "SQL*Net roundtrips to/from client"));
			//System.out.println(stat.getData(OraStat.YEAR, "2001", null, null, null, "SQL*Net roundtrips to/from client"));
		}
*/
	}

}



