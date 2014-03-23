<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
%>


<html>
<head>
</head>

<% if (!username.equals("su") || !password.equals("dna")) {%>
<body>
	Login Incorrect!!
</body>

<% } else {%>

<FRAMESET cols="171,*"> 
   <FRAME src="/orb/jsp/sys/control.jsp" name="treeframe" > 
   <FRAME SRC="/orb/jsp/sys/data.jsp" name="basefrm"> 
</FRAMESET> 

<% } %>
</html>