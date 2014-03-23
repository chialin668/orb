<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Object Summary:</h3>

<%
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("SPACE_OBJ_COUNT_TOTAL", "oracle/space/ObjCount", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

	out.println("<p>");
	out.println("<h3>Detail:</h3>");
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("SPACE_OBJ_COUNT", "oracle/space/ObjCount", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>


</body>
</html>
