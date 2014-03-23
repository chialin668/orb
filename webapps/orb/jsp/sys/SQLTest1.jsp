<%@ page import = "Database" %>
<%@ page import = "DBHtml" %>
<%@ page import = "DBHtmlSortable" %>
<%@ page import = "ServerSession" %>


<%@ include file="Session.jsp"%>

<%
	username = "sys";
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

  
<%
/*
	String sqlTag = "DBA_FILE_INFO";
	SQLReader sqlReader = new SQLReader();
	sqlReader.refresh();
	
	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);	
	dbhs.executeSQL(sqlTag, "SQLTest", null, null);
	out.println(dbhs.getHtmlTable()); 
*/
%>
 
here

<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/DataTable.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/PopupWin.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/VML-Graph.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
createWindow("Put the title here", "100pt", "100pt", "400pt", "200pt", 4000, 2000);

var colArray = new Array(-1, 2);  // what column (2 here) of data do you want to retrieve

////////////////////////////
// from html table
////////////////////////////
//var sqlTag = 'DBA_FILE_INFO';
//dataAll = getData(sqlTag, colArray); 


////////////////////////////
// from input arrays
////////////////////////////
var data1 = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
var dataAll = new Array(data1);


randomColor = getRandomColorArr(dataAll);
 
//drawLine();
//drawColumn();
//drawArea();
drawPie();


</SCRIPT>
 




</body>
</html>
