<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

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

<h3>Current Configuration:</h3>

<hr>
<form action="/orb/jsp/oracle/stat/ConfigResult.jsp">
	<td>
	Repository Server: <select name=repos>
		<option value=REPOS>REPOS
		<option value=CHIALIN>CHIALIN
	</select>
	</td>

	<td>
	Type: <select name=type multiple=true size=3>
		<option value=STAT_STAT>Stat
		<option value=STAT_DF_SIZE>Data File Size
		<option value=STAT_DF_FREE>Free Space
	</select>
	</td>

	<td>
	Interval: <select name=interval>
		<option value=5>5 Second
		<option value=60>1 Minute
		<option value=300>5 Minute
		<option value=900>15 Minute
		<option value=1800>30 Minute
		<option value=3600>1 Hour
		<option value=14400>4 Hour
		<option value=21600>6 Hour
		<option value=43200>12 Hour
		<option value=86400>24 Hour
	</select>
	</td>

	<td><input type="submit" value="Set" /></td>

</body>
</html>
