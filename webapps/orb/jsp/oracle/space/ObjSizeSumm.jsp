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
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DBA_OBJ_SIZE_SUMM", "oracle/space/ObjSizeSumm", chkTag, colName, desc, out);
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
	<li>Type
	<li>Count
	<li>Source: Size of the source. Must be in memory during compilation, or dynamic recompilation
	<li>Parsed: Size of the parsed form of the object. Must be in memory when an object is being compiled that references this object
	<li>Code:  Code size. Must be in memory when this object is executing
	<li>Error:  Size of error messages. In memory during the compilation of the object when there are compilation errors
	<li>Size Required: Total size required by the server
</ul>


</body>
</html>
