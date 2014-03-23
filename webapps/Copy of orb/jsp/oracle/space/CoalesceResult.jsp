<%@ page import = "java.util.Hashtable" %>
<%@ page import = "com.orb.sys.ServerSession" %>
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
	String tsName = request.getParameter("tsName");
	String doit = request.getParameter("doit");

	if (tsName != null && doit == null) {
%>
	<form target="after" action="/orb/jsp/oracle/space/CoalesceResult.jsp">
	<table cellspacing="2" cellpadding="2" border="0">
	<tr>
    	<td>Coalesce:</td>
		<td><input name="doit" type="hidden" value="true" /></td>
	    <td><input name="tsName" type="hidden" value="<%=tsName%>" /></td>
		<td><input type="submit" value="Coalesce it!" /></td>
	</table>
	</form>
<%
	}
%>

<h3>Result:</h3>

<%
	if (doit != null) {
		Database o = new Database(machine, port, username, password, sid);
		o.setSql("alter tablespace " + tsName + " coalesce");
		o.executeSQL("DUMMY");
	}

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	String sqlTag;
	if (tsName != null) {
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("tsName", tsName);
		dbhs.setCriteriaTable(criteriaTab);
		sqlTag = "DBA_DB_FILE_FREE_SPACE_PARAM";
		dbhs.executeSQL(sqlTag, "CoalesceResult", null, null);
		out.println(dbhs.getHtmlTable());
	}

%>



</body>
</html>
