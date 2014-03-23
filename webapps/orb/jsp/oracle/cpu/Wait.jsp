<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


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
	dbhs.executeSQL("STAT_WAIT_EVENT", "oracle/cpu/Wait", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>

	<li>Time on cpu spent waiting for a resource or action to complete
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Event: the name of the wait event
	<li>Waits: The total number of waits for this event
	<li>Time: The total amount of time waited for this event, in hundredths of a second (1/100 sec)
	<li>Timeouts: The total number of timeouts for this event


</ul>


</body>
</html>
