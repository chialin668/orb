<%@ page import = "com.orb.oracle.OraStat" %>
<%@ page import = "com.orb.oracle.DBHtml" %>
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

<h4>Stat: <%=statName%></h4>
Machine: <%=machine%><br>
SID: <%=sid%><br>



<form action="/orb/jsp/oracle/serverinfo/stat.jsp">
stat: <select id=selectStat name=statName>
	<OPTION VALUE="CR blocks created">CR blocks created
	<OPTION VALUE="DBWR checkpoint buffers written ">DBWR checkpoint buffers written
	<OPTION VALUE="DBWR checkpoints">DBWR checkpoints
	<OPTION VALUE="DBWR transaction table writes">DBWR transaction table writes
	<OPTION VALUE="DBWR undo block writes">DBWR undo block writes
	<OPTION VALUE="SQL*Net roundtrips to/from client">SQL*Net roundtrips to/from client
	<OPTION VALUE="background checkpoints completed">background checkpoints completed
	<OPTION VALUE="background checkpoints started">background checkpoints started
	<OPTION VALUE="background timeouts">background timeouts
	<OPTION VALUE="buffer is not pinned count">buffer is not pinned count
	<OPTION VALUE="buffer is pinned count">buffer is pinned count
	<OPTION VALUE="bytes received via SQL*Net from client">bytes received via SQL*Net from client
	<OPTION VALUE="bytes sent via SQL*Net to client">bytes sent via SQL*Net to client
	<OPTION VALUE="calls to get snapshot scn: kcmgss">calls to get snapshot scn: kcmgss
	<OPTION VALUE="calls to kcmgas">calls to kcmgas
	<OPTION VALUE="calls to kcmgcs">calls to kcmgcs
	<OPTION VALUE="cleanouts only - consistent read gets">cleanouts only - consistent read gets
	<OPTION VALUE="cluster key scan block gets">cluster key scan block gets
	<OPTION VALUE="cluster key scans">cluster key scans
	<OPTION VALUE="commit cleanout failures: callback failure ">commit cleanout failures: callback failure
	<OPTION VALUE="commit cleanouts">commit cleanouts
	<OPTION VALUE="commit cleanouts successfully completed">commit cleanouts successfully completed
	<OPTION VALUE="consistent changes">consistent changes
	<OPTION VALUE="consistent gets">consistent gets
	<OPTION VALUE="cursor authentications">cursor authentications
	<OPTION VALUE="data blocks consistent reads - undo records applied">data blocks consistent reads - undo records applied
	<OPTION VALUE="db block changes">db block changes
	<OPTION VALUE="db block gets">db block gets
	<OPTION VALUE="deferred (CURRENT) block cleanout applications">deferred (CURRENT) block cleanout applications
	<OPTION VALUE="enqueue releases">enqueue releases
	<OPTION VALUE="enqueue requests">enqueue requests
	<OPTION VALUE="enqueue timeouts">enqueue timeouts
	<OPTION VALUE="execute count">execute count
	<OPTION VALUE="free buffer requested">free buffer requested
	<OPTION VALUE="immediate (CR) block cleanout applications">immediate (CR) block cleanout applications
	<OPTION VALUE="immediate (CURRENT) block cleanout applications">immediate (CURRENT) block cleanout applications
	<OPTION VALUE="leaf node splits">leaf node splits
	<OPTION VALUE="logons cumulative">logons cumulative
	<OPTION VALUE="logons current">logons current
	<OPTION VALUE="messages received">messages received
	<OPTION VALUE="messages sent">messages sent
	<OPTION VALUE="no buffer to keep pinned count">no buffer to keep pinned count
	<OPTION VALUE="no work - consistent read gets">no work - consistent read gets
	<OPTION VALUE="opened cursors cumulative">opened cursors cumulative
	<OPTION VALUE="opened cursors current">opened cursors current
	<OPTION VALUE="parse count (hard)">parse count (hard)
	<OPTION VALUE="parse count (total)">parse count (total)
	<OPTION VALUE="physical reads">physical reads
	<OPTION VALUE="physical reads direct">physical reads direct
	<OPTION VALUE="physical writes">physical writes
	<OPTION VALUE="physical writes direct">physical writes direct
	<OPTION VALUE="physical writes non checkpoint">physical writes non checkpoint
	<OPTION VALUE="prefetched blocks">prefetched blocks
	<OPTION VALUE="recursive calls">recursive calls
	<OPTION VALUE="redo blocks written">redo blocks written
	<OPTION VALUE="redo buffer allocation retries">redo buffer allocation retries
	<OPTION VALUE="redo entries">redo entries
	<OPTION VALUE="redo log space requests">redo log space requests
	<OPTION VALUE="redo size">redo size
	<OPTION VALUE="redo synch writes">redo synch writes
	<OPTION VALUE="redo wastage">redo wastage
	<OPTION VALUE="redo writes">redo writes
	<OPTION VALUE="rollbacks only - consistent read gets">rollbacks only - consistent read gets
	<OPTION VALUE="rows fetched via callback">rows fetched via callback
	<OPTION VALUE="session logical reads">session logical reads
	<OPTION VALUE="session pga memory">session pga memory
	<OPTION VALUE="session pga memory max">session pga memory max
	<OPTION VALUE="session uga memory">session uga memory
	<OPTION VALUE="session uga memory max">session uga memory max
	<OPTION VALUE="sorts (disk)">sorts (disk)
	<OPTION VALUE="sorts (memory)">sorts (memory)
	<OPTION VALUE="sorts (rows)">sorts (rows)
	<OPTION VALUE="table fetch by rowid">table fetch by rowid
	<OPTION VALUE="table fetch continued row">table fetch continued row
	<OPTION VALUE="table scan blocks gotten">table scan blocks gotten
	<OPTION VALUE="table scan rows gotten">table scan rows gotten
	<OPTION VALUE="table scans (long tables)">table scans (long tables)
	<OPTION VALUE="table scans (short tables)">table scans (short tables)
	<OPTION VALUE="total file opens">total file opens
	<OPTION VALUE="user calls">user calls
	<OPTION VALUE="user commits">user commits
	<OPTION VALUE="user rollbacks">user rollbacks
</select>

day: <SELECT ID=selectDay NAME=day>
<%
	for (int i=1;i<31;i++) {
		int selectedDay = new Integer(day).intValue();
		if (selectedDay == i)
	   		out.println("<OPTION VALUE=" + i + " selected>" + i);
		else
			out.println("<OPTION VALUE=" + i + ">" + i);
	}
%>
	</select>

hour: <SELECT ID=selectHour NAME=hour>
<%
	for (int i=1;i<24;i++) {
		int selectedHour = new Integer(hour).intValue();
		if (selectedHour == i)
	   		out.println("<OPTION VALUE=" + i + " selected>" + i);
		else
			out.println("<OPTION VALUE=" + i + ">" + i);
	}
%>
	</select>

	<input type="hidden" name="statName" value="<%=statName%>">
	<input type="submit" value="Refresh" />
</form>



<%
	OraStat o = new OraStat("orb", "1521", "system", "oracle00", "REPOS", "STAT_STAT" , 60);
	String outStr = o.getData(OraStat.MINUTE, "2001", "06", day, hour, statName);
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

drawLine();
</SCRIPT>


<A href="javascript:drawPie()">Pie</a><br>
<A href="javascript:drawColumn()">Column</a><br>
<A href="javascript:drawLine()">Line</a><br>
<A href="javascript:drawArea()">Area</a><br>

</body>
</html>
