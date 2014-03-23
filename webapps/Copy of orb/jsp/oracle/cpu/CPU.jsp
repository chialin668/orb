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
<P align=center>CPU Management</P>

<h3>User Management</h3>
<ul>
	<li>Reparsing
	<ul>
		<li><A href="/orb/jsp/oracle/cpu/Reparse.jsp?">Reparsing counts</A>
		<li><A href="/orb/jsp/oracle/cpu/ReparseSQL.jsp?">Reparsed SQL</A>
		<li><A href="/orb/jsp/oracle/cpu/BufferGets.jsp?">High Buffer Gets SQL</A>
		<li><A href="/orb/jsp/oracle/cpu/SessionCPU.jsp?">Session CPU</A>
	</ul>
	<p>
	
	<li><A href="/orb/jsp/oracle/cpu/BufferScan.jsp?">Average Buffer Scan</A>
	<p>
	
	<li>Event waits
		<ul>
		<li><A href="/orb/jsp/oracle/cpu/Wait.jsp?">Wait Detection</A>
		<li><A href="/orb/jsp/oracle/cpu/Wait-USR.jsp?">User Wait Detection</A>
		<li><A href="/orb/jsp/oracle/cpu/Wait-BG.jsp?">Background Wait Detection</A>
		</ul>
	<p>
	
	<li>Latch Contention
</ul>
</body>
</html>
