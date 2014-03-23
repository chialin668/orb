<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.oracle.SQLReader" %>


<%@ include file="../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<A href="/orb/jsp/sys/Overview-OLD.jsp">Old Overview</a>


<h3>Server Information</h3>
<ul>
	<A href="/orb/jsp/oracle/Overview-Database.jsp?">Overview</a><br>
	<A href="/orb/jsp/oracle/info/Info.jsp?">General Server Information</a><br>
	<A href="/orb/jsp/oracle/user/User.jsp?">User Information</a><br>
	<A href="/orb/jsp/oracle/cpu/CPU.jsp?">CPU</a><br>
	<A href="/orb/jsp/oracle/mem/Mem.jsp?">Memory</a><br>
	<A href="/orb/jsp/oracle/io/Io.jsp?">IO</a><br>
	<A href="/orb/jsp/oracle/space/Space.jsp?">Space Management</a><br>
	<A href="/orb/jsp/oracle/lock/Lock.jsp?">Contention Management</a><br>
	Object Management
		<ul>
			<li><A href="/orb/jsp/oracle/schema/SchemaFrame.jsp?">Object Management</a><br>
			<li><A href="/orb/jsp/oracle/schema/AnalyzeFrame.jsp?">Analyze Object</a><br>
		</ul>
</ul>

<h3>Server Monitoring Control</h3>
<ul>
	<A href="/orb/jsp/oracle/info/stat.jsp?">Stat</a><br>
	<A href="/orb/jsp/oracle/stat/StatFrame.jsp?">New Stat</a><br>

	<A href="/orb/jsp/oracle/stat/ConfigNew.jsp?">Config Stat</a><br>
	<A href="/orb/jsp/oracle/stat/StatFrameNew.jsp?">New Stat Result</a><br>
</ul>



<h3>Chart Test</h3>
<ul>

	<A href="/orb/jsp/oracle/stat/MonitorConfigFrame.jsp?">Start Monitoring a Stat</a><br>
	<A href="/orb/jsp/oracle/stat/StatFrame1.jsp?">Result: System Statistics</a><br>
	<A href="/orb/jsp/oracle/stat/MonitorStatFrame.jsp?">Result: Others</a><br>

	<p>
	<A href="/orb/jsp/graph/NewChart.jsp?">Chart Test</a><br>

</ul>

</body>
</html>
