<%@ page import = "com.orb.sys.ServerSession" %>

<%
	String id = session.getId();
	ServerSession ss = new ServerSession();
	ss.logout(id);
%>

<%@ include file="Login.jsp"%>
