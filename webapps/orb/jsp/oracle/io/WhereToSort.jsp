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
	dbhs.executeSQL("OV_SORT", "oracle/io/WhereToSort", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>Want to sort in memory mostly
	<li>Do we really need a sort: Do you have the index created properly?
	<li>Make sure SORT_AREA_SIZE is large enough (also make sure there is no
		paging)
	<li>Makre sure INT & NEXT are big enough
	<li>Give large sorts large INIT & NEXT values

</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>
</ul>



</body>
</html>
