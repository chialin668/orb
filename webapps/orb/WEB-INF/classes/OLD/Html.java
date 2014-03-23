import java.util.*;
import java.sql.*;

public class Html {

	private static String DELIMITER = "^";
	private ResultSetMetaData rsmd;
	private ResultSet rset;


	public String getHtmlTable(Oracle ora) {
		Vector colVect;
		Vector typeVect;
		Vector resultVect;

		colVect = ora.getColVect();
		typeVect = ora.getTypeVect();
		resultVect = ora.getResultVect();

		String retStr = "<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\">\n";

		// column names
		retStr = retStr + "\t<tr>\n";
		for (int i=0;i<colVect.size(); i++)
			retStr = retStr + "\t\t<td><P align=center><strong>"
					+ ((String) colVect.elementAt(i))
					+ "</strong></p></td>\n";
		retStr = retStr + "\t</tr>\n";

		// data
		for (int i=0;i<resultVect.size(); i++) {
			retStr = retStr + "\t<tr>\n";

			String dataStr = (String) resultVect.elementAt(i);
			StringTokenizer st = new StringTokenizer(dataStr, DELIMITER);

			int colId = 0;
			while (st.hasMoreTokens()) {
				String nextData = st.nextToken();

				String type = (String) typeVect.elementAt(colId);
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

					retStr = retStr + "\t\t<td><P align=right>"
							+  nextData + "</p></td>\n";

				} else
					retStr = retStr + "\t\t<td>" +  nextData + "</td>\n";
				colId ++;
			}
			retStr = retStr + "\t</tr>\n";
		}

		retStr = retStr + "</table>\n";

		return retStr;
	}




	public static void main(String args[]) {
		Oracle o = new Oracle("Chialin", "1521", "system", "oracle00", "CHIALIN");
		SQLReader sr = new SQLReader();
		sr.readFile("test.sql");
		String sqlStr = sr.getSQL("OV_INIT_PARAM");
/*
			String sqlStr = "select disk_reads, sql_text"
								+ " from v$sqlarea"
								+ " where disk_reads > 200"
								+ " order by disk_reads desc";
*/
		System.out.println(sqlStr);
		o.executeSQL(sqlStr);

		Html html = new Html();
		System.out.println(html.getHtmlTable(o));
	}


}