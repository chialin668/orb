<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="../Header.jsp"%>

<h3>Summary:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("STAT_SYS_PARSE", "oracle/cpu/Reparse", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>More parsing, less executing
	<li>Do you have literal SQL?
	<li>Is the SQL shared?
	<li>Is shared pool properly configured?
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>parse time cpu: Total CPU time used for parsing (hard and soft) in 10s of milliseconds.
	<li>parse time elapsed: Total elapsed time for parsing, in 10s of milliseconds.
		Subtract "parse time cpu" from the this statistic to determine the
		total waiting time for parse resources.
 	<li>parse count (hard): Total number of parse calls (real parses). A hard parse
 		is a very expensive operation in terms of memory use, because it requires
 		Oracle to allocate a workheap and other memory structures and then build a parse tree.
	<li>parse count (total): Total number of parse calls (hard and soft). A soft
		parse is a check on an object already in the shared pool, to verify that the
		permissions on the underlying object have not changed.




</ul>


</body>
</html>
