<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Waiting for the rollback segments?:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOCK_ROLLBACK_SEG", "oracle/lock/RollbackSegs", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>

<p>
<h3>Note:</h3>
<ul>
	<li>While you are doing an insert/update on a row, other processes do read updated rows,
		but they see only the old
		version of the row prior to update (via rollback segment)
		until the changes are commited.  This is known as a consistent
		read.
	<li>If hit ratio < 99 %, you have rollback contention
	<li>Expend the size of the rollback segments
	<li>Add more rollback segments
	<li>Try not to overload the large rollback segments
		(when you explicitly assign it)
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Get: Number of header gets
	<li>Wait: Number of header waits
	<li>Hit Ratio
</ul>


<hr>
<h3>Detail:</h3>
<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOCK_ROLLBACK_SEG_DETAIL", "oracle/lock/RollbackSegs", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>

<h3>Note:</h3>
<ul>
	<li>System Undo Header: The number of waits for buffers containing header blocks
		of the SYSTEM rollback segment
	<li>System Undo Block: The number of waits for buffers containing blocks of
		theSYSTEM rollback segment other than header blocks
	<li>Undo Header: Header blocks ther than the SYSTEM rollback segments
	<li>Undo Block: Blocks other than SYSTEM rollback segments

</ul>
<h3>Description:</h3>
<ul>
	<li>Class: Class of block
	<li>Count: Number of waits by this OPERATION for this CLASS of block
</ul>


<p>
<h3>Buffer request count:</h3>
<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("MEM_BUFFER_GET", "oracle/lock/RollbackSegs", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>
<h3>Note:</h3>
<ul>
	<li>If the number of waits for any class of block exceeds 1% of the total number
		of requests, consider creating more rollback segments to reduce
		contention
</ul>

</body>
</html>
