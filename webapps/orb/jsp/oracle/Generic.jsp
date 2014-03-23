<%@ page import = "com.orb.oracle.DBHtmlSortable" %>

<%@ include file="../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title></title>
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>

</head>

<body>


<%
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String colNo = request.getParameter("colNo");
	String chartType = request.getParameter("chartType");
	String sqlTag = request.getParameter("sqlTag");

	SQLReader sqlReader = new SQLReader();
	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL(sqlTag, "Generic", chkTag, colName);
	out.println(dbhs.getHtmlTable());

%>

</body>
</html>
