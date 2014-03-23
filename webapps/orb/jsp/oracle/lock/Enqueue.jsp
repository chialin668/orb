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


<h3>Wait/Timeout:</h3>

<%
//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOCK_ENQUEUE_WAIT", "TSSize", null, null, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>ENQUEUE_RESOURCES: the # of resources that can be locked concurrently
	<li>IF enqueue waits or enqueue timeouts is high
		<ul>
			<li>Increase ENQUEUE_RESOURCES
			<li>Increase DML_LOCKS
				<ul>
					<li>(max users) ´ # of tables being modify in a transaction
					<li>If 4 users are modifying 3 tables à DML_LOCKS = 12
				</ul>
			<li>Increase SESSIONS
			<li>Increase PROCESSES
			<li>Increase semaphores
		</ul>

</ul>

<h3>Description:</h3>
<ul>
	<li>enqueue waits: Total number of waits that occurred during an enqueue
		convert or get because the enqueue get was deferred
	<li>enqueue timeouts: Total number of table and row locks (acquired and converted)
		that timed out before they could complete
</ul>

</p>

<hr>

<h3>Request/Release:</h3>

<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOCK_ENQUEUE_REQUEST", "TSSize", null, null, out);
	out.println(dbhs.getHtmlTable());
%>

<h3>Note:</h3>
<ul>
	<li>IF enqueue releases ~= enqueue requests --> sufficient enqueue resources exists
	<li>IF enqueue releases < enqueue requests
		<ul>
			<li>Increase ENQUEUE_RESOURCES
			<li>Increase DML_LOCKS
				<ul>
					<li>(max users) ´ # of tables being modify in a transaction
					<li>if 4 users are modifying 3 tables à DML_LOCKS = 12
				</ul>
			<li>Increase SESSIONS
			<li>Increase PROCESSES
			<li>Increase semaphores
		</ul>

</ul>


<h3>Description:</h3>
<ul>
	<li>enqueue requests: Total number of table or row locks acquired
	<li>enqueue releases: Total number of table or row locks released

</ul>



</body>
</html>
