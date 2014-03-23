<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.oracle.DBHtml" %>

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
	dbh.executeSQL("OV_HIT_RATIO");
	out.println(dbh.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>

	<li>Tune: private SQL -> shared pool -> buffer cache
	<li>OLTP: Use 2k or 4k to allow more buffers to be cached in memory
	<li>Note:
		<ul>
		<li>If hit ratio is too high and you may reserved space for other usage!!
		<li>Table scan will NOT be put to the head of the LRU list.
		<li>CACHED_SIZE_THREADHOLD (max size of a table to be cached [in blocks]) = 1/10 ´
				(DB_BLOCK_BUFFERS) (should be smaller for large OLTP)
		</ul>
	<li>If
		<ul>
		<li>Ratio < 0.9
		<li>No evidence of undue page faulting
		<li>The previous increase of DB_BLOCK_BUFFERS was effective
		</ul>
</ul>
<hr>

<h3>Predict Additional Buffer Cache/Hit Ratio:</h3>
<ul>
	<li>DB_BLOCK_LRU_STATISTICS = TRUE
	<li>0 < DB_BLOCK_LRU_EXTENDED_STATISTICS < DB_BLOCK_BUFFERS
		<ul>
		<li>eg DB_BLOCK_LRU_EXTENDED_STATISTICS = 100
			100 rows of statistic results in x$kcbrbh for 100 buffers
		</ul>
	<li>NOTE: use svrmgrl connect as internal

	<li>eg. How many more cache hits would occur if you added 20 more buffers to the cache?
		select sum(count)
		from sys.x$kcbrbh
		where indx < 20;

	<li>eg.
		<ul>
		select 250*trunc(indx/250)+1 || ‘ to ‘
			|| 250*(trunc(indx/250)+1),  -- the internal of
							-- additional buffers
							-- added to the cache
				sum(count)		  -- additional cache
							 -- hits to be gained
		from sys.x$kcbrbh
		group by trunc(indx/250);
		</ul>

</ul>
</p>


</body>
</html>
