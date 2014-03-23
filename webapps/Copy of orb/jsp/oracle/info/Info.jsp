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


<h3>Database:</h3>
<ul>
	<li><A href="/orb/jsp/oracle/info/DBInfo.jsp?">Database Information</A>
	<p>
	<li>Init Parameters:
	<ul>
		<li><A href="/orb/jsp/oracle/Generic-sys.jsp?sqlTag=DB_INIT_PARAM">Init Parameters</A>
		<li><A href="/orb/jsp/oracle/Generic-sys.jsp?sqlTag=DB_INIT_NON_DEFAULT_PARAM">Non-Default Init Parameters</A>
		<li><A href="/orb/jsp/oracle/Generic-sys.jsp?sqlTag=DB_INIT_PARAM_DESC">Init Parameters Description</A>
		<li><A href="/orb/jsp/oracle/Generic-sys.jsp?sqlTag=DB_INIT_PARAM_UNDOC">UndocumentedParameters </A>
		<li><A href="/orb/jsp/oracle/Generic-sys.jsp?sqlTag=DB_INIT_PARAM_ISSES">System modifiable Parameters </A>
		<li><A href="/orb/jsp/oracle/Generic-sys.jsp?sqlTag=DB_INIT_PARAM_ISSYS">Session modifiable Parameters </A>
	</ul>
</ul>

<h3>Instance:</h3>
<ul>
	<li><A href="/orb/jsp/oracle/info/Background.jsp?">Background Processes</A>
	<li><A href="/orb/jsp/oracle/info/SGA.jsp?">SGA (System Global Area)</A>
	<li><A href="/orb/jsp/oracle/info/DBInfo.jsp?">System Statistics</A>
</ul>	


<h3>Control file:</h3>
<ul>
	<li><A href="/orb/jsp/oracle/info/Controlfile.jsp?">Control file information</A>
</ul>	


<h3>Log:</h3>
<ul>
	<li><A href="/orb/jsp/oracle/info/Log.jsp?">Redo Logs</A>
	<li><A href="/orb/jsp/oracle/info/LogHistory.jsp?">Logs History</A>
	<li><A href="/orb/jsp/oracle/info/LogBuffAllocation.jsp?">Logs Buffer Allocation Retry</A>
	<li><A href="/orb/jsp/oracle/info/Archive.jsp?">Archive information</A>
</ul>	


</body>
</html>
