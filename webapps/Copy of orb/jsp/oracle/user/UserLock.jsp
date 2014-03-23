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
	dbhs.executeSQL("USER_LOCK", "oracle/user/UserLock", chkTag, colName, out);
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
	<li>Username
	<li>Sid
	<li>Type:
		<ul>
			<li>TM: DML enqueue
			<li>TX: Transaction enqueue
			<li>UL: User supplied
		</ul>
	<li>Mode: Lock mode in which the session holds the lock
	<li>Request: Lock mode in which the process requests the lock
	<li>Id1: Lock identifier #1 (depends on type) ???
	<li>Id2: Lock identifier #2 (depends on type) ???
</ul>



</body>
</html>
