package com.orb.oracle;

import java.util.*;
import java.sql.*;
import com.orb.sys.*;


public class DBHtml extends Database {
	private String CLASSNAME = this.getClass().getName();

	public DBHtml(String machine, String port,
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

//		dataStr = "<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\">\n";
		dataStr = "<table "
				+ "id=\"" + sqlTag + "\" "
				+ "border=\"1\" cellpadding=\"5\" cellspacing=\"0\">\n";

		try {
			stmt = conn.createStatement ();
			rset = stmt.executeQuery (sqlStr);
			rsmd = rset.getMetaData();

			int colCount = rsmd.getColumnCount();

			// column name
			dataStr = dataStr + "\t<tr>\n";
			for (int i=1;i<=colCount;i++)
				dataStr = dataStr + "\t\t<td><P align=center><strong>"
									+ rsmd.getColumnName(i)
									+ "</strong></p></td>\n";
			dataStr = dataStr + "\t</tr>\n";

			while (rset.next()) {
				recordCount ++;
				dataStr = dataStr + "\t<tr>\n";

				for (int i=1;i<=colCount;i++) {
					String type = rsmd.getColumnTypeName(i);
					String nextData = rset.getString(i);

					if (nextData == null)
						nextData = "-";

					if (type.equals("NUMBER")) {
						int dotInd = nextData.indexOf(".");
						if (dotInd != -1) {
							String left = nextData.substring(0, dotInd);
							String right = nextData.substring(dotInd+1);
							if (right.length() > 2) {
								right = right.substring(0, 2);
								nextData = left + "." + right;
							}
						}

						dataStr = dataStr + "\t\t<td><P align=right>"
								+  nextData + "</p></td>\n";

					} else
						dataStr = dataStr + "\t\t<td>" +  nextData + "</td>\n";
				}
				dataStr = dataStr + "\t</tr>\n";
			}
			dataStr = dataStr + "</table>\n";

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


	public String getHtmlTable() { return dataStr; }


	public static void main(String args[]) {
		DBHtml o = new DBHtml("Chialin", "1521", "system", "oracle00", "CHIALIN");
		o.executeSQL("OV_INIT_PARAM");
		System.out.println(o.getHtmlTable());

	}


}