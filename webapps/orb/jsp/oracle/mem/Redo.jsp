<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.oracle.DBHtml" %>


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
	dbhs.executeSQL("MEM_REDO", "oracle/mem/Redo", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>

<h4>Ratio:</h4>
<%
	DBHtml dbh = new DBHtml(machine, port, username, password, sid);
	dbh.executeSQL("MEM_REDO_RATIO");
	out.println(dbh.getHtmlTable());
%>


<h4>Wait time:</h4>
<%
	dbh = new DBHtml(machine, port, username, password, sid);
	dbh.executeSQL("MEM_REDO_WAIT_TIME");
	out.println(dbh.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>

	<li>IF redo log space requests/redo entries > 0.02 %, increase LOG_BUFFER (while no paging & swapping)
	<li>Redo log space request should be near 0, or not increasing.
		If thie number increases, increase LOG_BUFFER
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>

</ul>


</body>
</html>
