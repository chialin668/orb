<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Space Used by Each User:</h3>

<%
//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtml dbh = new DBHtml(machine, port, username, password, sid);

	dbh.executeSQL("SPACE_FILE_MAP");
	out.println(dbh.getHtmlTable());

%>



</body>
</html>
