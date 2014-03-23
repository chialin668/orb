package com.orb.oracle;

import java.util.*;
import java.sql.*;
import com.orb.sys.*;


public class Database {
	private String CLASSNAME = this.getClass().getName();

	protected static String DELIMITER = "^";
	protected static String REC_DELIMITER = "\n";

	private CheckInOut cio;
	protected Connection conn;
	protected Statement stmt;
    protected PreparedStatement pstmt;
	protected ResultSet rset;
	protected ResultSetMetaData rsmd;
	protected String sqlStr;
	protected boolean hasSql = false;

	protected String machine;
	protected String port = "1521";
	protected String username;
	protected String password;
	protected String sid;

	protected String headerStr = "";
	protected String dataStr = "";
	protected int recordCount = 0;
	protected int colCount = 0;

	protected Hashtable criteriaTab;
	protected Vector colVect;
	protected Vector typeVect;
	protected Vector resultVect;
	protected Vector recVect;

	private boolean debug = false;

	public Database (String machine, String port,
					String username, String password, String sid) {
		this.machine = machine;
		if (port != null)
			this.port = port;

		this.username = username;
		this.password = password;
		this.sid = sid;
	}

	public void setSql(String sqlStr) {
		this.sqlStr = sqlStr;
		hasSql = true;
	}

	public void setCriteriaTable(Hashtable criteriaTab) {
		this.criteriaTab = criteriaTab;
	}

	public boolean init(String sqlTag) {
		String METHODNAME = "init";

		cio = new CheckInOut();
		conn = (Connection) cio.checkOut(CheckInOut.ORACLE,
											machine, sid, username, password);
		if (conn == null) {
			String message = "Error checking out adatabase connection!!\n"
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

		if (!hasSql) {
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

			if (sqlTag == null) {
				String message = "SqlTag should NOT be null but it is!!";
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									null,
									message);
				return false;
			}
			sqlStr = sr.getSQL(sqlTag);

			if (sqlStr == null) {
				String message = "SQL string should not be null but it is";
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									null,
									message);
				return false;
			}
		}

		//
		// Insert the criteria to the sqlStr if any
		//
		StringTokenizer st = new StringTokenizer(sqlStr, "\n");
		String parsedSqlStr = "";
		while (st.hasMoreTokens()) {
			 String nextLine = st.nextToken();

			 int ind = nextLine.indexOf("&");
			 if (ind != -1) {
				// need a replace
				String leftStr = nextLine.substring(0, ind);
				String rightStr = nextLine.substring(ind+1);
				byte bArr[] = rightStr.getBytes();
				for (int i=0;i<bArr.length;i++) {
					if ((bArr[i]>64 && bArr[i]<91)
								||
							(bArr[i]>96 && bArr[i]<123)
								||
							(bArr[i]>47 && bArr[i]<58)) {
						continue;
					}
					// construct the variable
					String variable = new String(bArr, 0, i);
					if (criteriaTab == null) {
						String message = "Criteria table should not be null for this SQL!!"
										+ "\n SQL: " + sqlStr;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
											SysLog.ML_SEVERE,
											null,
											message);
						return false;

					}
					String criteria = (String) criteriaTab.get(variable);
					rightStr = criteria + rightStr.substring(i, rightStr.length());

					nextLine = leftStr + rightStr;
					break;
				}
			 }
			 parsedSqlStr = parsedSqlStr + nextLine + "\n";
			 //println(st.nextToken());
		}

		sqlStr = parsedSqlStr;

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
			String message = "Error initializing a database connection!!";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		colVect = new Vector();			// column names
		typeVect = new Vector();		// data tyes
		resultVect = new Vector();		// results
		recVect = new Vector();
		headerStr = "";
		dataStr = "";

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sqlStr);
			rsmd = rset.getMetaData();

			colCount = rsmd.getColumnCount();

			for (int i=1;i<=colCount;i++) {
				String colName = rsmd.getColumnName(i);
				String dataType = rsmd.getColumnTypeName(i);
				colName = colName.replace(' ', '_');

				colVect.add(colName);
				typeVect.add(dataType);

				headerStr = headerStr + colName + ":" + dataType + ",";

			}
			headerStr = headerStr.substring(0, headerStr.length()-1);


			while (rset.next()) {
				Record record = new Record();
				recordCount ++;

				String tmpStr = "";
				for (int i=1;i<=colCount;i++) {
					String data = rset.getString(i);

					if (data == null)
						data = " ";

					tmpStr = tmpStr + data + DELIMITER;
					record.add(data);
				}
				recVect.add(record);

				tmpStr = tmpStr.substring(0, tmpStr.length()-1);

				dataStr = dataStr + tmpStr + REC_DELIMITER;
				resultVect.add(tmpStr);
			}


		} catch (SQLException e) {
			String message = "Error executing SQL: " + sqlStr;

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
				return false;
			}

			return false;
		}

		if (!this.close()) {
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

	protected boolean close() {
		String METHODNAME = "close";

		try {
			if (stmt != null) stmt.close();
			if (pstmt != null) pstmt.close();
//			if (conn != null) conn.close();

			if (!cio.checkIn(CheckInOut.ORACLE, sid, conn, username)) {
				String message = "Error checking the database connection!!\n"
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
			String message = "Error closing the database connection!!\n"
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

   /**
	*
	*
	*
	**/
	public int getRecordCount() { return recordCount; }
	public String getHeaderStr() { return headerStr; }
	public String getDataStr() { return dataStr; }
	public Vector getColVect() { return colVect; }
	public int getColumnIndex(String colName) {
		colName = colName.replace(' ', '_');
		int i;
		for (i=0;i<colVect.size();i++)
			if (((String) colVect.elementAt(i)).equals(colName))
				return i;
		return -1;
	}
	public Vector getTypeVect() { return typeVect; }
	public Vector getResultVect() { return resultVect; }

	public Vector getDataByColInd(int ind) {
		String METHODNAME = "getDataByColInd";

		Vector retVect = new Vector();

		for (int i=0;i<recVect.size();i++) {
			if (ind > colCount) {
			String message = "Can't retrieve column from record index: " + ind
								+ "\n SQL: " + sqlStr;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			}
			Record rec = (Record) recVect.elementAt(i);
			retVect.add(rec.get(ind));
		}

		return retVect;
	}

	public static void main(String args[]) {
		//Database o = new Database("devsql", "1521", "system", "oracle00", "DDNA20");
		Database o = new Database("Chialin", "1521", "system", "oracle00", "CHIALIN");
		//Database o = new Database("orb", "1521", "system", "oracle00", "REPOS");
		//Database o = new Database("172.16.1.20", "1521", "system", "systempass", "DGTL");

		//o.init();
/*
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("ts", "USERS");
		o.setCriteriaTable(criteriaTab);
		o.executeSQL("SPACE_TS_MAP");
		System.out.println(o.getHeaderStr());
		System.out.println(o.getDataStr());
*/
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("owner", "system");
		criteriaTab.put("obj", "PRODUCT_PRIVS");
		o.setCriteriaTable(criteriaTab);
		o.executeSQL("SCHEMA_VIEW_TEXT");
		//System.out.println(o.getHeaderStr());
		System.out.println(o.getDataStr());
/*
		o.setSql("select * from v$database");
		o.executeSQL("DUMMY");
		System.out.println(o.getHeaderStr());
		System.out.println(o.getDataStr());
*/

	}

}



