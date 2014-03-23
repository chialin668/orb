<%@ page import = "Database" %>
<%@ page import = "DBHtml" %>
<%@ page import = "DBHtmlSortable" %>
<%@ page import = "ServerSession" %>


<%@ include file="Session.jsp"%>

<%
	// @@@
	username = "sys";
	
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String colNo = request.getParameter("colNo");
	String chartType = request.getParameter("chartType");
	
	if (colNo == null) colNo = "1";
//	if (chartType == null) chartType = "line";
	
	// SQL
	String sqlTag = request.getParameter("sqlTag");
	if (sqlTag == null)
		sqlTag = chkTag;
		
out.println(colNo);		
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title><%=machine%></title>
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>
	
</head>

<body>

<h3>Machine: <%=machine%></h3>
<h3>SID: <%=sid%></h3>

<FORM ACTION="(Empty Reference!)" NAME="bob" METHOD="get">
x:<INPUT TYPE="TEXT" NAME="leftVal" SIZE="3"><BR>
y:<INPUT TYPE="TEXT" NAME="topVal" SIZE="3"><BR>
</FORM>
  
<% 
	SQLReader sqlReader = new SQLReader();
	sqlReader.refresh();
	
	DBHtml dbh = new DBHtml(machine, port, username, password, sid);
//	dbh.executeSQL("OV_INIT_PARAM");
//	out.println(dbh.getHtmlTable()); 

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);	
	dbhs.executeSQL(sqlTag, "SQLTest", chkTag, colName);
	out.println(dbhs.getHtmlTable()); 
	
%>
 

<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/DataTable.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/PopupWin.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/VML-Graph.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
createWindow("Put the title here", "100pt", "100pt", "400pt", "200pt", 4000, 2000);

var chartType = '<%=chartType%>';
var sqlTag = '<%=sqlTag%>';
var colArray = new Array(-1, <%=colNo%>);  // what column of data do you want to retrieve
 
// read the data from the table 
//var data = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
var data1 = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
var dataAll = new Array(data1);

dataAll = getData(sqlTag, colArray);
randomColor = getRandomColorArr(dataAll);
 
if (chartType == 'area')
	drawArea(); 
else if (chartType == 'line')
	drawLine();
else if (chartType == 'pie')
	drawPie();
else if (chartType == 'column')
	drawColumn();
</SCRIPT>
 

<A href="/orb/jsp/graph/Chart.jsp?">New Chart</a><br>
	<A href="javascript:drawPie()">Pie</a><br>
	<A href="javascript:drawColumn()">Column</a><br>
	<A href="javascript:drawLine()">Line</a><br>
	<A href="javascript:drawArea()">Area</a><br>
 


<A href="/orb/jsp/graph/Graph-Frame.jsp?
					sqlTag=<%=sqlTag%>
					&chartType=Pie
					&columnNo=1
					"
					target="Graph">Graph-Frame Chart</a><br>

<A href="/orb/jsp/oracle/doc/Desc-<%=sqlTag%>.jsp" target="desc.htm">Description-1</a><br>



</body>
</html>
