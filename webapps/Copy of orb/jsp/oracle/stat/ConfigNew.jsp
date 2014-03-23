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

Start monitoring...<%=sid%>

<%
/*
	OraStat1 o = new OraStat1(machine, port, username, password, sid);
	Thread tr = new Thread(o);
	tr.start();
*/

	OraMonitor m =new OraMonitor(machine, port, username, password, sid);
	m.start("STAT_STAT");
%>

</body>
</html>
