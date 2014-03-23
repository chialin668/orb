<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.Server" %>
<%@ page import = "com.orb.sys.Environment" %>
<%@ page import = "com.orb.util.ReadObj" %>
<%@ page import = "com.orb.util.WriteObj" %>
<%@ page import = "java.io.FileNotFoundException" %>
<%@ page import = "java.io.IOException" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<%
	String svrType = request.getParameter("svrType");
	String svrName = request.getParameter("svrName");
	String svrIP = request.getParameter("svrIP");
	String svrPort = request.getParameter("svrPort");
	String svrUsername = request.getParameter("svrUsername");
	String svrPassword = request.getParameter("svrPassword");
	String svrSID = request.getParameter("svrSID");

	out.println(svrType + svrName + svrIP + svrPort + svrUsername + svrPassword + svrSID);

	Server server = new Server(Server.ORACLE, "xx.x.x",
									svrName, svrPort,
									svrUsername, svrPassword,
									svrSID);

		ReadObj r = new ReadObj(Environment.SERVER_FILE);
		WriteObj w = new WriteObj(Environment.SERVER_FILE);

		Server[] s = null;
		try {
			Server[] outS = (Server []) r.read();

			s = new Server[outS.length+1];
			for (int i=0;i<outS.length;i++)
				s[i] = outS[i];

			// new one
			s[outS.length] = server;

		} catch (java.io.FileNotFoundException e) {

			// file doesn't exist. create a new one
			s = new Server[1];
			s[0] = server;

		} catch (IOException e) {
			System.out.println ("IO Error");
			return;
		}

		w.write(s);

		for (int i=0;i<s.length;i++) {
			System.out.println(s[i].getMachine());
		}


%>

<html>
<head>
	<title></title>
</head>

<body>



</tr>

</body>
</html>
