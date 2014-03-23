<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.Server" %>
<%@ page import = "java.util.Hashtable" %>
<%@ page import = "java.util.Enumeration" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>

	<A HREF="/orb/jsp/util/ServerList.jsp">Utilities</A>

	<form action="/orb/jsp/oracle/Overview-Database.jsp">
	<table cellspacing="2" cellpadding="2" border="0">
	<tr>
		<td>Select a Server ID:</td>
		<td>
		<select id=sid name=sid>
<%
	ServerInfo si = new ServerInfo();
	Hashtable serverTab = si.getServerTable();

	Enumeration keys = serverTab.keys();
	while(keys.hasMoreElements()) {
		String key = (String) keys.nextElement();
		Server s  = (Server) serverTab.get(key);
		out.println("<option value=" + s.getSid() + ">" + s.getSid());
	}
%>
		</select>

		<td><input type="submit" value="Get it!" /></td>

	</table>
	</form>



</body>
</html>
