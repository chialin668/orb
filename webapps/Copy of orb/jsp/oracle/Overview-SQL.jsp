<%@ page import = "com.orb.oracle.DBHtml" %>

<%@ include file="../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>SQL</title>
</head>

<body>


<P>

<h3>Problem SQLs:</h3>
<ol>
<%
	DBHtml dbh = new DBHtml(machine, port, username, password, sid);

	dbh.executeSQL("OV_SQL");
	out.println(dbh.getHtmlTable());

%>
</TR></TABLE>
</ol>

<h3>SQL Areas:</h3>
<ol>
<%
	dbh.executeSQL("OV_SQL_AREA");
	out.println(dbh.getHtmlTable());

%>
</TR></TABLE>
</ol>


</body>
</html>
