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
	dbhs.executeSQL("STAT_SESSION_CPU", "oracle/cpu/SessionCPU", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>

	<li>Buffer gets are heavy on CPU
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>CPU used by this session: Amount of CPU time (in 10s of milliseconds) used
		by a session from the time a user call starts until it ends. If a user
		call completes within 10 milliseconds, the start and end user-call time
		are the same for purposes of this statistics, and 0 milliseconds are added.
		A similar problem can exist in the reporting by the operating system, especially
		on systems that suffer from many context switches.


</ul>


</body>
</html>
