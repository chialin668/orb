<%@ page import = "Database" %>
<%@ page import = "DBHtml" %>
<%@ page import = "DBHtmlSortable" %>
<%@ page import = "ServerSession" %>


<%@ include file="Session.jsp"%>

<%
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%=machine%></title>
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Global.js"></SCRIPT>
</head>

<body>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Loader.js"></SCRIPT>

<h3> &nbsp;</h3>



<h3>DBA Info</h3>
<ol>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_INFO">Database Information</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_VERSION">Database Version</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_INIT_PARAM">Init Parameters</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_INIT_PARAM_ISSES">Init Param (Session modifiable)</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_INIT_PARAM_ISSYS">Init Param (System modifiable)</a><br>		
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_INIT_PARAM_DESC">Init Parameter Description</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_INIT_PARAM_UNDOC">Undocumented Init Parameters</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_BG_PROCESS">Background Processes</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_STAT_NAME">Stat name</a><br>		
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_SGA&chartType=pie">SGA</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_TS_INFO">Tablespaces</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_TS_FREE_SPACE&colNo=7,8&chartType=column">Free Space</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_TS_PARAMS&colNo=1,2&chartType=column">TS Parameters</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_FILE_INFO&colNo=2&chartType=column">Data Files</a><br> 

<A href="/orb/jsp/sys/SQLTest1.jsp?sqlTag=DBA_FILE_INFO&colNo=2&chartType=column">MY TEST!!!!</a><br> 

	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_FILE_STATUS">DB File Status</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_EXTENTS">Extents (!@#$$%)</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_ROLLBACK_INFO">Rollback Segs</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_OBJ_SUMMARY">Object summary</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_CACHED_TABLE">Cached Tables</a><br>		
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_INVALID_OBJ">Invalie Objects</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DBA_SESSION">Session</a><br>
</ol>

<h3>User Information</h3>
<ol>   
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=USER_SQL">User SQL</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=OV_SQL">Problem SQLs</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=USER_SESSION">User Sessions</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=USER_LOCK">User Lock</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=USER_LOCK_DETAIL">User Lock Detail</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=USER_IN_ROLLBACK">User in Rollback Segs</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=USER_ROLLBACK_LOCK">Locks in Rollback Segs</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=USER_OPEN_CURSOR">Open Cursors</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=USER_SESS_CURSOR_CACHE">Session Cursor Cache</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=SYSTEM_CURSOR_CACHE">System Cursor Cache</a><br>		
</ol>

<h3>Backup, Archive and Logs</h3>
<ol>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=LOG_FILE">Logs</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=LOG_HISTORY">Log History(!@!#$%&)</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=LOG_BUFFER_ALLOCCATION">Log Buffer Reallocation</a><br>
</ol>
	
<h3>Utl Stat</h3>
<ol>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_STAT">Stat</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_BG_PROCESS">DB Background</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_LOGONS">Logons</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_SESSION_USER">Session Users</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_LATCH">Latches</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_EVENT">Events</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_WAIT">Waits</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_ROLL">Rollback Segments</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_FILE">DB Files</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_ROWCACHE">Rowcache</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_LIB">Library</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_LATCH_HELD">Latch held</a><br>
	<br>
CPU:<br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_SYS_CPU">CPU Useages on All Users</a><br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_SESSION_CPU">CPU Useages for Sessions</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_SYS_PARSE">General parsing time</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_SQL_EXEC_COUNT">SQL Execution counts</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=STAT_SQL_BUFFER">SQL Buffer counts</a><br>	
	<br>
MEM:<br>
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=DB_SGA">SGA</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=MEM_DATA_BUFFERS">Total data buffers</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=OV_SHARED_POOL_SIZE">SGA Free Memory</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=OV_SYS_SHM_DETAIL1">Free db_block_buffers</a><br>		
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=MEM_BUFF_IN_MEM"># of blocks in memory for db files</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=MEM_OBJ_IN_MEM">objects in memory</a><br>		
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=OV_HIT_RATIO">Buffer Cache</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=OV_LIB_CACHE">Library Cache - Overall</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=OV_LIB_CACHE_DETAIL">Library Cache - Detail</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=OV_ROW_CACHE">Dict Cache</a><br>	
	<A href="/orb/jsp/sys/SQLTest.jsp?sqlTag=MEM_LATCH">Memory Latch Contention</a><br>	
	
</ol>




</body>
</html>
