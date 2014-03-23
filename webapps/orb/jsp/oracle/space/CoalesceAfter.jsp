<%@ page import = "java.util.Hashtable" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="../Header.jsp"%>


<h3>Result:</h3>

<%
	String tsName = request.getParameter("tsName");

	SQLReader sqlReader = new SQLReader();
	sqlReader.refresh();

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
