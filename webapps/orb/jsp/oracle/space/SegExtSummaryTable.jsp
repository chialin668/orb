<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="../Header.jsp"%>

<%
	String owner = request.getParameter("owner");
	if (owner != null) {
%>
<form target="sesResult" action="/orb/jsp/oracle/space/SegExtSummaryResult.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Select an owner:</td>
    <td>
	<select id=segment name=segment>
<%
		Database o = new Database(machine, port, username, password, sid);
		o.setSql("select segment_name from dba_segments where owner = '" + owner + "'");
		o.executeSQL("DUMMY");
		Vector resultVect = o.getResultVect();
		for (int i=0;i<resultVect.size();i++) {
			String data = (String) resultVect.elementAt(i);
			out.println("<OPTION VALUE=" + data + ">" + data);
		}
%>
	</select>
	<input type="hidden" name="owner" value="<%=owner%>"/>
	<td><input type="submit" value="Get Data" /></td>

</table>
</form>
<%
	}
%>

</body>
</html>
