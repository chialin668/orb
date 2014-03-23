<%@ page import = "java.util.Vector" %>
<%@ page import = "Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<form target="machineResult" action="/orb/jsp/sys/machine/Result.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Stat Category:</td>
    <td>
	<select id=class name=class>
		<option value=ORACLE>Oracle 
		<option value=SYBASE>Sybase
		<option value=APACHE>Apache
	</select>	

	<td><input type="submit" value="Select" /></td>

</table>

</body>
</html>
