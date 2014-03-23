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
	<title></title>
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Global.js"></SCRIPT>
</head>

<body>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Loader.js"></SCRIPT>

<h3> &nbsp;</h3>




<table cellspacing="2" cellpadding="2" border="0" style="HEIGHT: 33px; WIDTH: 422px">
<tr>
    <td><H4><FONT color=#004080>Machine: <%=machine%></FONT> </h4></td>
    <td><H4><FONT color=#004080>SID: <%=sid%></FONT> </h4></td>
</tr>
</table>




<h3>Some Chart Tests</h3>
<ul>
<A href="/orb/jsp/sys/Bar-Frame.jsp?sqlTag=OV_DISK_IO" target="Graph">Click here to get a bar chart</a><br>
<A href="/orb/jsp/sys/Arc-Frame.jsp?sqlTag=OV_DISK_IO" target="Graph">Click here to get a Arc chart</a><br>
</ul>

<h3>JS Test</h3>
	<A href="/orb/jsp/sys/JSTest.jsp?">Java Script</a><br>

<h3>Stat Monitoring</h3>
	<A href="/orb/jsp/oracle/stat/Config.jsp?">Configure it!</a><br>

<h3>DB Test</h3>
<ul>
	<A href="/orb/jsp/sys/DBTest.jsp?">Click here</a><br>
	
</ul>

<h3>Server Information</h3>
<ul>
	<A href="/orb/jsp/oracle/info/Info.jsp?">General Server Information</a><br>
	<A href="/orb/jsp/oracle/user/User.jsp?">User Information</a><br>
	<A href="/orb/jsp/oracle/io/Io.jsp?">IO</a><br>
	<A href="/orb/jsp/oracle/space/Space.jsp?">Space Management</a><br>
	<A href="/orb/jsp/oracle/lock/Lock.jsp?">Contention Management</a><br>
	Object Management
		<ul>
			<li><A href="/orb/jsp/oracle/schema/SchemaFrame.jsp?">Object Management</a><br>
			<li><A href="/orb/jsp/oracle/schema/AnalyzeFrame.jsp?">Analyze Object</a><br>
		</ul>
</ul>	

<h3>Server Monitoring Control</h3>
<ul>
	<A href="/orb/jsp/oracle/info/stat.jsp?">Stat</a><br>
	<A href="/orb/jsp/oracle/stat/StatFrame.jsp?">New Stat</a><br>
	
	<A href="/orb/jsp/oracle/stat/ConfigNew.jsp?">Config Stat</a><br>
	<A href="/orb/jsp/oracle/stat/StatFrameNew.jsp?">New Stat Result</a><br>
</ul>


<H3>Enough memory?</H3> 

Oracle init parameters 
<ul>
<% 
	DBHtml dbh = new DBHtml(machine, port, username, password, sid);
//	dbh.executeSQL("OV_INIT_PARAM");
//	out.println(dbh.getHtmlTable()); 

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);	
	dbhs.executeSQL("OV_INIT_PARAM", "Overview", chkTag, colName);
	out.println(dbhs.getHtmlTable()); 
	
%>
</ul>

Hit Ratio: 
<ul>
<table cellspacing="2" cellpadding="2" border="1">
<tr>
<% 
	// data buffer
	Database db = new Database(machine, port, username, password, sid);
	db.executeSQL("OV_HIT_RATIO");
	Vector resultVect = db.getResultVect();
	out.println("<td>Data Buffer: </td>" 
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");
%>
</tr>

<tr>
<%
	// data dictionary
	db.executeSQL("OV_ROW_CACHE");
	resultVect = db.getResultVect();
	out.println("<td>Data Dictionary: </td>" 
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");	
%>
</tr>
<tr>
<%
	// library
	db.executeSQL("OV_LIB_CACHE");
	resultVect = db.getResultVect();
	out.println("<td>Library Cache: </td>" 
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");	

%>
</tr>
</table>
</ul>

Shared pool size: 
<ul>
<% 
//	dbh.executeSQL("OV_SHARED_POOL_SIZE");
//	out.println(dbh.getHtmlTable()); 
%>
</ul>
<P>


Shared pool detail break down: 
	<A href="/orb/jsp/sys/Overview-sys.jsp" target=body >Run as sys</a><br>
<P>
 

Sort: 
<ul>
<% 
	dbh.executeSQL("OV_SORT");
	out.println(dbh.getHtmlTable()); 
%>
</ul>


<h3>Datafile I/O</h3>
<ul>
<% 
	dbhs.executeSQL("OV_DISK_IO", "Overview", chkTag, colName);
	out.println(dbhs.getHtmlTable()); 
%>
</TR></TABLE>
</ul>

<h3>SQL Info:</h3> 
<A href="/orb/jsp/sys/Overview-SQL.jsp" target=body >Click here</a><br>

</body>
</html>
