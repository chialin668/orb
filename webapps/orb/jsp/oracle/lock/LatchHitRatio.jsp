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
	dbhs.executeSQL("LOCK_LATCH_HIT_RATIO", "oracle/lock/LatchHitRatio", chkTag, colName, desc, out);
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
	<li>GETS Shows the number of successful willing-to-wait requests for a latch.
	<li>MISSES Shows the number of times an initial willing-to-wait request was unsuccessful.
	<li>SLEEPS Shows the number of times a process waited and requested a latch
		after an initial willing-to-wait request.
	<li>IMMEDIATE GETS This column shows the number of successful immediate requests for each latch.
	<li>IMMEDIATE MISSES This column shows the number of unsuccessful immediate requests for each latch.
</ul>



</body>
</html>
