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
	dbhs.executeSQL("USER_ROLLBACK_LOCK", "oracle/user/LockInRollbackSegs", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li><b>The result may be wrong!!!</b>
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>RS Name: Rollback segment name
	<li>Username
	<li>Oracle pid: Oracle sid (as in v$session)
	<li>OS Pid: OS process id
	<li>Terminal: OS terminal id

</ul>



</body>
</html>
