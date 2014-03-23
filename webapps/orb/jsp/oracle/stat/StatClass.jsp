<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<form target="statForm" action="/orb/jsp/oracle/stat/StatForm.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Select an owner:</td>
    <td>
	<select id=class name=class>
		<option value=1>User
		<option value=2>Redo
		<option value=4>Enqueue
		<option value=8>Cache
		<option value=16>OS
		<option value=32>Parallel Server
		<option value=63>SQL
		<option value=128>Debug
	</select>

	<td><input type="submit" value="Get Stat Name" /></td>

</table>

<A target=basefrm href="/orb/jsp/oracle/space/Space.jsp?">Back</A>

</body>
</html>
