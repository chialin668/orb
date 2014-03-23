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
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DBA_DB_FILE_FREE_SPACE", "oracle/space/FreeSpace", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>

<p>
<h3>Note:</h3>
<ul>
	<li> You can use 'alter tablespace [tablespace name] coalesce; to consolidate the free extents.
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>File Name: The name of the data file
	<li>Size: The size of the file (in Mega bytes)
	<li>Piece: How many piece of free extents does this file have
	<li>Maximum: The size of the biggest freed extent
	<li>Minimun: The size of the smallest freed extent
	<li>Total: Total free extents this file have
	<li>Auto Ext: Whether this file is auto extensible
	<li>TS Name: Tablespace name
</ul>


</body>
</html>
