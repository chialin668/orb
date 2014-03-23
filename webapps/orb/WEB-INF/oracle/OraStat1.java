package com.orb.oracle;

import java.util.*;
import java.sql.*;
import com.orb.sys.*;


public class OraStat1 extends Database implements Runnable {
	private String CLASSNAME = this.getClass().getName();
	private String sqlTag = "STAT_STAT";	// default value
	private boolean stop = false;
	private int interval = 1*60;



   /**
	*
	* constructor
	*
	**/
	public OraStat1(String machine, String port,
					String username, String password, String sid) {
		super(machine, port, username, password, sid);
	}

   /**
	*
	* set SQL Tag (default value: STAT_STAT)
	*
	**/
	public void setSQL(String sqlTag) {
		this.sqlTag = sqlTag;
	}

   /**
	*
	* start the thread
	*
	**/
	public void run() {
		while (!stop) {
			this.executeSQL(sqlTag);
			// @@@
			try { Thread.sleep(interval * 1000); } catch (java.lang.InterruptedException e) {}
		}
	}

   /**
	*
	* stop the thread
	*
	**/
	public void stop() {
		stop = true;
	}


   /**
	*
	* exec the sql string
	*
	**/
	public boolean executeSQL(String sqlTag) {
		String METHODNAME = "executeSQL";

		if (!super.init(sqlTag)) {
			String message = "Error executing SQL: " + sqlTag;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
			                				SysLog.ML_SEVERE,
			                				null,
			                                message);
			return false;
		}

		try {
			stmt = conn.createStatement ();
			rset = stmt.executeQuery (sqlStr);
			rsmd = rset.getMetaData();

			while (rset.next()) {

				// save the statistic data in the memory
				DBMem t = new DBMem();
				//t.put(super.sid, statName, value);

				int colCount = rsmd.getColumnCount();
				String statName = rset.getString(1);

				// data
				for (int i=2;i<=colCount;i++) {
					String colName = rsmd.getColumnName(i);
					String value = rset.getString(colName);
					colName = colName.replace(' ', '_');
					t.put(super.sid, sqlTag, statName, colName, value);

				}


//				System.out.println("statName=" + statName + ", value=" + value);
			}

		} catch (SQLException e) {
			String message = "Error executing SQL: " + sqlTag;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
			                				SysLog.ML_SEVERE,
			                				e,
			                                message);

			if (!super.close()) {
				message = "Error closing a database connection!!";

				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									null,
									message);
				return false;
			}

			return false;
		}

		if (!super.close()) {
			String message = "Error closing a database connection!!";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								null,
								message);
			return false;
		}

		return true;
	}



	public static void main(String args[])  {
		OraStat1 o = new OraStat1("192.168.4.19", "1521", "system", "oracle00", "ORCL");
		o.setSQL("PERF_LATCH");
		Thread tr = new Thread(o);
		tr.start();

		for (int i=0;i<100;i++) {
			System.out.println("abc");
			if (i == 3) {
				o.stop();
				break;
			}
			try { Thread.sleep(3000); } catch (java.lang.InterruptedException e) {}
		}

		DBMem t = new DBMem();
		//System.out.println("--->" + t.get("ORCL", "latch wait list"));
		System.out.println("--->" + t.get("ORCL", "PERF_LATCH", "latch wait list", "GETS"));

	}


}