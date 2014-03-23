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
<%@ include file="../Header.jsp"%>

<h3>Summary:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("STAT_FREE_BUFFER", "oracle/cpu/SessionCPU", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());


	Database db = new Database(machine, port, username, password, sid);
	db.executeSQL("STAT_FREE_BUFFER");
	Vector resultVect = db.getResultVect();

	double inspected = 0;
	double requested = 1;

	for (int i=0;i<resultVect.size();i++) {
		String nextRec = (String) resultVect.elementAt(i);

		StringTokenizer st = new StringTokenizer(nextRec, "^");

     		while (st.hasMoreTokens()) {
			String name = (String) st.nextToken();
			String value = (String) st.nextToken();

			if (name.equals("free buffer inspected"))
				inspected = Double.parseDouble(value);
			else if (name.equals("free buffer requested"))
				requested = Double.parseDouble(value);
		}
	}

	double avgBuffScanned = 1 + (inspected/requested);
	avgBuffScanned = Math.round(avgBuffScanned*1000.0)/1000.0;

	out.println("<p>");
	out.println("<b>Avg. Buffers Scanned:</b> " + avgBuffScanned);

%>


<p>
<h3>Note:</h3>
<ul>

	<li>If you have more than <b>2</b> buffers scanned:
		<ul>
			<li>Increase the size of buffer cache
			<li>Tune DBWn process(es)
		</ul>
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>
</ul>


</body>
</html>
