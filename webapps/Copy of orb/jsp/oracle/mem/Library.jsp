<%@ page import = "com.orb.oracle.DBHtml" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Overview:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtml dbh = new DBHtml(machine, port, username, password, sid);
	dbh.executeSQL("OV_LIB_CACHE");
	out.println(dbh.getHtmlTable());
%>

<p>
<h3>Detail:</h3>

<%
	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("OV_LIB_CACHE_DETAIL", "oracle/mem/Library", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>

	<li>Make sure
		<ul>
		<li>SQL statements are the same
		<li>Use bind variables
		</ul>
	<li>IF ratio < 99% (at least 95%), increase SHARED_POOL_SIZE until the ratio stop improving
	<li>reload should close 0
	<li>IF reloads/pins > 1%, Allocate additional memory
		<ul>
		<li>Increase SHARED_POOL_SIZE
		<li>Increase OPEN_CURSORS
		</ul>
	<li>IF reload close to 0 and you still want to improve the performance:
		CURSOR_SPACE_FOR_TIME = TRUE
	<li>CURSOR_SPACE_FOR_TIME = TRUE (default = FALSE)
		<ul>
		<li>Shared SQL areas to be pined in the shared pool. (Will not be page out)
		<li>NOTE: Set this only if your shared pool is large enough
		</ul>



</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>
</ul>


</body>
</html>
