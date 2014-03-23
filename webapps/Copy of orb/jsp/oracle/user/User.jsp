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
<P align=center>User Management</P>

<h3>User Management</h3>
<ul>
	<li><A href="/orb/jsp/oracle/user/Session.jsp?">Session Info</A>
	<li><A href="/orb/jsp/oracle/user/SessionStat.jsp?">Session Stat</A>
	<li><A href="/orb/jsp/oracle/user/OpenCursor.jsp?">Open Cursors</A>
	<li><A href="/orb/jsp/oracle/user/SessionCursorCache.jsp?">Session Cursor Cache</A>
	<li><A href="/orb/jsp/oracle/user/SystemCursorCache.jsp?">System Cursor Cache</A>
	<li><A href="/orb/jsp/oracle/user/UserSQL.jsp?">User SQL</A>
	<li><A href="/orb/jsp/oracle/user/ProblemSQL.jsp?">Problem SQLs</A>
	<li><A href="/orb/jsp/oracle/user/UserLock.jsp?">User Lock</A>
	<li><A href="/orb/jsp/oracle/user/UserLockDetail.jsp?">User Lock Detail</A>
	<li><A href="/orb/jsp/oracle/user/UserInRollbackSegs.jsp?">User in Rollback Segments</A>
	<li><A href="/orb/jsp/oracle/user/LockInRollbackSegs.jsp?">Locks in Rollback Segments</A>
</ul>
</body>
</html>
