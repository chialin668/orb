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


<h3>Machine: <%=machine%></h3>
<h3>SID: <%=sid%></h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOG_HISTORY", "oracle/io/LogHistory", chkTag, colName, desc, out);
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
	<li>Rec Id: Control file record ID
	<li>Stamp: Control file record stamp
	<li>Thread: Thread: of the archived log
	<li>Sequence: Sequence: of the archived log
	<li>Low SCN Time: DATE Time of first entry (lowest SCN) in the log. This column was previously named TIME
	<li>Low SCN: Lowest SCN in the log. This column was previously named LOW_CHANGE#
	<li>High SCN: Highest SCN in the log. This column was previously named HIGH_CHANGE#
</ul>



</body>
</html>
