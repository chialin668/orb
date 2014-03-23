<%@ page import = "OraStat" %>
<%@ page import = "DBHtmlSortable" %>

<%@ include file="../../sys/Session.jsp"%>

<%
	// SQL
	String sqlTag = "DB_SGA";
	
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

<!--
<FORM NAME=form12>
<SELECT ID=ColNameSelect NAME=colName
	onchange='return refresh();' >
   <OPTION VALUE='SQL*Net roundtrips to/from client' SELECTED>SQL*Net roundtrips to/from client
   <OPTION VALUE='sorts (rows)'>sorts (rows)
   <OPTION VALUE=3>Read time
   <OPTION VALUE=4>Write time
</SELECT>
</FORM>
-->

<ol>
<% 
	String statName = request.getParameter("statName");
	OraStat o = new OraStat("orb", "1521", "system", "oracle00", "REPOS", "STAT_STAT" , 60);
	String outStr = o.getData(OraStat.HOUR, "2001", "06", "08", null, statName);
//	String outStr = o.getData(OraStat.MINUTE, "2001", "06", "08", "13", statName);
	String outStr1 = o.getData(OraStat.MINUTE, "2001", "06", "08", "13", 
									//"SQL*Net roundtrips to/from client");
									"sorts (rows)");
	out.println(statName);	
%>
 
 
<SCRIPT LANGUAGE="JavaScript">
function refresh() {

//	document.location.rul = "www.yahoo.com";
//	document.location.reload();
//	data1 = new Array(<%=outStr1%>);
//	drawLine();
}

var data = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
//var data1 = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
var data1 = new Array(<%=outStr%>);
//var data2 = new Array(77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89, 34, 12, 43);
//var data3 = new Array(55, 90, 123, 45, 77, 84, 23, 65, 89, 34, 12, 43, 32, 65, 44, 78);
//var dataAll = new Array(data1, data2, data3);
var dataAll = new Array(data1);
</script>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/VML-Graph.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/PopupWin.js"></SCRIPT>
 
<A href="/orb/jsp/graph/Graph-Frame.jsp?
					sqlTag=<%=sqlTag%>
					&chartType=Pie
					&columnNo=1
					"
					target="Graph">Graph-Frame Chart</a><br>

<A href="/orb/jsp/graph/Chart.jsp?
					">New Chart</a><br>

					
	<A href="javascript:drawPie()">Pie</a><br>
	<A href="javascript:drawColumn()">Column</a><br>
	<A href="javascript:drawLine()">Line</a><br>
	<A href="javascript:drawArea()">Area</a><br>
</ol>

<A href="/orb/jsp/oracle/doc/Desc-<%=sqlTag%>.jsp" target="desc.htm">Description-1</a><br>



<SCRIPT LANGUAGE="JavaScript">
	
createWindow("Put the title here", "80pt", "80pt", "400pt", "200pt", 4000, 2000);
//createWindow("Put the title here", "80pt", "80pt", "800pt", "400pt", 4000, 2000);
//createWindow("Put the title here", "10pt", "10pt", "1200pt", "600pt", 4000, 2000);
//createWindow("Put the title here", "10pt", "10pt", "4000pt", "2000pt", 4000, 2000);
</SCRIPT>



</body>
</html>
