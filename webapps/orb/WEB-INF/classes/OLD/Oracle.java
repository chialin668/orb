import java.util.*;
import java.sql.*;

public class Oracle {

	private static String DELIMITER = "^";

	private String machine;
	private String port = "1521";
	private String username;
	private String password;
	private String sid;
	private String headerStr;
//	private String dataStr;
	private Vector colVect;
	private Vector typeVect;
	private Vector resultVect;
	private boolean debug = false;

	public Oracle(String machine, String port,
					String username, String password, String sid) {
		this.machine = machine;
		if (port != null)
			this.port = port;

		this.username = username;
		this.password = password;
		this.sid = sid;
	}


	public boolean executeSQL(String sqlStr) {

		colVect = new Vector();
		typeVect = new Vector();
		resultVect = new Vector();
		headerStr = "";
//		dataStr = "";

		try {
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			Connection conn = DriverManager.getConnection (
//							"jdbc:oracle:thin:@orb:1521:REPOS",
//							"jdbc:oracle:thin:@chialin:1521:CHIALIN",
							"jdbc:oracle:thin:@"
								+ machine + ":" + port + ":" + sid,
							username, password);

			if (debug) {
				System.out.println("machine = " + machine);
				System.out.println("username = " + username);
				System.out.println("password = " + password);
				System.out.println("port = " + port);
				System.out.println("sid = " + sid);
			}

System.out.println("SQL = " + sqlStr);
System.out.println("before exec sql: " + System.currentTimeMillis()/1000);
			Statement stmt = conn.createStatement ();
			ResultSet rset = stmt.executeQuery (sqlStr);
System.out.println("after exec sql: " + System.currentTimeMillis()/1000);
System.out.println("------------------------------------------------------");
			ResultSetMetaData rsmd = rset.getMetaData();

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

System.out.println("get columns: " + System.currentTimeMillis()/1000);
System.out.println("------------------------------------------------------");

			if (debug)
				System.out.println(headerStr);

			while (rset.next()) {

				String tmpStr = "";
				for (int i=1;i<=colCount;i++) {
					String data = rset.getString(i);
					if (data == null)
						data = " ";

					tmpStr = tmpStr + data + DELIMITER;
				}

				tmpStr = tmpStr.substring(0, tmpStr.length()-1);
				resultVect.add(tmpStr);

				if (debug)
					System.out.println(tmpStr);

//				dataStr = dataStr + tmpStr + "\n";
			}

//			dataStr = dataStr.substring(0, dataStr.length()-1);
System.out.println("get data: " + System.currentTimeMillis()/1000);
System.out.println("------------------------------------------------------");

			stmt.close();
			conn.close();

		} catch (SQLException e) {
			e.printStackTrace();
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
//	public String getDataStr() { return dataStr; }
	public Vector getColVect() { return colVect; }
	public Vector getTypeVect() { return typeVect; }
	public Vector getResultVect() { return resultVect; }

	public static void main(String args[]) {
		Oracle o = new Oracle("Chialin", "1521", "system", "oracle00", "CHIALIN");
	/*
				String sqlStr = "select name, value							"
								+ " from v$parameter						"
								+ " where name in ('db_block_buffers',		"
								+ " 				'db_block_size',		"
								+ "					'shared_pool_size',		"
						+ "					'sort_area_size')		";
	*/
			String sqlStr = "select disk_reads, sql_text"
								+ " from v$sqlarea"
								+ " where disk_reads > 200"
								+ " order by disk_reads desc";

		o.executeSQL(sqlStr);

		System.out.println(o.getHeaderStr());
		//System.out.println(o.getDataStr());
		Vector result = o.getResultVect();
		for (int i=0;i<result.size();i++) {
			System.out.println((String) result.elementAt(i));
		}
	}

}



