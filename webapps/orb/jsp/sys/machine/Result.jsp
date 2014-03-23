<%@ page import = "OraMonitor" %>

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
	
Machine: <%=machine%>
<p>

<%
	
	String classId = request.getParameter("class");
%>
<table cellspacing="2" cellpadding="2" border="0">
	<tr>
		<td>SID:</td>  <td><INPUT name=sid size=10 value=></td>
	</tr>
	
	<tr>
		<td>Port:</td>  <td><INPUT name=port size=10 value=></td>
	</tr>
	
	<tr>
		<td>Username:</td>  <td><INPUT name=username size=10 value=></td>
	</tr>
	
	<tr>
		<td>Password:</td>  <td><INPUT name=password size=10 value=></td>
	</tr>
	
	<tr>
		<td></td><td><input type="submit" value="Add" /></td>

	</tr>
	
</table>
	
</body>
</html>
