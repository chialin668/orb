import java.sql.*;

public class DBPrepare extends Database {
	private String CLASSNAME = this.getClass().getName();

	public DBPrepare (String machine, String port,
					String username, String password, String sid) {

		super(machine, port, username, password, sid);
	}


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
			// @@@@ SQL????
			for (int i=0;i<1000;i++) {
				pstmt = conn.prepareStatement("insert into test(id) values (?)");
				pstmt.setInt(1, i);

				rset = pstmt. executeQuery();
				pstmt.close();
			}
		} catch (java.sql.SQLException e) {
			String message = "Error executing prepared SQL: " + sqlTag;
						SysLog log = new SysLog();
						log.write(CLASSNAME, METHODNAME,
											SysLog.ML_SEVERE,
											null,
											message);
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


	public static void main(String args[]) {
		DBPrepare o = new DBPrepare("Chialin", "1521", "system", "oracle00", "CHIALIN");

		o.executeSQL("DB_VERSION");

	}



}