<%@ page import = "com.orb.oracle.Database" %>
<%@ page import = "com.orb.oracle.DBHtml" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>

<%@ page import = "java.util.Vector" %>

<%@ include file="../sys/Session.jsp"%>

<%
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Global.js"></SCRIPT>
</head>

<body>
<%@ include file="Header.jsp"%>

<H3>Enough memory?</H3>
Oracle init parameters
<ul>
	<%
	//	SQLReader sqlReader = new SQLReader();
	//	sqlReader.refresh();
		DBHtml dbh = new DBHtml(machine, port, username, password, sid);
		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
		dbhs.executeSQL("OV_INIT_PARAM", "oracle/Overview-Database", chkTag, colName);
		out.println(dbhs.getHtmlTable());
	%>
</ul>

Hit Ratio:
<ul>
<table border="1" cellpadding="5" cellspacing="0">
<tr>
		<td><b>Buffer Type</b></td>
		<td><b>%</b></td>
</tr>

<tr>
<%
	// data buffer
	Database db = new Database(machine, port, username, password, sid);
	db.executeSQL("OV_HIT_RATIO");
	Vector resultVect = db.getResultVect();
	out.println("<td>Data Buffer: </td>"
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");
%>
</tr>

<tr>
<%
	// data dictionary
	db.executeSQL("OV_ROW_CACHE");
	resultVect = db.getResultVect();
	out.println("<td>Data Dictionary: </td>"
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");
%>
</tr>
<tr>
<%
	// library
	db.executeSQL("OV_LIB_CACHE");
	resultVect = db.getResultVect();
	out.println("<td>Library Cache: </td>"
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");

%>
</tr>
</table>
</ul>

Shared pool size:
<ul>
<%
	dbh.executeSQL("OV_SHARED_POOL_SIZE");
	out.println(dbh.getHtmlTable());
%>
</ul>
<P>


Shared pool detail break down:
	<A href="Overview-sys.jsp" target=body >Run as sys</a><br>
<P>


Sort:
<ul>
<%
	dbh.executeSQL("OV_SORT");
	out.println(dbh.getHtmlTable());
%>
</ul>


<h3>Datafile I/O</h3>
<ul>
<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("OV_DISK_IO", "oracle/Overview-Database", chkTag, colName);
	out.println(dbhs.getHtmlTable());
%>
</TR></TABLE>
</ul>

<h3>SQL Info:</h3>
<A href="Overview-SQL.jsp" target=body >Click here</a><br>

</body>
</html>
