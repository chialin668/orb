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
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("IO_FRAGMENTATION", "oracle/space/Fragmentation", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>

<p>
<h3>Note:</h3>
<ul>
	<li>Display the objects (segments) having more than <b>5</b> extents
	<li>Make sure the extent counts are not high.
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Owner: Owner of the table/index
	<li>Name: The name of the table/index</li>
	<li>Type: table/index</li>
	<li>Extents: The number of the extenst</li>
	<li>M Bytes: The size of the table/index</li>
</ul>



</body>
</html>
