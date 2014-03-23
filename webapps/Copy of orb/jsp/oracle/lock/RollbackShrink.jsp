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
	dbhs.executeSQL("LOCK_ROLLBACK_SHRINK", "oracle/lock/RollbackShrink", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>If the OPTIMAL size is too small, the database (SMON) will continually shrink the
		rollback segments after the transaction completes.
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Name
	<li>Extents: Number of extends
	<li>Waits
	<li>Shrinks
	<li>Extends: Number of times rollback segment size is extended
	<li>HWM: High Water Mark size

</ul>



</body>
</html>
