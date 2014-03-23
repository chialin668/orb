import java.util.*;

public class DataBinding {

	private static String DELIMITER = "^";
	private static String DB_DELIMITER = "^";   // for data binding

	private Vector colVect;
	private Vector typeVect;
	private Vector resultVect;
	private boolean debug = false;

	public DataBinding(Oracle ora) {
		colVect = ora.getColVect();
		typeVect = ora.getTypeVect();
		resultVect = ora.getResultVect();
	}

	public String getDBString() {

System.out.println("start data binding: " + System.currentTimeMillis()/1000);

		String retStr = "";

		// column names
		for (int i=0;i<colVect.size(); i++) {
			String colName = (String) colVect.elementAt(i);
			String dataType = (String) typeVect.elementAt(i);
			if (dataType.equals("NUMBER"))
				dataType = "int";

			retStr = retStr + colName + ":" + dataType + DB_DELIMITER;
		}
		retStr = retStr.substring(0, retStr.length()-1) + "\n";
System.out.println("DB get column: " + System.currentTimeMillis()/1000);
System.out.println("------------------------------------------------------");

		// data
		for (int i=0;i<resultVect.size(); i++) {

			String dataStr = (String) resultVect.elementAt(i);
			StringTokenizer st = new StringTokenizer(dataStr, DELIMITER);

			int colId = 0;
			while (st.hasMoreTokens()) {
				String nextData = st.nextToken();

System.out.print(i + ", ");
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
				}

				retStr = retStr + nextData + DB_DELIMITER;
				colId ++;
			}
			retStr = retStr.substring(0, retStr.length()-1) + "\n";
		}

System.out.println("DB get data: " + System.currentTimeMillis()/1000);
System.out.println("------------------------------------------------------");

		return retStr;
	}


	public String addCommon(String inStr) {

		String retStr = "";

		int len = inStr.length();
		if (len <= 3)
			return inStr;
		else {
			String right = "";
			String left = "";
			while (len > 3) {
				right = inStr.substring(len-3);
				left = inStr.substring(0, (len-3));
				retStr = "," + right + retStr;

				inStr = left;
				len = inStr.length();
			}
			//retStr = retStr.substring(1);
			retStr = left + retStr;
		}

		return retStr;
	}

   /**
	*
	*
	*
	**/
	public String getHTMLCol() {
		String retStr = "";

		for (int i=0;i<colVect.size();i++) {
			retStr = retStr + "<TH BGCOLOR=#000080>"
							+ "<A HREF='Javascript: colSort(\""
							+ (String) colVect.get(i)
							+ "\");'>"
							+ ((String) colVect.get(i)).replace('_', ' ')
							+ "</A></TH>" + "\n";
		}

		return retStr;
	}


	public String getHTMLDataFld() {
		String retStr = "";

		for (int i=0;i<colVect.size();i++) {
			String dataType = (String) typeVect.get(i);

			if (dataType.equals("NUMBER"))
				retStr = retStr + "<TD align=\"right\">"
							+ "<DIV datafld="
							+ (String) colVect.get(i)
							+ "></DIV></TD>" + "\n";
			else
				retStr = retStr + "<TD>"
							+ "<DIV datafld="
							+ (String) colVect.get(i)
							+ "></DIV></TD>" + "\n";
		}

		return retStr;
	}


	public String getDataBindingObj(String url, String param) {

		String urlStr = url + "?" + "id=" + param;

		String retStr =
				"<OBJECT classid=clsid:333C7BC4-460F-11D0-BC04-0080C7055A83 " + "\n"
						+ "height=30 " + "\n"
						+ "id=tdcStaff " + "\n"
						+ "width=46>" + "\n"
				+ "<PARAM NAME=\"RowDelim\" VALUE=\"&#10;\">" + "\n"
				+ "<PARAM NAME=\"FieldDelim\" VALUE=\"" + DB_DELIMITER + "\">" + "\n"
				+ "<PARAM NAME=\"TextQualifier\" VALUE=\",\">" + "\n"
				+ "<PARAM NAME=\"EscapeChar\" VALUE=\"\">" + "\n"
				+ "<PARAM NAME=\"UseHeader\" VALUE=\"-1\">" + "\n"
				+ "<PARAM NAME=\"SortAscending\" VALUE=\"-1\">" + "\n"
				+ "<PARAM NAME=\"SortColumn\" VALUE=\"\">" + "\n"
				+ "<PARAM NAME=\"FilterValue\" VALUE=\"\">" + "\n"
				+ "<PARAM NAME=\"FilterCriterion\" VALUE=\"??\">" + "\n"
				+ "<PARAM NAME=\"FilterColumn\" VALUE=\"\">" + "\n"
				+ "<PARAM NAME=\"CharSet\" VALUE=\"\">" + "\n"
				+ "<PARAM NAME=\"Language\" VALUE=\"\">" + "\n"
				+ "<PARAM NAME=\"CaseSensitive\" VALUE=\"-1\">" + "\n"
				+ "<PARAM NAME=\"Sort\" VALUE=\"\">" + "\n"
				+ "<PARAM NAME=\"Filter\" VALUE=\"\">" + "\n"
				+ "<PARAM NAME=\"AppendData\" VALUE=\"0\">" + "\n"
				+ "<PARAM NAME=\"DataURL\" VALUE=\"" + urlStr + "\">" + "\n"
				+ "<PARAM NAME=\"ReadyState\" VALUE=\"2\">" + "\n"
				+ "</OBJECT>";

		return retStr;
	}



	public String getDataBindingTable(String title) {
		String retStr = "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=2>" + "\n"
							+ "<TR BGCOLOR=#333366>" + "\n"
							+ "	<TD>" + "\n"
							+ "	<DIV ID='divDept'>" + "\n"
							+ "	<B><FONT COLOR=#FFFFFF><p align=center>" + title + "</p></FONT></B>" + "\n"
							+ "	</DIV>" + "\n"
							+ "	</TD>" + "\n"
							+ "	<TR>" + "\n"
							+ "	<TD>" + "\n"
							+ "	<TABLE DATASRC=\"#tdcStaff\" border=1>" + "\n"
							+ "		<THEAD>" + "\n"
							+ "			<TR>" + "\n"
							+ this.getHTMLCol() + "\n"
							+ "			</TR>" + "\n"
							+ "		</THEAD>" + "\n"
							+ "		<TBODY>" + "\n"
							+ "			<TR>" + "\n"
							+ this.getHTMLDataFld() + "\n"
							+ "			</TR>" + "\n"
							+ "		</TBODY>" + "\n"
							+ "	</TABLE>" + "\n"
							+ "	</TD>" + "\n"
							+ "	</TR>" + "\n"
							+ "	</TABLE>";
		return retStr;
	}


	public String getSelectStr(String checkColName) {

		Hashtable tmpTab = new Hashtable();

		String retStr =
				"			<SELECT " + "\n"
				+ "				name=cboDept " + "\n"
				+ "				onchange='selectChange(\"" + checkColName + "\");' " + "\n"
				+ "				style=\"WIDTH: 150px\"> " + "\n"
				+ "			<OPTION selected>All" + "\n";

		for (int i=0;i<resultVect.size(); i++) {

			String dataStr = (String) resultVect.elementAt(i);
			StringTokenizer st = new StringTokenizer(dataStr, DELIMITER);

			int colId = 0;
			while (st.hasMoreTokens()) {
				String nextData = st.nextToken();

				String columnName = (String) colVect.elementAt(colId);
				if (columnName.equals(checkColName))
					tmpTab.put(nextData, nextData);

				colId ++;
			}
		}

		Enumeration keys = tmpTab.keys();
		while (keys.hasMoreElements()) {
			String tmpStr = (String) keys.nextElement();
			retStr = retStr + "			<OPTION>" + tmpStr + "\n";
		}

		retStr = retStr + "	</SELECT>" + "\n";

		return retStr;

	}

	public String getSelectDataBindingTable(String title, String colName) {

//		String retStr = "<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\" style=\"HEIGHT: 155px; WIDTH: 423px\">" + "\n"
		String retStr = "<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\">" + "\n"
							+ "<tr>" + "\n"
							+ "	<td>" + "\n"
							+ "		<P align=left>" + "\n"
							+ this.getSelectStr(colName)
							+ "		</P>" + "\n"
							+ "	</td>" + "\n"
							+ "</tr>" + "\n"
							+ "<tr>" + "\n"
							+ "	<td>" + "\n"
							+ "		<TABLE border=2 cellPadding=0 cellSpacing=0>" + "\n"
							+ "			<TR bgColor=#333366>" + "\n"
							+ "				<TD>" + "\n"
							+ "					<P align=center>" + "\n"
							+ "					<FONT color=#ffffff>" + "\n"
							+ "					<B>Table Title Here</B>" + "\n"
							+ "					</FONT></P>" + "\n"
							+ "				</TD>" + "\n"
							+ "			<TR>" + "\n"
							+ "				<TD>" + "\n"
							+ "					<TABLE dataSrc=#tdcStaff>" + "\n"
							+ "					<THEAD>" + "\n"
							+ "					<TR>" + "\n"
							+ this.getHTMLCol() + "\n"
							+ "					<TBODY>" + "\n"
							+ "					<TR>" + "\n"
							+ this.getHTMLDataFld() + "\n"
							+ "					</TR>" + "\n"
							+ "					<TFOOT>" + "\n"
							+ "					</TFOOT>" + "\n"
							+ "					</TABLE>" + "\n"
							+ "				</TD>" + "\n"
							+ "			</TR>" + "\n"
							+ "		</TABLE>" + "\n"
							+ "	</td>" + "\n"
							+ "</tr>" + "\n"
							+ "</table>";

		return retStr;
	}






	public static void main(String args[]) {
		Oracle o = new Oracle("Chialin", "1521", "system", "oracle00", "CHIALIN");
		SQLReader sr = new SQLReader();
		sr.readFile("test.sql");
//			String sqlStr = sr.getSQL("Query-1.10");
		String sqlStr = "select  substr(FILE_ID,1,3) \"ID#\","
							+ " substr(FILE_NAME,1,52) \"Filename\","
							+ " substr(TABLESPACE_NAME,1,25) \"Tablespace\","
							+ " BYTES/1024/1024 \"M Bytes\","
							+ " BLOCKS \"SQL Blks\","
							+ " BYTES/512 \"VMS Blocks\","
							+ " STATUS"
							+ " from sys.dba_data_files"
							+ " order by TABLESPACE_NAME, FILE_NAME";

		System.out.println(sqlStr);
		o.executeSQL(sqlStr);

		DataBinding db = new DataBinding(o);
		System.out.println("----------------");
		System.out.println(db.getHTMLCol());
		System.out.println(db.getHTMLDataFld());
		System.out.println(db.getDBString());
		System.out.println("----------------");

		System.out.println(db.addCommon("12"));
		System.out.println(db.addCommon("123"));
		System.out.println(db.addCommon("1234"));
		System.out.println(db.addCommon("12345"));
		System.out.println(db.addCommon("123456"));
		System.out.println(db.addCommon("1234567"));
		System.out.println(db.addCommon("12345678"));
		System.out.println(db.addCommon("123456789"));
		System.out.println(db.addCommon("1234567890"));
	}


}