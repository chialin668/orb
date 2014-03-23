<%@ page import = "com.orb.oracle.SQLReader" %>
<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.sys.Environment" %>


<%
	// mark the session
	String id = session.getId();
	ServerSession ss = new ServerSession();
	ss.setLogin(id);

%>

<html>

<head>
</head>

</html>
