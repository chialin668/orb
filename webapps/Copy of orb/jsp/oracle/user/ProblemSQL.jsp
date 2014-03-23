<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Summary:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("OV_SQL", "oracle/user/ProblemSQL", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Sid
	<li>Login: Oracle login
	<li>Disk Reads: The sum of the number of disk reads (over all child cursors)
	<li>Execs: The total number of executions, totalled (over all the children)
	<li>Read/Exec: The sum of the number of disk reads/The total number of executions
	<li>Buffer Gets: The sum of buffer gets (over all the children)
	<li>Sorts: The sum of the number of sorts that was done (over all the children)
	<li>SQL: The first eighty characters of the SQL text
</ul>



</body>
</html>
