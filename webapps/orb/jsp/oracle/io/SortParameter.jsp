<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


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
	dbhs.executeSQL("DB_INIT_PARAM_SORT", "oracle/io/SortParameter", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>SORT_AREA_SIZE is allocated for each user.  Make sure that you are not running
		out of memory
	<li>Disk sort:
		<ul>
			<li>Sort in small runs
			<li>Save the small runs into temporary segments <b>on disk</b>
			<li>Merge the teh runs
		</ul>
	<li>Size INITIAL and NEXT appropriately
	<li>Monitor temp tablespace closely
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>SORT_AREA_SIZE (needs to restart the server?)
	<li>SORT_DIRECT_WRITE: Write sort data from memory to the temporary tablespace
		while avoiding the buffer cache
	<li>COMPATIBLE: void reading sorted data through the buffer cache
	<li>SORT_AREA_RETAIN_SIZE: allocate smaller amounts of memory for sorting to all users
</ul>

</body>
</html>
