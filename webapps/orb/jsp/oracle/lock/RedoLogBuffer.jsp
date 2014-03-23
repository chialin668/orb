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


<h3>How many redo log buffer?</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	Hashtable criteriaTab = new Hashtable();
	criteriaTab.put("name", "log_buffer");
	dbhs.setCriteriaTable(criteriaTab);

	dbhs.executeSQL("DBA_PARAMETER", "oracle/lock/RedoLogBuffer", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());

%>

<P>

<h3>Do we have any contention?</h3>

<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOCK_REDO_LOG", "oracle/lock/RedoLogBuffer", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>Latch contention rarely occurs on single-CPU computers, where only a single process can be active at once.

	<li>If "% Get", Get Hit Ratio, or "%Imm Get". Immediate Get Hit Ratio, less than
		99%, expend the redo buffer
	<li>Increase the redo buffer.  Bigger for DSS/batch/DW systems
	<li>Minimize the time that any single process holds the
		latch: Decrease <b>LOG_SMALL_ENTRY_MAX_SIZE</b> to reduce the number
		and size of redo entries copied on the redo allocation latch
		(for multi-CPU machines)
	<li>Increse <b>LOG_SIMUTANEOUS_COPIES</b> to reduce contention for the
		redo copy latches for multi-CPU machines.  Consider having twice as
		many as CPU available to your Oracle instance.
		<ul>
			<li>Default: # of CPs
			<li>Increase it to 2 x (# of CPUs)
		</ul>
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Redo log buffers are used to hold database changes before writing them to
		the online redo logs
	<li>These buffers operatie in a circular fashion and are controlled via internal
		database latches
	<li>Mare sure the buffer is large enough
	<p>

	<li><b>Redo Allocation Latch</b>: Control the allocation of space for redo entries in the redo log
				buffer.  Only one user process can allocate space in the buffer at
				a time (sequential nature of the redo loe)
	<li><b>Redo Copy Latch</b>: Control the copy of the redo log information to the buffer

	<p>

	<li>Multiple CPU: You can have multiple redo copy latches.  This allow multiple processes
			to concurrently copy entries to the redo log buffer concurrently
	<li>Sincle CPU: Should be <b>NO</b> redo copy latches
	<p>

	<li><b>Process Procecure</b>:
		<ul>
			<li>Obtain the copy latch (allow process to copy)
			<li>Obtain the allocation latch (perform allocation)
			<li>Allocation process
			<li>Release teh allocation latch
			<li>Perform the copy (under the copy latch)
			<li>Release the copy latch
			<li>NOTE: The allocation latch is held for only a short period of time
		</ul>
	<p>
	<li>WILLING-TO-WAIT: If the latch requested with a willing-to-wait request is not
				available, then the requesting process waits a short time and
				requests the latch again. The process continues waiting and
				requesting until the latch is available.
	<li>IMMEDIATE If the latch requested with an immediate request is not
		available, then the requesting process does not wait, but
		continues processing.
	<p>
	<li>GETS Shows the number of successful willing-to-wait requests for a latch.
	<li>MISSES Shows the number of times an initial willing-to-wait request was unsuccessful.
	<li>SLEEPS Shows the number of times a process waited and requested a latch
		after an initial willing-to-wait request.
	<li>IMMEDIATE GETS This column shows the number of successful immediate requests for each latch.
	<li>IMMEDIATE MISSES This column shows the number of unsuccessful immediate requests for each latch.
</ul>



</body>
</html>
