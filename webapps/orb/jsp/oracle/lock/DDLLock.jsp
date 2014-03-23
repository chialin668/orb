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
	dbhs.executeSQL("LOCK_DDL", "oracle/lock/DDLLock", chkTag, colName, desc, out);
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
	<li>User:
	<li>Owner: Owner of the lock
	<li>Name: Name of the lock
	<li>Type: Lock type
		<ul>
			<li>CURSOR
			<li>TABLE/PROCEDURE/TYPE,BODY
			<li>TRIGGER
			<li>INDEX
			<li>CLUSTER
		</ul>
	<li>Mode:Lock mode
		<ul>
			<li>NONE
			<li>NULL
			<li>SHARE
			<li>EXCLUSIVE
		</ul>

</ul>



</body>
</html>
