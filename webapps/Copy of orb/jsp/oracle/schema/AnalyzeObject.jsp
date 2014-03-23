<%@ page import = "java.util.Vector" %>
<%@ page import = "java.util.Hashtable" %>
<%@ page import = "com.orb.oracle.Database" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>

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
<form target="analyzeResult" action="/orb/jsp/oracle/schema/AnalyzeResult.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Select an Object:</td>
    <td>
	<select id=obj name=obj>
<%
	Database o = new Database(machine, port, username, password, sid);
	String sqlStr;
		sqlStr = "select object_name from dba_objects "
			+ " where object_type = '" + type.toUpperCase() + "'"
			+ " and owner = '" + owner + "'";

	o.setSql(sqlStr);
	o.executeSQL("DUMMY");
	Vector resultVect = o.getResultVect();
	for (int i=0;i<resultVect.size();i++) {
		String data = (String) resultVect.elementAt(i);
		out.println("<OPTION VALUE=" + data + ">" + data);
	}


%>

	<td><select name=tyep>
		<option value=1>1
		<option value=2>2
	</select></td>

	</select>
	<input type="hidden" name="owner" value="<%=owner%>"/>
	<input type="hidden" name="type" value="<%=type%>"/>

	<td><input type="submit" name="submit" value="Get It" /></td>
	<td><input type="submit" name="submit" value="Analyze" /></td>

</table>
</form>

<%
/*
		String sqlTag = "";
		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("owner", owner);
		dbhs.setCriteriaTable(criteriaTab);

		if (type.equals("table"))
			sqlTag = "ANALYZE_TABLE";
		else
			sqlTag = "ANALYZE_INDEX";
		dbhs.executeSQL(sqlTag, "AnalyzeResult", null, null, out);
		out.println("Total records: " + dbhs.getRecordCount());
*/
	}
%>

</body>
</html>
