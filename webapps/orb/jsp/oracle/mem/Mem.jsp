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
<%@ include file="../Header.jsp"%>

<P align=center>Memory Management</P>

<h3>Memory Management</h3>
<ul>
	<li><A href="/orb/jsp/oracle/info/SGA.jsp?">SGA</A>
	<li><A href="/orb/jsp/oracle/mem/SGADetail.jsp?">SGA Detail</A>

</ul>

<h3>Detail:</h3>
<ul>
	<li><A href="/orb/jsp/oracle/mem/Redo.jsp?">Redo Buffers</A>
	<p>
	<li>Variable Size
		<ul>
		<li><A href="/orb/jsp/oracle/mem/SharedPool.jsp?">Shared Pool</A>
			<ul>
			<li><A href="/orb/jsp/oracle/mem/Dictionary.jsp?">Dictionary Cache Hit Ratio</A>
			<li><A href="/orb/jsp/oracle/mem/Library.jsp?">Library Cache Hit Ratio & Detail</A>
			<li><A href="/orb/jsp/oracle/mem/SharedPoolReserved.jsp?">Shared Pool Reserved</A>
			</ul>
			<p>
		<li>Private SQL Area:
			<ul>
			<li><A href="/orb/jsp/oracle/mem/Reparsing.jsp?">Reparsing</A>
			<li><A href="/orb/jsp/oracle/mem/ReparsingWho.jsp?">Who is doing reparsing</A>
			</ul>
			<p>
		<li><A href="/orb/jsp/oracle/mem/Cursor.jsp?">Session Cache Cursors</A>
		</ul>
	<p>

	<li><A href="/orb/jsp/oracle/mem/Buffer.jsp?">Database Buffers</A>
</ul>
</body>
</html>
