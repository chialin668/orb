<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>

<form target="analyzeObject" action="/orb/jsp/oracle/schema/AnalyzeObject.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Select an owner:</td>
	<td><select id=owner name=owner>
<%
	Database o = new Database(machine, port, username, password, sid);
	o.setSql("select username from dba_users order by username");
	o.executeSQL("DUMMY");
	Vector resultVect = o.getResultVect();
	for (int i=0;i<resultVect.size();i++) {
		String data = (String) resultVect.elementAt(i);
		out.println("<OPTION VALUE=" + data + ">" + data);
	}
%>
	</select>
	</td>

	<td>
	<select id=type name=type>
		<option value=table>Table
		<option value=index>Index
	</select>
	</td>

	<td><input type="submit" value="Get Objects" /></td>

</table>
<SCRIPT LANGUAGE="JavaScript">
function abc() {

}
</script>

<A target=basefrm href="/orb/jsp/oracle/space/Space.jsp?">Back</A>

</body>
</html>
