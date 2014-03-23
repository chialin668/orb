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


<h3>Machine: <%=machine%></h3>
<h3>SID: <%=sid%></h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("IO_DYNAMIC_EXTENSION", "oracle/io/DynamicExtension", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());

%>

<p>
<h3>Note:</h3>
<ul>
	<li>If the ext count is too high, recreate the object
	<li>Dynamic extension is bad when:
		<ul>
			<li>Extent is too small
			<li>INIT and NEXT is too small for the temporary tablespace
			<li>Extent is too small for rollback segments
			<li>Select a table having too many extents
			<li>Index range scan on too many extents
		</ul>
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Obj name: The name of the object

		<ul>
			<li>T: Table
			<li>I: Index
			<li>R: Rollback
			<li>O: Object
		</ul>
	<li>Ext Count: The count of the extents occupied by this object
	<li>Size: Total mega bytes (MB) occupied by this object
	<li>Owner: The name of the owner
	<li>Tablespace Name: The name of the tablespace
</ul>


</body>
</html>
