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


<h3>Result:</h3>

<%
	String owner = request.getParameter("owner");

	if (owner != null) {
//		SQLReader sqlReader = new SQLReader();
//		sqlReader.refresh();

		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("owner", owner);
		dbhs.setCriteriaTable(criteriaTab);

		dbhs.executeSQL("SPACE_SEGMENT_EXTENT1", "ExtentSummaryResult", null, null, out);
		out.println("Total records: " + dbhs.getRecordCount());
//		out.println(dbhs.getHtmlTable());
	}
%>



</body>
</html>
