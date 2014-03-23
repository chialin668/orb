<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


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
	dbhs.executeSQL("IO_TABLE_SCAN", "oracle/io/TableScan", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>Make sure you don't have TOO MANY <b>long table scan</b>
	<li>Added index(es) to the tables (which???)
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Table scans (long tables): <b>more than 5 blocks</b>
	<li>Table scans (short tables): less than 5 blocks
</ul>

<hr>


<h3><b>Blocks</b> per long table scans:</h3>

<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("IO_BLOCKS_LONG_TABLE_SCAN", "oracle/io/TableScan", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>

<p>
<h3>Note:</h3>
<ul>
	<li>Block/long table scan
		= (table scan blocks gotten) - (short table scans * 5))
			/ long table scans
	<li>Make sure the blocks count is not too high
</ul>
</p>

<hr>

<h3>Who is doing table scan?</h3>

<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("IO_LONG_TABLE_SCAN_USER", "oracle/io/TableScan", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


</body>
</html>
