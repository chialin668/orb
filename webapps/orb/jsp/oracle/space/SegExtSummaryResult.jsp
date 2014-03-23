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
	String segment = request.getParameter("segment");
	String desc = request.getParameter("desc");

	if (owner != null) {
		SQLReader sqlReader = new SQLReader();
		sqlReader.refresh();

		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, desc, sid);
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("owner", owner);
		criteriaTab.put("segment", segment);
		dbhs.setCriteriaTable(criteriaTab);

		dbhs.executeSQL("SPACE_SEGMENT_EXTENT", "ExtentSummaryResult", null, null, out);
		out.println("Total records: " + dbhs.getRecordCount());
//		out.println(dbhs.getHtmlTable());
	}
%>



</body>
</html>
