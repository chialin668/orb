<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.ServerSession" %>

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

		<%
		// get the sid list
		ServerInfo si = new ServerInfo();
		String[] sidArr = si.getOrderedSidList();

		// current sid
		String id = session.getId();
		ServerSession ss = new ServerSession();
		String sid = ss.getSid(id);

		// generate the output
		for (int j=0;j<sidArr.length;j++) {
			if (sidArr[j].equals(sid))
				out.println("<option value=" + sidArr[j] + " selected>" + sidArr[j]);
			else
				out.println("<option value=" + sidArr[j] + ">" + sidArr[j]);
		}
		%>

		</select>

	</table>
	</form>



</body>
</html>
