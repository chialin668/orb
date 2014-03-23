<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>

<form action="http://www.yahoo.com">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
	<td>
	<select id=type name=type>
		<option value=table>Table
		<option value=index>Index
	</select>
	</td>

	<td><input type="submit" value="Get Objects" /></td>
</tr>

</body>
</html>
