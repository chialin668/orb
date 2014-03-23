<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="../Header.jsp"%>

<h3>Database Information:</h3>
<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DB_SGA", "oracle/info/SGA", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());

%>

<h4>Note:</h4>
<ul>
	<li>When you increase SGA, paging or swapping should not occur!
	<li>On UNIX: ·	SHMMAX > SGA
	<li>Intimate Shared Memory (ISM) on Solaris:
		<ul>
			<li>UNIX: /etc/system: set shmsys:share_page_table = 1
			<li>Oracle: USE_ISM = TRUE
		</ul>
	<li>Pre-load SGA: PRE_PAGE_AREA = YES (Not good for apps connect/disconnect all the time)
	<li>Swapping:
		<ul>$ vmstat -S 5 9
			<li>w: # of runnable processes have been swaped out (Should be 0)
			<li>so: # of swap-out/sec (Should be 0)
			<li>si: # of swap-in/sec (Should close to 0)
		</ul>
		<ul>$ sar -w 5 10
		</ul>
	<li>Paging:
		<ul>$ sar -p 10 10
			<li>rclm/s (page reclaim) should be 0
		</ul>
</ul>

<h4>Description:</h4>
<ul>
	<li>SGA:
	<ul>
		<li>Fixed Size: products installed
		<li>Variable Size: init parameters
		<li>Database Buffers: DB_BLOCK_BUFFERS &times; DB_BLOCK_SIZE
		<li>Redo Buffers: LOG_BUFFER
	</ul>
	<p>
	<li>No data is altered directly on the disk.
	All data process through SGA
		<ul>
		<li>Data block
		<li>Redo log
		<li>Dictionary
		<li>Sql shared pool (sql, procedures, triggers, packages)
		</ul>

	<li>Lease Recently Used (LRU) will be over-written
	<li>Dictionary cache:  (part of SHARED_POOL_SIZE)
	<ul>
		<li>User account
		<li>Data file names
		<li>Segment names
		<li>Extent locations
		<li>Table description
		<li>priviledges
	</ul>

</ul>


</body>
</html>
