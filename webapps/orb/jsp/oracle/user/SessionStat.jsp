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
	dbhs.executeSQL("USER_SESSION", "oracle/user/SessionStat", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>If there are same FG Process ID, they are using parallel query option
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Username: Oracle login
	<li>Sid: Session id
	<li>Serial#: Session serial number.  Used to identify uniquely a session’s objects.  Guarantees
		that session-level commands are applied to the correct session objects if the
		session ends and another session begins with the same session ID
	<li>Status:Status of the session:
		<ul>
			<li>ACTIVE: currently executing SQL
			<li>INACTIVE
			<li>KILLED: marked to be killed
			<li>CACHED: temporarily cached for use by Oracle*XA
			<li>SNIPED: session inactive, waiting on the client
		</ul>
	<li>Machine: Operating system machine name
	<li>OS User: Operating system client user name
	<li>FG pid: Forground operating system client process ID
	<li>BG pid: Background operating system process identifier
	<li>Program: Operating system program name
	<li>Logon Time: Time of logon

</ul>



</body>
</html>
