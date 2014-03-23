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
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOG_FILE", "oracle/io/Log", chkTag, colName, out);
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
	<li>Group: Group #
	<li>Threads#: The thread #
	<li>File Name
	<li>Size: in MB
	<li>Sequence#: The sequence #
	<li>Bytes: The size of the log
	<li>Member: The number of members in the group
	<li>Archived: Archive status (YES/NO)
	<li>Status:
		<ul>
		<li>UNUSED: The online redo log has never been written to. This is the
			state of a redo log that was just added, or just after a RESETLOGS,
			when it is not the current redo log.
		<li>CURRENT: This is the current redo log. This implies that the redo log
			is active. The redo log could be open or closed.
		<li>ACTIVE: The log is active but is not the current log. It is needed for
			crash recovery. It may be in use for block recovery. It might or might
			not be archived.
		<li>CLEARING: The log is being re-created as an empty log after an
			ALTER DATABASE CLEAR LOGFILE command. After the log is
			cleared, the status changes to UNUSED.
		<li>CLEARING_CURRENT: The current log is being cleared of a closed
			thread. The log can stay in this status if there is some failure in the
			switch such as an I/O error writing the new log header.
		<li>INACTIVE: The log is no longer needed for instance recovery. It may
			be in use for media recovery. It might or might not be archived.
		</ul>
</ul>


</body>
</html>
