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
	dbhs.executeSQL("STAT_SQL_EXEC_COUNT", "oracle/mem/Reparsing", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>

	<li>If Parse Calls ~ Exec Counts: Reparsing happens
	<li>If increase private SQL area, you can also increase OPEN_CURSORS
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>
</ul>


</body>
</html>
