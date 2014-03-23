<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.Server" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<%
	String submit = request.getParameter("submit");
	int svrType = 0;
	String svrName = "";
	String svrPort = "";
	String svrUsername = "";
	String svrPassword = "";
	String svrSID = request.getParameter("svrSID");

	if (svrSID != null) {
		ServerInfo si = new ServerInfo();
		Server server = si.getServerBySid(svrSID);

		svrType = server.getType();
		svrName = server.getMachine();
		svrPort = server.getPort();
		svrUsername = server.getUsername();
		svrPassword = server.getPassword();
	} else
		svrSID = "";

%>

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="Header.jsp"%>

<form action="/orb/jsp/util/ServerList.jsp?">
<table cellspacing="2" cellpadding="2" border="0">
<tr>

	<tr>
		<td>Server Type:</td>
		<td>
		<select id=type name=svrType>
			<option value=Oracle>Oracle
			<option value=Sybase>Sybase
		</select>
		</td>
	</tr>


	<tr>
		<td>Machine Name: </td>
		<td><input type="text" size="20" value="<%=svrName%>" name="svrName"></td>
	</tr>

	<tr>
		<td>Port: </td>
		<td><input type="text" size="20" value="<%=svrPort%>" name="svrPort"></td>
	</tr>

	<tr>
		<td>Username: </td>
		<td><input type="text" size="20" value="<%=svrUsername%>" name="svrUsername"></td>
	</tr>

	<tr>
		<td>Password: </td>
		<td><input type="password"  size="20" value="<%=svrPassword%>" name="svrPassword"></td>
	</tr>

	<tr>
		<td>SID: </td>
		<td><input type="text" size="20" value="<%=svrSID%>" name="svrSID"></td>
	</tr>

<td>
<%	if (submit!= null && submit.equals("Add")) { %>
	<input type="submit" name="submit" value="Add" />
<%	} else { %>

	<input type="submit" name="submit" value="Modify" />
	<input type="submit" name="submit" value="Remove" />
<% } %>


</td>



</tr>

</body>
</html>
