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
//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtml dbh = new DBHtml(machine, port, username, password, sid);
	dbh.executeSQL("OV_SHARED_POOL_RESERVED");
	out.println(dbh.getHtmlTable());
%>

<p>
<h3>Note:</h3>
<ul>

	<li>SHARED_POOL_RESERVED_SIZE: 5% ~ 10% of SHARED_POOL_SIZE
	<li>SHARED_POOL_RESERVED_MIN_ALLOC: default
	<li>SHARED_POOL_RESERVED_POOL_MIN_ALLOC: default
		(Only larger than this can use the reserved space)

	<li>Goal:
		<ul>
		<li>request_failures = 0 or NOT increasing
		<li>last_failure_size > SHARED_POOL_RESERVED_MIN_ALLOC
		<li>avg_free_size > SHARED_POOL_RESERVED_MIN_ALLOC
		</ul>
	<li>IF NOT:
		<ul>
		<li>Increase SHARED_POOL_RESERVED_SIZE
		<li>SHARED_POOL_SIZE by the same amount as ARED_POOL_RESERVED_SIZE
		</ul>
</ul>
<hr>
<h3>If Too Large:</h3>


<%
	dbh = new DBHtml(machine, port, username, password, sid);
	dbh.executeSQL("OV_SHARED_POOL_RESERVED_LARGE");
	out.println(dbh.getHtmlTable());
%>

<p>
<h3>Note:</h3>
<ul>

	<li>request_misses = 0 (and not increasing)
	<li>free_memory bigger than 50% of SHARED_POOL_RESERVED_SIZE
	<li>(tow options)
		<ul>
		<li>Decrease SHARED_POOL_RESERVED_SIZE
		<li>Decrease SHARED_POOL_RESERVED_MIN_ALLOC if NOT the default value
		</ul>

</ul>


<hr>

<h3>If Too Small:</h3>

<%
	dbh = new DBHtml(machine, port, username, password, sid);
	dbh.executeSQL("OV_SHARED_POOL_RESERVED_SMALL");
	out.println(dbh.getHtmlTable());
%>

<p>
<h3>Note:</h3>
<ul>

	<li>request_failures > 0 ( and increases ) and at lease one of the following is true
		<ul>
		<li>last_failure_size 	> SHARED_POOL_RESERVED_MIN_ALLOC
		<li>max_free_size 	< SHARED_POOL_RESERVED_MIN_ALLOC
		<li>free_space 	< SHARED_POOL_RESERVED_MIN_ALLOC
		</ul>
	<li>(two options)
		<ul>
		<li>Increase SHARED_POOL_RESERVED_MIN_ALLOC and SHARED_POOL_SIZE
		<li>Increase SHARED_POOL_RESERVED_POOL_MIN_ALLOC
			(may need to increase SHARED_POOL_SIZE)
		</ul>
</ul>

</body>
</html>
