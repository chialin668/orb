<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Summary:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("USER_SESS_CURSOR_CACHE", "oracle/user/SessionCursorCache", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Maximum: Maximum number of cursors to cache. Once you hit this number, some cursors
		will need to be closed in order to open more. The value in this column is derived
		from the initialization parameter OPEN_CURSORS
	<li>Count: The current number of cursors (whether they are in use or not)
	<li>Open Once: Number of cursors opened at least once
	<li>Open: Current number of open cursors
	<li>Opens: Cumulative total of cursor opens minus one. This is because the cursor that is
		currently open and being used for this query is not counted in the OPENS statistic
	<li>Hits: Cumulative total of cursor open hits
	<li>Hit Ratio: Ratio of the number of times an open cursor was found divided by the number of
		times a cursor was sought

</ul>



</body>
</html>
