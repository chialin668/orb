<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.OraStat" %>

<%@ include file="../../sys/Session.jsp"%>

<%
	// Want to order this sql by this column
	String type[] = request.getParameterValues("type");
	int interval = Integer.parseInt(request.getParameter("interval"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>

	<%=sid%>
<%
	out.println(sid);
	out.println(machine);
	out.println(username);
	out.println(password);

out.println("<p>");

		// repository
		OraStat stat = new OraStat();
		stat.setReposServer("orb", "1521", "system", "oracle00", "REPOS");

	for (int i=0;i<type.length;i++) {
		out.println(type[i]);
		out.println(interval);

		stat = new OraStat(machine, "1521",
										username, password, sid,
										type[i] , interval, true);
		stat.start();
	}
%>

</body>
</html>
