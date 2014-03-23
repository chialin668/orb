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
	dbhs.executeSQL("DBA_FILE_INFO", "oracle/io/DBFile", chkTag, colName, desc, out);
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
	<li>File Name: The name of the file
	<li>MBytes: The size of the db file in mega bytes
	<li>Autoextensible: Is the file auto extensible?
	<li>Status: The status of the data file
</ul>


</body>
</html>
