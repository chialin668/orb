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
	dbhs.executeSQL("LOCK_DML", "oracle/lock/DMLLock", chkTag, colName, out);
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
	<li>Mode:Lock mode
		<ul>
			<li>ROWS_S (SS): row share lock
			<li>ROW-X (SX): row exclusive lock
			<li>SHARE (S): share lock
			<li>S/ROW-X (SSX): exclusive lock
			<li>NONE: lock requested but not yet obtained
		</ul>

</ul>



</body>
</html>
