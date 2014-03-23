<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<form target="monitorConfigResult" action="/orb/jsp/oracle/stat/MonitorConfigResult.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Stat Category:</td>
    <td>
	<select id=class name=class>
		<option value=STAT_STAT>System Statistics
		<option value=MON_LATCH>Latches
		<option value=MON_ROLLSTAT>Rollback Segments
		<option value=MON_LIBRARYCACHE>Library Cache
		<option value=MON_ROWCACHE>Rowcache (Dictionary)
		<option value=MON_SYSTEM_EVENT>System Events
		<option value=MON_BACKGROUND_EVENT>Background Events
		<option value=MON_DATA_FILES>Data files
		<option value=MON_WAITSTAT>Waits

	</select>

	<td><input type="submit" value="Get Stat Name" /></td>

</table>

</body>
</html>
