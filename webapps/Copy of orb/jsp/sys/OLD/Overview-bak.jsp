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
<ol>
<A href="/orb/jsp/sys/Bar-Frame.jsp">Click here to get a bar chart</a><br>
<A href="/orb/jsp/sys/Arc-Frame.jsp">Click here to get a Arc chart</a><br>
</ol>



<h3>DB Test</h3>
<ol>
	<A href="/orb/jsp/sys/DBTest.jsp?">Click here</a><br>
</ol>



<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Oracle init parameters:
	<% 
		DBHtml dbh = new DBHtml(machine, port, username, password, sid);
		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);	
		dbhs.executeSQL("OV_INIT_PARAM", "Overview", chkTag, colName);
		out.println(dbhs.getHtmlTable()); 
	%>
	</td>
    
	<td> Hit ratio
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
	</td>
		</tr>
		<tr>
		
    <td>Shared pool size: <br>
		<% 
			dbh.executeSQL("OV_SHARED_POOL_SIZE");
			out.println(dbh.getHtmlTable()); 
		%><br>
		
		Shared pool detail break down: 
		<A href="/orb/jsp/sys/Overview-sys.jsp" target=body ><br>
		Run as sys</a><br>
	</td>
    <td>Sort: 
		<% 
			dbh.executeSQL("OV_SORT");
			out.println(dbh.getHtmlTable()); 
		%>
	</td>
</tr>
</table>


<h3>Datafile I/O</h3>
<ol>
<% 
	dbhs.executeSQL("OV_DISK_IO", "Overview", chkTag, colName);
	out.println(dbhs.getHtmlTable()); 
%>
</TR></TABLE>
</ol>

<h3>SQL Info:</h3> 
<A href="/orb/jsp/sys/Overview-SQL.jsp" target=body >Click here</a><br>

</body>
</html>
