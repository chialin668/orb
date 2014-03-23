import java.util.*;
import java.sql.*;
import javax.servlet.jsp.JspWriter;

public class DBHtmlSortable extends Database {
	private String CLASSNAME = this.getClass().getName();

	public DBHtmlSortable(String machine, String port,
					String username, String password, String sid) {

		super(machine, port, username, password, sid);
	}


	/**
	*
	* Execute the sql and generate the output (string)
	*
	**/
	public boolean executeSQL(String sqlTag, String callerURL, String chkTag, String sortColName) {
		return this.executeSQL(sqlTag, callerURL, chkTag, sortColName, null);
	}

	public boolean executeSQL(String sqlTag, String callerURL, String chkTag, String sortColName,
								JspWriter out) {
		String METHODNAME = "executeSQL";

		try {
			if (!super.init(sqlTag)) {
				String message = "Error initializing a db connection : " + sqlTag;
							SysLog log = new SysLog();
							log.write(CLASSNAME, METHODNAME,
												SysLog.ML_SEVERE,
												null,
												message);
				return false;
			}

			if (out != null) {
				out.println("<table "
						+ "id=\"" + sqlTag + "\" "
						+ "border=\"1\" cellpadding=\"5\" cellspacing=\"0\">\n");
			} else {

		//		dataStr = "<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\">\n";
		//		dataStr = "<table border=\"1\" cellpadding=\"5\" cellspacing=\"0\">\n";
				dataStr = "<table "
						+ "id=\"" + sqlTag + "\" "
						+ "border=\"1\" cellpadding=\"5\" cellspacing=\"0\">\n";
			}

			if (chkTag != null && sqlTag.equals(chkTag)) {
	//			System.out.println("want to sort:" + sqlTag);

	//			System.out.println("sqlStr = " + sqlStr);

				StringTokenizer st = new StringTokenizer(sqlStr, "\n");
				String newSql = "";
				while (st.hasMoreTokens()) {
					String token = st.nextToken();
					if (sortColName != null && token.toLowerCase().indexOf("order by") == -1)
						newSql = newSql + token + "\n";
				}
	//			System.out.println("newSql:" + newSql);

				if (sortColName != null) {
	//				System.out.println("want to sort by: " + sortColName);
					newSql = newSql + "order by \"" + sortColName + "\" desc";
					sqlStr = newSql;
				}
			}


			try {
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sqlStr);
				rsmd = rset.getMetaData();

				int colCount = rsmd.getColumnCount();

				// column name
				if (out != null)
					out.println("\t<tr>\n");
				else
					dataStr = dataStr + "\t<tr>\n";
				for (int i=1;i<=colCount;i++)
					if (out != null)
						out.println("\t\t<td><P align=center>"
										+ "<a href=\"/orb/jsp/sys/" + callerURL + ".jsp?"
										+ "chkTag=" + sqlTag
										+ "&orderBy=" +rsmd.getColumnName(i)
										+ "\"><strong>"
										+ rsmd.getColumnName(i)
										+ "</strong></a></p></td>\n");
					else
						dataStr = dataStr + "\t\t<td><P align=center>"
										+ "<a href=\"/orb/jsp/sys/" + callerURL + ".jsp?"
										+ "chkTag=" + sqlTag
										+ "&orderBy=" +rsmd.getColumnName(i)
										+ "\"><strong>"
										+ rsmd.getColumnName(i)
										+ "</strong></a></p></td>\n";

				if (out != null)
					out.println("\t</tr>\n");
				else
					dataStr = dataStr + "\t</tr>\n";

				// data
				while (rset.next()) {
					recordCount ++;
					if (out != null)
						out.println("\t<tr>\n");
					else
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

							if (out != null)
								out.println("\t\t<td><P align=right>"
									+  nextData + "</p></td>\n");
							else
								dataStr = dataStr + "\t\t<td><P align=right>"
									+  nextData + "</p></td>\n";

						} else
							if (out != null)
								out.println("\t\t<td>" +  nextData + "</td>\n");
							else
								dataStr = dataStr + "\t\t<td>" +  nextData + "</td>\n";
					}
					if (out != null)
						out.println("\t</tr>\n");
					else
						dataStr = dataStr + "\t</tr>\n";
				}
				if (out != null)
					out.println("</table>\n");
				else
					dataStr = dataStr + "</table>\n";

			} catch (SQLException e) {
				String message = "Error executing SQL: " + sqlTag
								+ "\nSQL: " + sqlStr;
							SysLog log = new SysLog();
							log.write(CLASSNAME, METHODNAME,
												SysLog.ML_SEVERE,
												e,
												message);

				if(!super.close()) {
					message = "Error closing a database connection!!";

					log.write(CLASSNAME, METHODNAME,
										SysLog.ML_SEVERE,
										null,
										message);
					return false;
				}

				return false;
			}

		} catch (java.io.IOException e) {
			String message = "Error writing output to browser";
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								e,
					message);
			return false;
		}

		if(!super.close()) {
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