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

<h4>Top 10 Buffer Gets/executions</h4>
<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

	SQLReader sqlReader = new SQLReader();
	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("STAT_SQL_BUFFER1", "oracle/cpu/BufferGets", chkTag, colName, out);
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
	<li>

</ul>


</body>
</html>
