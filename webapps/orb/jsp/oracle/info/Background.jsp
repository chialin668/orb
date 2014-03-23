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

	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();
//
	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DB_BG_PROCESS", "oracle/info/Background", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());

%>


<h4>Description:</h4>
<ul>
	<li>Oracle processes:
	<ul>
		<li>4 base processes
		<ul>
			<li>DBWR
			<li>LGWR
			<li>SMON
			<li>PMON
		</ul>
			<li>Archiving
			<li>Tcp/ip
			<li>Parallel
			<li>distributed
	</ul>
</ul>

<hr>

<ul>
	<li>DBWR (Database Writer): Performs batch writes
		SGA:
			Data block cache
			Dict cache --> data files

	<li>LGWR (Log Writer):	Redo log buffer --> redo log files

	<li>SMON: System monitor
		<ul>
		<li>Instance recovery on instance startup
		<li>Clean up temporary segments
		<li>Parallel: recovers failed nodes
		<li>Reduce fragmentation
		</ul>

	<li>PMON: Process Monitor.  Recover user processes, clean up cache à failed proc

	<li>ARCH (Archiver):
		Redo log file à archive log data file

	<li>RECO (Distributed Transaction Recover):
		Resolve fialures involving distributed transaction
		<ul>
		<li>Distributed option supported
		<li>DISTRIBUTED_TRANSACTIONS>0
		</ul>

	<li>LCKn (Lock process):
		Inter-instance locking (Parallel Server env.)
		GC_LCK_PROCS

	<li>Dnnn (Dispatcher):
		SQL*Net v2 MTS (Multi-Threaded Server)

	<li>Snnn Server
		Resolve users’ calls

	<li>Listener Tcp/IP server
		One per node

	<li>CKPxx (Checkpoint)
		<ul>
		<li>Caluse DBWR to write all of the blocks that have been changed since last checkpoint
		<li>Update data headers and control files
		<li>Automatically issued when an online redo log fills
		<li>LOG_CHECKPOINT_INTERNAL
		<li>Split CKPT from LGWR
			<ul>
				<li>CHECKPOINT_PROCESS=TRUE
			</ul>
		</ul>

	<li>Snpxx shanpshot process queues

	<li>Aq_tnxx Advanced Queueing Processes

	<li>EXTPROC Callout Queues

	<li>ARCHMON Archive Monitor (Unix Only)
		Monitor the archive process and write redo logs to the archvies
		(Requires a dedicated window for BSD)
</ul>


</body>
</html>
