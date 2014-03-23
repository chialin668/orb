<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.sys.Server" %>


<%
	// printing sid
	String idx = session.getId();
	ServerSession ssx = new ServerSession();
	String sidx = ssx.getSid(idx);
	out.println("[" + sidx + "]");
%>

<A target=_top HREF="/orb/jsp/sys/Main.jsp">Main</A> |
<A HREF="/orb/jsp/oracle/data.jsp">Change DB</A> |
<A HREF="/orb/jsp/util/ServerList.jsp">Server List</A> |
<A target=_top HREF="/orb/jsp/sys/Logout.jsp">Logout</A>
