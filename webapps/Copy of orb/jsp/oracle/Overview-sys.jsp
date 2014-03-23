<%@ page import = "com.orb.oracle.DBHtml" %>

<%@ include file="../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Run As 'sys' user</title>
</head>

<body>

<P>

<H3>SQLs run as 'sys'</H3>
Shared Pool detail breakdown
<OL>
<%

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	username = "sys";

	DBHtml dbh = new DBHtml(machine, port, username, password, sid);

	dbh.executeSQL("OV_SYS_SHM_DETAIL");
	out.println(dbh.getHtmlTable());
%>
</OL>

<LI type=disc>R-free: SHARED_POOL_RESERVED_SIZE </LI>
<LI type=disc>R-FREEA: reserved used memory but not free? </LI>
<LI type=disc>free: contiguous free memory </LI>
<LI type=disc>freeabl: used but not free? </LI>
<LI type=disc>perm: free memory not yet moved to the free area for use </LI>
<LI type=disc>recr: ? </LI>


<H3>Data cached in memory</H3>
How much memory is available for data at any given time:
<OL>
<%
	dbh.executeSQL("OV_MEM_USEAGE");
	out.println(dbh.getHtmlTable());
%>
</OL>


</body>
</html>
