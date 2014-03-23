<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Contention?</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOCK_FREE_LIST", "oracle/lock/FreeList", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>

<p>
<h3>Total requests make for data</h3>
<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("MEM_BUFFER_GET", "oracle/lock/FreeList", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>if ration > 1, add more free lists. <b>But don't know which table!!!</b>
	<li>NOTE: You'll have to re-create the table to modify the free-list parameter
	<li>Example: create table new_tale
			storage ( initial 100m
				next 100m
				pctincrease 0
				<b>free list</b> 10)
			as select * from old_table


</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>

</ul>



</body>
</html>
