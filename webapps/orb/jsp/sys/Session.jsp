<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.sys.Server" %>
<%@ page import = "com.orb.sys.ServerInfo" %>

<%
	String id = session.getId();
	ServerSession ss = new ServerSession();
	String loginId = ss.getLogin(id);  // is the http session id

	if (loginId == null) {
%>
	<!-- The Login Page -->
	<script language="JavaScript" type="text/javascript">
			if (self.parent.frames.length != 0)
				self.parent.location=document.location;
	</script>

	<%@ include file="Login.jsp"%>

<%
		return;
	}

	String sid = null;
	String choosenSid = request.getParameter("sid");
	String savedSid = ss.getSid(id);

	if (choosenSid != null) {
		// first time
		sid = choosenSid;
		ss.setSid(id, sid);

	} else if (savedSid != null) {
		sid = savedSid;

	} else if (choosenSid == null && savedSid == null) {

		// sort the server list
		ServerInfo si = new ServerInfo();
		String[] sidArr = si.getOrderedSidList();
		sid = sidArr[0];
		ss.setSid(id, sid);
	}

	String machine = ss.getMachine(id);
	String port = ss.getPort(id);
	String username = ss.getUsername(id);
	String password = ss.getPassword(id);




%>
