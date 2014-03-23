<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Summary:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

	SQLReader sqlReader = new SQLReader();
	sqlReader.refresh();

	DBHtml dbh = new DBHtml(machine, port, username, password, sid);
	dbh.executeSQL("OV_SESSION_CACHE_CURSORS");
	out.println(dbh.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>

	<li>IF close and then reopen session cursor frequently:
		SESSION_CACHED_CURSORS = max # of sessions keep in the library cache.
			Also check the library hit ratio (should not be too low)

</ul>
</p>


</body>
</html>
