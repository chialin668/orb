<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Database Information:</h3>
<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DB_INFO", "oracle/info/DBInfo", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>


<h4>Description:</h4>
<ul>
	<li>ID: The id of the database
	<li>Name: The name of the databaSE
	<li>Created: When the database is created
	<li>Log Mode: ArchiveLog or NoArchiveLog
	<li>Open Mode: Read Only or Read Write
	<li>CF Type: Control file type
		<ul>
			<li>STANDBY: indicates database is in standby mode.
			<li>CLONE: indicates a clone database.
			<li>BACKUP | CREATED: indicates database is being recovered using
				a backup or created control file.
			<li>CURRENT: The control file changes to this type following a
				standby database activate or database open after recovery.
		</ul>
	<li>CF Seq#: Control file sequence number incremented by control file
		transactions
</ul>

<p>
<hr>
<h3>Database Version:</h3>
<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DB_VERSION", "oracle/info/DBInfo", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>

<p>
<hr>

<h3>Database Options:</h3>
<%
	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("DB_OPTION", "oracle/info/DBInfo", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());

%>

</body>
</html>
