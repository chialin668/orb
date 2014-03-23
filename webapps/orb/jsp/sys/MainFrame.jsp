<%@ page import = "com.orb.oracle.SQLReader" %>
<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.sys.Environment" %>


<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");


	if (!username.equals("su") || !password.equals("dna")) {
		out.println("Login Incorrect!!");

	} else {

		// read the database server information
		ServerInfo si = new ServerInfo();
		si.init();

		// mark the session
		String id = session.getId();
		ServerSession ss = new ServerSession();
		ss.setLogin(id);

	%>

	<FRAMESET rows="30%,*">
	  <FRAME src="/orb/jsp/sys/MainForm.jsp" name="mainForm" >
	  <FRAME SRC="/orb/jsp/sys/MainResult.jsp" name="mainResult">
	</FRAMESET>

	out.println("456");

<% } %>

