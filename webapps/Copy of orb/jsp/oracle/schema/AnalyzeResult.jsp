<%@ page import = "java.util.Hashtable" %>
<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "com.orb.oracle.Database" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>

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
	String type = request.getParameter("type");
	String obj = request.getParameter("obj");
	String submit = request.getParameter("submit");

	if (owner != null && type != null) {
		SQLReader sqlReader = new SQLReader();
		sqlReader.refresh();

//System.out.println("type = "  + type);
		String sqlTag = null;

		if (submit.equals("Analyze")) {
			Database o = new Database(machine, port, username, password, sid);
			String sqlStr = "analyze " + type + " "  + owner + "." + obj
					+ " estimate statistics sample 3 percent";
			o.setSql(sqlStr);
			o.executeSQL("DUMMY");

			//System.out.println("------->" + sqlStr);
		}

		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("owner", owner);
		criteriaTab.put("obj", obj);
		dbhs.setCriteriaTable(criteriaTab);

		if (type.equals("table"))
			sqlTag = "ANALYZE_TABLE";
		else
			sqlTag = "ANALYZE_INDEX";
		dbhs.executeSQL(sqlTag, "AnalyzeResult", null, null, out);
		out.println("Total records: " + dbhs.getRecordCount());



	}
%>



</body>
</html>
