<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtml" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="../Header.jsp"%>


<h3>Summary:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtml dbh = new DBHtml(machine, port, username, password, desc, sid);
	dbh.executeSQL("OV_ROW_CACHE");
	out.println(dbh.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>

	<li>If ratio  < 95%, increase SHARED_POOL_SIZE until the ratio stop improving
</ul>
</p>


</body>
</html>
