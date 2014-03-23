<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.Server" %>
<%@ page import = "com.orb.sys.SerializeObj" %>
<%@ page import = "java.util.Hashtable" %>
<%@ page import = "java.util.Enumeration" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<%
	String submit = request.getParameter("submit");
	String svrType = request.getParameter("svrType");
	String svrName = request.getParameter("svrName");
	String svrPort = request.getParameter("svrPort");
	String svrUsername = request.getParameter("svrUsername");
	String svrPassword = request.getParameter("svrPassword");
	String svrSID = request.getParameter("svrSID");

	if (submit != null) {
		Server server = new Server(Server.ORACLE, "xx.x.x",
										svrName, svrPort,
										svrUsername, svrPassword,
										svrSID);
		ServerInfo si = new ServerInfo();

		if (submit.equals("Add"))
			si.add(svrSID, server);
		else if (submit.equals("Modify"))
			si.add(svrSID, server);
		else if (submit.equals("Remove"))
			si.remove(svrSID);
	}
%>

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="Header.jsp"%>

Server Information:
<ul>
	<table border="1" cellpadding="5" cellspacing="0">
		<tr>
				<td><b>Change<b></td>
				<td><b>SID</b></td>
				<td><b>Type</b></td>
				<td><b>Machine</b></td>
				<td><b>Port</b></td>
				<td><b>Username</b></td>
		</tr>

<%
	ServerInfo si = new ServerInfo();
	Hashtable serverTab = si.getServerTable();

	Enumeration keys = serverTab.keys();
	while(keys.hasMoreElements()) {
		String key = (String) keys.nextElement();
		Server s  = (Server) serverTab.get(key);
		out.println("<tr>");
		out.println("<td><a href='/orb/jsp/util/ServerForm.jsp?svrSID=" + s.getSid()
							+ "'><img align=right border=0 src='/images/edit.gif'></a></td>");
		out.println("<td>" + s.getSid() + "</td>");
		out.println("<td>" + s.getType() + "</td>");
		out.println("<td>" + s.getMachine() + "</td>");
		out.println("<td>" + s.getPort() + "</td>");
		out.println("<td>" + s.getUsername() + "</td>");
		out.println("</tr>\n");
	}
%>
	</table>
</ul>


<form action="/orb/jsp/util/ServerForm.jsp?">
	<input type="submit" name="submit" value="Add" />
</form>


</body>
</html>
