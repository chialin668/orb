<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%
	String owner = request.getParameter("owner");
	String type = request.getParameter("type");

	if (owner != null) {
%>
<form target="schemaResult" action="/orb/jsp/oracle/schema/SchemaResult.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Select an Object:</td>
    <td>
	<select id=obj name=obj>
<%
	Database o = new Database(machine, port, username, password, sid);
	String sqlStr;
	if (type.equals("constraint")) {
		sqlStr = "select constraint_name from dba_constraints"
					+ " where owner = '" + owner + "'";
	}else if (type.equals("dblink")) {
		sqlStr = "select db_link"
					+ " from dba_db_links"
					+ " where owner in (upper('" + owner + "'), 'PUBLIC')";
	} else {
		sqlStr = "select object_name from dba_objects "
						+ " where object_type = '" + type.toUpperCase() + "'"
						+ " and owner = '" + owner + "'";
	}

//System.out.println(sqlStr);

	o.setSql(sqlStr);
	o.executeSQL("DUMMY");
	Vector resultVect = o.getResultVect();
	for (int i=0;i<resultVect.size();i++) {
		String data = (String) resultVect.elementAt(i);
		out.println("<OPTION VALUE=" + data + ">" + data);
	}

%>
	</select>
	<input type="hidden" name="owner" value="<%=owner%>"/>
	<input type="hidden" name="type" value="<%=type%>"/>

<%	if (type.equals("table")) {%>
	<td><input type="submit" name="submit" value="Column" /></td>
	<td><input type="submit" name="submit" value="Index" /></td>
	<td><input type="submit" name="submit" value="Constraint" /></td>
	<td><input type="submit" name="submit" value="Trigger" /></td>
<% } else %>
	<td><input type="submit" name="submit" value="Go" /></td>

</table>
</form>
<%
	}
%>

</body>
</html>
