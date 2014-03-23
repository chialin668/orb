<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.Server" %>
<%@ page import = "com.orb.sys.Environment" %>
<%@ page import = "com.orb.util.ReadObj" %>
<%@ page import = "com.orb.util.WriteObj" %>
<%@ page import = "java.io.FileNotFoundException" %>
<%@ page import = "java.io.IOException" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<%
	String submit = request.getParameter("submit");
	String svrType = request.getParameter("svrType");
	String svrName = request.getParameter("svrName");
	String svrPort = request.getParameter("svrPort");
	String svrUsername = request.getParameter("svrUsername");
	String svrPassword = request.getParameter("svrPassword");
	String svrSID = request.getParameter("svrSID");


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
%>

<html>
<head>
	<title></title>
</head>

<body>



</tr>

</body>
</html>
