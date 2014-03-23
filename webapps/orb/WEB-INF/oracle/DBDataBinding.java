package com.orb.oracle;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.orb.sys.*;


public class DBDataBinding extends Database {
	private String CLASSNAME = this.getClass().getName();

	private static String DB_DELIMITER = "^";   // for data binding

	public DBDataBinding(String machine, String port,
					String username, String password, String sid) {

		super(machine, port, username, password, sid);
	}


	public boolean executeSQL(String sqlTag) {
		String METHODNAME = "executeSQL";

		if (!super.init(sqlTag)) {
			String message = "Error initializing a database connection!!";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		///////////////////////////
		colVect = new Vector();
		typeVect = new Vector();
		resultVect = new Vector();

		headerStr = "";
		dataStr = "";

		try {
			stmt = conn.createStatement ();
			rset = stmt.executeQuery (sqlStr);
			rsmd = rset.getMetaData();

			int colCount = rsmd.getColumnCount();

			// columns
			for (int i=1;i<=colCount;i++) {
				String colName = rsmd.getColumnName(i);
				String dataType = rsmd.getColumnTypeName(i);
				colName = colName.replace(' ', '_');

				colVect.add(colName);
				typeVect.add(dataType);

				if (dataType.equals("NUMBER"))
					dataType = "int";

				headerStr = headerStr + colName + ":" + dataType + DB_DELIMITER;

			}
			headerStr = headerStr.substring(0, headerStr.length()-1) + "\n";

			// data
			while (rset.next()) {
				recordCount ++;

				String tmpStr = "";
				for (int i=1;i<=colCount;i++) {
					String type = rsmd.getColumnTypeName(i);
					String nextData = rset.getString(i);

					if (nextData == null)
						nextData = " ";

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

					tmpStr = tmpStr + nextData + DELIMITER;
				}

				tmpStr = tmpStr.substring(0, tmpStr.length()-1);

				dataStr = dataStr + tmpStr + REC_DELIMITER;

				// for 'select' (option in html) used only
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
		///////////////////////////

		if (!super.close()) {
			String message = "Error closing the database connection!!";

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		return true;
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
//		String retStr = "<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=2>" + "\n"
		String retStr = "<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\">\n"
							+ "<TR BGCOLOR=#333366>" + "\n"
							+ "	<TD>" + "\n"
							+ "	<DIV ID='divDept'>" + "\n"
							+ "	<B><FONT COLOR=#FFFFFF><p align=center>" + title + "</p></FONT></B>" + "\n"
							+ "	</DIV>" + "\n"
							+ "	</TD>" + "\n"
							+ "	<TR>" + "\n"
							+ "	<TD>" + "\n"
//							+ "	<TABLE DATASRC=\"#tdcStaff\" border=1>" + "\n"
		+ "<table DATASRC=\"#tdcStaff\" border=\"1\" cellpadding=\"3\" cellspacing=\"0\">\n"
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
//		String retStr = "<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\">" + "\n"
		String retStr = "<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\">\n"
							+ "<tr>" + "\n"
							+ "	<td>" + "\n"
							+ "		<P align=left>" + "\n"
							+ this.getSelectStr(colName)
							+ "		</P>" + "\n"
							+ "	</td>" + "\n"
							+ "</tr>" + "\n"
							+ "<tr>" + "\n"
							+ "	<td>" + "\n"
//							+ "		<TABLE border=2 cellPadding=0 cellSpacing=0>" + "\n"
+ "<table border=\"1\" cellpadding=\"0\" cellspacing=\"3\">\n"
							+ "			<TR bgColor=#333366>" + "\n"
							+ "				<TD>" + "\n"
							+ "					<P align=center>" + "\n"
							+ "					<FONT color=#ffffff>" + "\n"
							+ "					<B>Table Title Here</B>" + "\n"
							+ "					</FONT></P>" + "\n"
							+ "				</TD>" + "\n"
							+ "			<TR>" + "\n"
							+ "				<TD>" + "\n"
//							+ "					<TABLE dataSrc=#tdcStaff>" + "\n"
+ "<table dataSrc=#tdcStaff border=\"1\" cellpadding=\"3\" cellspacing=\"0\">\n"
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


	//public String getHeaderStr() { return headerStr; }
	public String getDBString() {return headerStr+dataStr; }


	public static void main(String args[]) {
		DBDataBinding o = new DBDataBinding("Chialin", "1521", "system", "oracle00", "CHIALIN");
		o.executeSQL("OV_INIT_PARAM");

		System.out.println(o.getHTMLCol());
		System.out.println(o.getHTMLDataFld());
		//System.out.println(o.getHeaderStr());
		System.out.println(o.getDBString());
		System.out.println("----------------");

	}


}