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
	dbhs.executeSQL("DBA_OBJ_SIZE", "oracle/space/ObjSize", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>

<p>
<h3>Note:</h3>
<ul>
	<li>Display the sizes of the objects that are bigger than <b>5 MB</b>
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Obj Name: The name of the object
		<ul>
			<li>T: Table
			<li>I: Index
			<li>R: Rollback
			<li>O: Object
		</ul>
	<li>Owner: The owner of the object
	<li>TS Name: The tablespace name
	<li>Size: The size of the object
</ul>


</body>
</html>
