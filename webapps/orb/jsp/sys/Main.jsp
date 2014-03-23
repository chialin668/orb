<%@ page import = "com.orb.sys.ServerSession" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");

%>

<html>
<head>
	<title></title>
	<style type="text/css">
		<!-- @import "/orb/css/test.css"; -->
	</style>

</head>


<% if ((username != null && !username.equals("su"))
		|| (username != null && !password.equals("dna"))) {%>
<body>
	Login Incorrect!!
</body>

<%
	} else {

	String id = session.getId();
	ServerSession ss = new ServerSession();
	ss.setLogin(id);

%>


<body>

<table align=center border="0">
	<tr>
		<td><h3><u>Main Menu</u></h3><td>
	</tr>

	<tr>
		<td><A HREF="/orb/jsp/util/ServerList.jsp">Server Management</A></td>
	</tr>

	<tr>
		<td><A HREF="/orb/jsp/util/UserList.jsp">User Management</A></td>
	</tr>

	<tr>
		<td><A HREF="/orb/jsp/erd/ERD-main.jsp">ERD Design</A></td>
	</tr>

	<tr>
		<td><A HREF="/orb/jsp/oracle/Admin.jsp">Admin Information</A></td>
	</tr>

	<tr>
		<td><A HREF="/orb/jsp/oracle/Tuning.jsp">
				<span class=emphasis>Monitoring and Tuning</span></A></td>
	</tr>
</table>

</body>
<% } %>



</html>