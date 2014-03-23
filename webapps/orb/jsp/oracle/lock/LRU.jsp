<%@ page import = "java.util.Hashtable" %>
<%@ page import = "com.orb.sys.ServerSession" %>
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

<h4>LRU latch count</h4>
<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	Hashtable criteriaTab = new Hashtable();
	criteriaTab.put("name", "db_block_lru_latches");
	dbhs.setCriteriaTable(criteriaTab);

	dbhs.executeSQL("DBA_PARAMETER", "oracle/lock/LRU", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>

<p>
<h3>Note:</h3>
<ul>
	<li>Control the replacement of buffers in the buffer cache.  Each LRU latch controls
		a set of buffers
	<li>Default value:
		<ul>
			<li>Single CPU: 1
			<li>SMP: 1/2 of the CPUs
		</ul>
	<li>Max value: Between 1 and # of CPUs
</ul>
</p>

<h4>Any contentions?</h4>
<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOCK_LRU", "oracle/lock/LRU", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>A latch should have more than 50 buffers in its set
	<li>Do NOT create multiple latches on a single CPU machine
	<li>For high CPU# system:
		<ul>
			<li>between (1/2 # of CPUs) and (# of CPUs)
			<li>between (# of CPUs) and 2x(# of CPUs)
		</ul>
	<li>Misses & sleeps should be <b>low</b>
	<li>If misses and sleeps are big or the hit ratios are lower than 99%,
		increase <b>DB_BLOCK_LRU_LATCHES</b>

</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Gets (wait): First attempt but have to wit
	<li>Misses (wait): Second time try to get a latch after failed the first time
	<li>Sleeps (wait): Put to sleep
	<li>Imm Gets (no wait): Gets the latch without waiting
	<li>Imm Misses (no wait): Doesn’t have to wait on the second time

</ul>



</body>
</html>
