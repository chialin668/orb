import java.util.*;
import java.sql.*;

public class Database {
	private String CLASSNAME = this.getClass().getName();

	protected static String DELIMITER = "^";
	protected static String REC_DELIMITER = "\n";

	protected Connection conn;
	protected Statement stmt;
	protected ResultSet rset;
	protected ResultSetMetaData rsmd;
	protected String sqlStr;

	private String machine;
	private String port = "1521";
	private String username;
	private String password;
	private String sid;

	protected String headerStr = "";
	protected String dataStr = "";
	protected int recordCount = 0;
	protected Vector colVect;
	protected Vector typeVect;
	protected Vector resultVect;

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

	public boolean init(String sqlTag) {
		String METHODNAME = "init";

		// init the JDBC driver
		try {
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			conn = DriverManager.getConnection (
							"jdbc:oracle:thin:@"
								+ machine + ":" + port + ":" + sid,
							username, password);

		} catch (SQLException e) {
			String message = "Error initializing a database connection!!\n"
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
		headerStr = "";
		dataStr = "";

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sqlStr);
			rsmd = rset.getMetaData();

			int colCount = rsmd.getColumnCount();

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
				recordCount ++;

				String tmpStr = "";
				for (int i=1;i<=colCount;i++) {
					String data = rset.getString(i);


					if (data == null)
						data = " ";

					tmpStr = tmpStr + data + DELIMITER;
				}

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

	public int getRecordCount() {
		return recordCount;
	}

	protected boolean close() {
		String METHODNAME = "close";

		try {
			stmt.close();
			conn.close();

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
	public String getHeaderStr() { return headerStr; }
	public String getDataStr() { return dataStr; }
	public Vector getColVect() { return colVect; }
	public Vector getTypeVect() { return typeVect; }
	public Vector getResultVect() { return resultVect; }

	public static void main(String args[]) {
		//Database o = new Database("devsql", "1521", "system", "oracle00", "DDNA20");
		//Database o = new Database("Chialin", "1521", "system", "oracle00", "CHIALIN");
		Database o = new Database("172.16.1.20", "1521", "system", "systempass", "DGTL");

		//o.init();
		o.executeSQL("DB_VERSION");
		System.out.println(o.getHeaderStr());
		System.out.println(o.getDataStr());
		//o.close();

	}

}



