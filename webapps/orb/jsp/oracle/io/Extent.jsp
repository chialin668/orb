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
	dbhs.executeSQL("DBA_EXTENTS", "oracle/io/Extent", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());

%>

<p>
<h3>Note:</h3>
<ul>
	<li> Make sure <b>% Used</b> is not too high
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>TS Name: The name of the tablespace
	<li>File Name: The name of the file
	<li>Ext Count: How many extents in the file
	<li>File Size: The size of the data file in MB
	<li>Used size: The size of the data file in use
	<li>% Used
	<li>AutoExt: Whether the file is auto extensible
</ul>


</body>
</html>
