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

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtml dbhs = new DBHtml(machine, port, username, password, sid);
	dbhs.executeSQL("OV_SHARED_POOL_SIZE");
	out.println(dbhs.getHtmlTable());
%>



<h3>Note:</h3>
<ul>

	<li>Contains:
	<ul>
		<li>Data dictionary cache
		<li>Parsed PL/SQL & SQL
		<li>Procedures
		<li>Functions
		<li>Packages
		<li>Triggers
		<li>Anonymous PL/SQL
		<li>Session information for multi-threaded server.
		<li>Library cache
	</ul>

	<li>IF library cache OK à data dictionary cache OK
	<li>A cache miss on the library cache/data dictionary cache is more expensive
			than a miss on the buffer cache.
	<li>Only multi-threaded server needs space in the shared pool for
		session information.
	<li>Shared pool size often set to large
		<ul>
			<li>free memory should à 0 during peak loads
			<li>library, dictionary cache hit ratios à 95%
		</ul>
	<li>Less important if application issues a very limited # of discrete SQL.
	<li>If the number of procedures or triggers increase, increase SHARED_POOL_SIZE
		(It may even reach a size measured in tens of megabytes.)

</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>
</ul>


</body>
</html>
