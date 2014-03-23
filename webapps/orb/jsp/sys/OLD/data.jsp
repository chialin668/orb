<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.Server" %>
<%@ page import = "java.util.Hashtable" %>
<%@ page import = "java.util.Enumeration" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>

	<SCRIPT LANGUAGE="JavaScript">
	function goThere() {
		var list = document.forms[0].sid;
		location = "/orb/jsp/oracle/Overview-Database.jsp?sid="
			+ list.options[list.selectedIndex].value;
	}
	</SCRIPT>

</head>

<body>
	<%@ include file="Header.jsp"%>


	<form>
	<table cellspacing="2" cellpadding="2" border="0">
	<tr>
		<td>Select a Server ID:</td>
		<td>
		<select id=sid name=sid onChange="goThere()">
		<option value=>
<%
	ServerInfo si = new ServerInfo();
	Hashtable serverTab = si.getServerTable();

	Enumeration keys = serverTab.keys();
	while(keys.hasMoreElements()) {
		String key = (String) keys.nextElement();
		Server s  = (Server) serverTab.get(key);
		out.println("<option value=" + s.getSid() + ">" + s.getSid());
	}
%>
		</select>

	</table>
	</form>



</body>
</html>
