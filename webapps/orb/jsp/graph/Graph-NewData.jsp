<%@ page import = "Database" %>
<%@ page import = "DBHtmlSortable" %>

<%@ include file="../sys/Session.jsp"%>


<% 
	String sqlTag = request.getParameter("sqlTag");
	String chartType = request.getParameter("chartType");
	String columnNo = request.getParameter("columnNo");
	if (columnNo == null || columnNo.equals("0"))
		columnNo = "1";
%>

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/VMLGraph.js"></SCRIPT>
<!--
	<META HTTP-EQUIV="refresh" content="5;
		URL=http:/orb/jsp/sys/Graph-NewData.jsp">
	</META>
-->	
</head>


<body> 

<h3>Datafile I/O</h3>
<ol> 
<% 
	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);	
	dbhs.executeSQL(sqlTag, "Graph-NewData", null, null);
	int recordCount = dbhs.getRecordCount();
	out.println(dbhs.getHtmlTable()); 
%>
</ol>


<SCRIPT LANGUAGE="JScript">


	var chartType 	= "<%=chartType%>";
	var sqlTag 		= "<%=sqlTag%>";
	var recordCount = <%=recordCount%>;
	var columnNo 	= <%=columnNo%>;
	
	addSelect(sqlTag, recordCount, columnNo);
	
	switch (chartType) {
		case "Bar":
			drawBarChart(sqlTag, recordCount, columnNo);	
			break;
		case "Pie":
			drawPieChart(sqlTag, recordCount, columnNo);	
			break;
		default:
			drawBarChart(sqlTag, recordCount, columnNo);	
			break;
	}
	
	
</SCRIPT>

</body>
</html>
