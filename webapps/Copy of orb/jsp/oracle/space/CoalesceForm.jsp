<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>

<form target="coalesceResult" action="/orb/jsp/oracle/space/CoalesceResult.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Select an owner:</td>
    <td>
	<select id=tsName name=tsName>
<%
	Database o = new Database(machine, port, username, password, sid);
	o.setSql("select tablespace_name from dba_tablespaces");
	o.executeSQL("DUMMY");
	Vector resultVect = o.getResultVect();
	for (int i=0;i<resultVect.size();i++) {
		String data = (String) resultVect.elementAt(i);
		out.println("<OPTION VALUE=" + data + ">" + data);
	}
%>
	</select>

	<td><input type="submit" value="Get it!" /></td>

</table>
</form>

<A target=basefrm href="/orb/jsp/oracle/space/Space.jsp?">Back</A>

</body>
</html>
