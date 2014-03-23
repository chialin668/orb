<%@ page import = "com.orb.oracle.OraMonitor" %>

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

Oracle SID: <%=sid%>
<p>

<%

	String classId = request.getParameter("class");

	if (classId != null) {
		OraMonitor m =new OraMonitor(machine, port, username, password, sid);
		boolean flag = m.start(classId);

		if (flag)
			out.println("Start monitoring " + classId);
		else
			out.println(classId + " has been Monitored already!!");
	}

%>

</body>
</html>
