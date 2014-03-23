<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Machine: <%=machine%></h3>
<h3>SID: <%=sid%></h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("STAT_FILE", "oracle/io/ReadWrite", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>

<p>
<h3>Note:</h3>
<ul>
	<li>You have to set <b>TIMED_STATISTICS = "TRUE"</b> to enable 'R Time' and 'W Time'
	<li>Make sure that all rows are well balanced!!
	<li>Move a data file to another disk:
		<b>command???</b>
	<li>Move an object to another tablespace:
		<b>command???</b>
		<b>which object???</b>
	<li>If io load on temp tablespace (datafile) is too high, increate SORT_AREA_SIZE
	<li>If (read count on RBS) ~= (write count on RBS):
		<ul>
			<li>Increate buffer cache
			<li>Move batch update jobs to night
	<li>If havily contention on the RBS disks, please rollback segments on different
		diskss

</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>File Name: The name of the data file
	<li>Reads: read count
	<li>R Time: read time in 1/100 sec
	<li>Writes: write count
	<li>W Time: write time in 1/100 sec
</ul>


</body>
</html>
