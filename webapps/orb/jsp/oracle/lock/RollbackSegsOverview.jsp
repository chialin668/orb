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


<h3>Summary:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	String desc = request.getParameter("desc");


//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("LOCK_ROLLBACK_SEG_OVERVIEW", "oracle/lock/RollbackSegsOverview", chkTag, colName, desc, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>Make sure you have enough rollback segments exist to service the amount of users and
		transactions without causing high waits or transaction failures
	<li>INITIAL = NEXT to prevent fragmentation
	<li>PCTINCREASE = 0 (always)
	<li>For large transaction:
		<ul>
			<li>SQL> set transaction use rollback segment rbs4
		</ul>
	<li>Make sure that ollback segments are <b>NOT</b> constantly extending,
		shrinking and/or wrapping
	<li>IF shrink increases, decrease OPTIMAL (??)
	<li>For small running transactions, decrease OPTIMAL
	<li>Try to make the transactions use ONLY the initial extent
	<li>IF extents is high, increase extent size


</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>shrink: multiple rbs extents are de-allocated into one large (optimal size) rbs.
	<li>hwmsize: the max space ever used
	<li>wraps: the # of times a tran continued writing from one extent to another existing extent
	<li>aveactive: average # of bytes used by active extents
	<li>extents: the # of times a rbs extended itself and allocate another extent

</ul>



</body>
</html>
