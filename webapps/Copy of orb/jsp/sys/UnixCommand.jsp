<%@ page import = "UnixCommand" %>
<%@ page import = "UnixCmd_df" %>
<%@ page import = "UnixCmd_ps" %>

<%@ include file="Session.jsp"%>

<%
	String command = request.getParameter("command");
%>

<!--
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
-->

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title></title>
	<xml:namespace prefix="v"/>
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>
	
</head>

<body>


<TABLE ID="tblUpdate" BORDER="1" STYLE="border-collapse:collapse"></TABLE>

<%
//	out.println(machine);
//	out.println(username);
//	out.println(password);
/*	
	UnixCommand tt = new UnixCommand(machine, username, password);
	tt.connect();
	tt.run(command);
	if (tt.getStatus().equals("0"))
		out.println(tt.getResult()); 
		//out.println(tt.getHtmlTable(command));
*/		
out.println(command);
if (command.equals("df -k")) {
	out.println("here");
	UnixCmd_df tt = new UnixCmd_df(machine, username, password);
	tt.connect();
	out.println(tt.getHtmlTable(command));
} else if (command.equals("ps -ef")) {
	out.println("here");
	UnixCmd_ps tt = new UnixCmd_ps(machine, username, password);
	tt.connect();
	out.println(tt.getHtmlTable());
} else {
	out.println("unknown command");
	UnixCommand uc = new UnixCommand(machine, username, password);
	uc.connect();
	uc.run(command, out);
//	out.println(uc.getResult());
}

%>

</body>
</html>
