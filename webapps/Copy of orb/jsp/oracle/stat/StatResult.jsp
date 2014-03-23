<%@ page import = "java.util.Hashtable" %>
<%@ page import = "com.orb.oracle.OraStat" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>

<%
	// Want to order this sql by this column
	String chkTag = null;
	String colName = null;
	String colNo = "1";
	String chartType = "column";
	String sqlTag = "DBA_TS_PARAMS";

	String statName = request.getParameter("statName");
	String day = request.getParameter("day");
	if (day == null) day = "11";

	String hour = request.getParameter("hour");
	if (hour == null) hour = "15";

	String serverId = request.getParameter("serverId");
	out.println("ServerId = " + serverId + "<br>");

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
out.println("sid = " + sid + "<br>");
	OraStat o = new OraStat("orb", "1521", "system", "oracle00", "REPOS", "STAT_STAT" , 60);
//	String outStr = o.getData(OraStat.MINUTE, "2001", "06", day, hour, statName);
	String outStr = o.getData(sid, OraStat.DAY, "2001", "06", null, null, statName);
//
//	outStr = outStr + "," + outStr + "," + outStr + "," + outStr + "," + outStr;

	out.println("data string: " + outStr + "<br>");
%>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/DataTable.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/PopupWin.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/VML-Graph.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
hasCtrlIcn = false;
movable = false;
hasBackground = true;
createWindow("<%=statName%>", "50pt", "100pt", "400pt", "200pt", 4000, 2000);

var chartType = '<%=chartType%>';
var sqlTag = '<%=sqlTag%>';
var colArray = new Array(-1, <%=colNo%>);  // what column of data do you want to retrieve

// read the data from the table
var data1 = new Array(<%=outStr%>);
var dataAll = new Array(data1);
randomColor = getRandomColorArr(dataAll);

//drawLine();
drawColumn();

</SCRIPT>


<A href="javascript:drawPie()">Pie</a><br>
<A href="javascript:drawColumn()">Column</a><br>
<A href="javascript:drawLine()">Line</a><br>
<A href="javascript:drawArea()">Area</a><br>

</body>
</html>
