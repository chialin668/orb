<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Database Information:</h3>
<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOG_FILE", "oracle/info/Log", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>


<h4>Description:</h4>
<ul>
	<li>
</ul>


</body>
</html>
