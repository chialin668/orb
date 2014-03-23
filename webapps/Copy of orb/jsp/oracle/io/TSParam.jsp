<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Machine: <%=machine%></h3>
<h3>SID: <%=sid%></h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DBA_TS_PARAMS", "oracle/io/TSParam", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>

<p>
<h3>Note:</h3>
<ul>
	<li>Make sure all (but the system tablespace) to have PCT increase to be <b>0</b>.
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>TS Name: Tablespace name
	<li>Int Extent: Initial extent
	<li>Next Extent: Next extent
	<li>Min Extent: Min extent
	<li>Max Extent: Max extent
	<li>Pct Increase: PCT increase
</ul>


</body>
</html>
