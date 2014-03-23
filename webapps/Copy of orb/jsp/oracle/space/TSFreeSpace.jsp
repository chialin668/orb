<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.oracle.Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Machine: <%=machine%></h3>
<h3>SID: <%=sid%></h3>


<table id="DBA_TS_INFO" border="1" cellpadding="5" cellspacing="0">
<%
	out.println("<tr>\n");
	out.println("	<td><P align=center><strong>TS Name</strong></a></p></td>\n");
	out.println("	<td><P align=center><strong>Size</strong></a></p></td>\n");
	out.println("	<td><P align=center><strong>Free</strong></a></p></td>\n");
	out.println("	<td><P align=center><strong>% Free</strong></a></p></td>\n");
	//out.println("	<td><P align=center><strong>Block</strong></a></p></td>\n");
	//out.println("	<td><P align=center><strong>Status</strong></a></p></td>\n");
	//out.println("	<td><P align=center><strong>Logging</strong></a></p></td>\n");
	out.println("</tr>\n");

	// data buffer
	Database db = new Database(machine, port, username, password, sid);
	db.executeSQL("DBA_TS_INFO");
	Vector resultVect = db.getResultVect();

	int ind = 1;
	db.executeSQL("DBA_TS_FREE_SPACE");
	Vector vect = db.getDataByColInd(ind);

	for (int i=0;i<resultVect.size();i++) {
		String nextRec = (String) resultVect.elementAt(i);
		StringTokenizer st = new StringTokenizer(nextRec, "^");

		out.println("<tr>");

		int x=0;
     		while (st.hasMoreTokens()) {
			out.println("\t<td><P align=right>");
			String token = (String) st.nextToken();
        		out.println(token);
			out.println("</td></p>");

			if (x == 1) {
				String freeSpace = (String) vect.elementAt(i);
				out.println("\t<td><P align=right>");
				float fs = new Float(freeSpace).floatValue();
				fs = ((float)((int)(fs*100)))/100;
				out.println(fs);
				out.println("</td></p>");
				float pct = Float.parseFloat(freeSpace)/Float.parseFloat(token)*100;
				pct = ((float)((int)(pct*100)))/100;
				out.println("\t<td><P align=right>");
				out.println(new Float(pct).toString());
				out.println("</td></p>");
			}
 			x++;

 			// @@@ don't want other information
 			if (x>1)
 				break;
		}
		out.println("</tr>");
	}
%>
</table>

<%
/*
	SQLReader sqlReader = new SQLReader();
	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DBA_TS_INFO", "FreeSpace", null, null);
	out.println(dbhs.getHtmlTable());
*/
%>

<p>
<h3>Note:</h3>
<ul>
	<li> You can use 'alter tablespace [tablespace name] coalesce; to consolidate the free extents.
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>TS Name: Tablespace name
	<li>Size: The size of the tablespace (in MB)
	<li>Free: The size of the free space inside this tablespace (in MB)
	<li>% Free: The percentage of the free space
</ul>


</body>
</html>
