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
		// Want to order this sql by this column
		String chkTag = request.getParameter("chkTag");
		String colName = request.getParameter("orderBy");

		SQLReader sqlReader = new SQLReader();
		sqlReader.refresh();

		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("owner", owner);
		dbhs.setCriteriaTable(criteriaTab);

		// @@@ BUG!!!!!!
		dbhs.executeSQL("SPACE_EXTENT_BY_OWNER", "oracle/space/ExtentSummaryResult",
						chkTag, colName, out);
		out.println(dbhs.getHtmlTable());
	}
%>



</body>
</html>
