<%@ include file="../../sys/Session.jsp"%>

<%
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<P align=center>Space Management</P>
<ol>
<li>Oracle Space management
	<ul>
   		<LI><A href="/orb/jsp/oracle/space/ObjCount.jsp?">Object Counts by Each User</A>
   		<li><A href="/orb/jsp/oracle/space/UserSpace.jsp?">Space Usage by Each User</A>
    	<li><A href="/orb/jsp/oracle/space/TSSpace.jsp?">Tablespace Useage & Free Space</A>
		<li><A href="/orb/jsp/oracle/space/ObjSizeSumm.jsp?">Object Size Summary by Types</A>
		<li><A href="/orb/jsp/oracle/space/ObjSize.jsp?">Big Objects (Objects using more than 5 MB)</A>
		<li><A href="/orb/jsp/oracle/space/Fragmentation.jsp?">Fragmented Objects (Objects has more than 5 extents)</A>
		<li><A href="/orb/jsp/oracle/space/BlockCountFrame.jsp?">How many blocks are needed for a table</A>
		<li><A href="/orb/jsp/oracle/space/ExtentSummaryFrame.jsp?">Extent Summary by Users</A>
		<li>Free Space Management:
		<ol> 
			<li><A href="/orb/jsp/oracle/space/TSFreeSpace.jsp?">Free space inside tablespaces</A>
			<li><A href="/orb/jsp/oracle/space/FreeSpace.jsp?">Free space inside data files</A>
			<li><A href="/orb/jsp/oracle/space/CoalesceFrame.jsp?">Coalesce Free Space</A>
		</ol>
		<li><A href="/orb/jsp/oracle/space/TSFileFreeSpace.jsp?">Tablespace, Data Files, & Free Space</A>
		<li><A href="/orb/jsp/oracle/space/FileMap.jsp?">Data file Map</A>
		<li><A href="/orb/jsp/oracle/space/ObjPerTS.jsp?">Tables & Indexes per Tablespace</A>
		<li><A href="/orb/jsp/oracle/space/SegExtSummaryFrame.jsp?">Segment Extent Summary by Owner Segment Name</A>
		<li><A href="/orb/jsp/oracle/space/SegExtSummaryFrame1.jsp?">Segment Extent Summary by Owner</A>
	</ul></p>
</ol>

</body>
</html>
