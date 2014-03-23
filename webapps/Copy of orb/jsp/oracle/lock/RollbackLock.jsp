<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


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
	dbhs.executeSQL("LOCK_ROLLBACK_LOCK", "oracle/lock/RollbackLock", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>Who are currently updating the database
	<li>How far a multi-step program has progressed and
		whether a rollback will be necessary if the
		process is terminated
	<li>Rollback segments are allocated in a cyclic round-robin fashion
	<li>Each time a program commits a change, the server will skip to
		the next rollback segments
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>RSN: Rollback segment number
	<li>Name
	<li>OS User
	<li>Oracle Login
	<li>SID
	<li>Extents: Number of times rollback segment size is extended
	<li>Extends: Number of extends
	<li>Waits: Number of header waits
	<li>Shrinks: Number of times the size of a rollback segment decreases
	<li>Wraps: Number of times rollback segment is wrapped

</ul>



</body>
</html>
