<%@ page import = "Database" %>
<%@ page import = "UnixSar" %>
<%@ page import = "ServerSession" %>


<%@ include file="Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Unix Sar</title>
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Global.js"></SCRIPT>
</head>

<body>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Loader.js"></SCRIPT>

<h3> &nbsp;</h3>
<H3>Enough memory?</H3>

Oracle init parameters
<ol>
<%
	String unix = request.getParameter("machine");
	out.println(unix); 
%>
</ol>

<script LANGUAGE="JavaScript1.2">
var newWindow;
newWindow = window.open("/orb/jsp/sys/New.jsp?machine=<%=unix%>", "myWindow", "width=800,height=500");
</script>

</body>
</html>
