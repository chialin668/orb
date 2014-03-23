<%@ include file="../../sys/Session.jsp"%>

<%
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<P align=center>Contention Management</P>

<li>Latches:
	<ul>
		<li><A href="/orb/jsp/oracle/lock/LatchOverview.jsp?">Overview</A>
		<li><A href="/orb/jsp/oracle/lock/LatchHitRatio.jsp?">Hit Ratio</A>
		<li><A href="/orb/jsp/oracle/lock/LatchProcessHolding.jsp?">Process Holding Latches</A>
		<li><A href="/orb/jsp/oracle/lock/LatchProcessWaiting.jsp?">Process Waiting Latches</A>
		<li>Rollback segments
			<ul>
				<li><A href="/orb/jsp/oracle/lock/RollbackSegsOverview.jsp?">Rollback Segment Overview</A>
				<li><A href="/orb/jsp/oracle/lock/RollbackSegs.jsp?">Rollback Segment</A>
				<li><A href="/orb/jsp/oracle/lock/RollbackShrink.jsp?">Rollback Shrinkage</A>
				<li><A href="/orb/jsp/oracle/lock/DiscreteTransaction.jsp?">Discrete Transaction</A>
				<li><A href="/orb/jsp/oracle/lock/RollbackLock.jsp?">Rollback locks</A>
			</ul>
		<li><A href="/orb/jsp/oracle/lock/RedoLogBuffer.jsp?">Redo Log Buffer</A>
		<li><A href="/orb/jsp/oracle/lock/LRU.jsp?">Least Recently Used (LRU)</A>
		<li><A href="/orb/jsp/oracle/lock/FreeList.jsp?">Free List</A>
		<li><A href="/orb/jsp/oracle/lock/LatchSpinCount.jsp?">Latch Spin Count</A>
		<li><A href="/orb/jsp/oracle/user/Session.jsp?">Who is using the system</A>
	</ul>
<li>User Lock:
	<ul>
		<li><A href="/orb/jsp/oracle/lock/LockOverview.jsp?">Overview</A>
		<li><A href="/orb/jsp/oracle/lock/WhoLocksWho.jsp?">Who locks who</A>
		<li><A href="/orb/jsp/oracle/lock/WhoDoesWhat.jsp?">Who is doing what</A>
		<li><A href="/orb/jsp/oracle/lock/DDLLock.jsp?">DDL locks</A>
		<li><A href="/orb/jsp/oracle/lock/DMLLock.jsp?">DML locks</A>
	</ul>

<li>Enqueue:
	<ul>
		<li><A href="/orb/jsp/oracle/lock/Enqueue.jsp?">Enqueue</A>
	</ul>

</p>



</body>
</html>
