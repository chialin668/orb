<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.oracle.SQLReader" %>

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

<FORM action=/orb/jsp/sys/Main.jsp id=Login name=Login>
Username:<INPUT name=username><br>
Password:<INPUT name=password type=password><br>
<INPUT type=submit><br>

<br><br>
</FORM><br>
test
<p></p>

<%
		return;
	}
%>


<%

	String sid = null;
	String choosenSid = request.getParameter("sid");
	String savedSid = ss.getSid(id);

	if (choosenSid != null) {
		// first time
		sid = choosenSid;
		ss.setSid(id, sid);

	} else if (savedSid != null)
		sid = savedSid;

	String machine = ss.getMachine(id);
	String port = ss.getPort(id);
	String username = ss.getUsername(id);
	String password = ss.getPassword(id);

%>
