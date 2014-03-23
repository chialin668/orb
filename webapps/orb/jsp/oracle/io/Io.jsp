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
<%@ include file="../Header.jsp"%>

<P align=center>Disk I/O &amp; Space Management</P>
<ul>
	<li><P>Know your devices (the performance of the drives)</P>
	<li><P>RAID or not RAID?</P>
	<li>Oracle Space management
		<ul>
			<li>Tablespace</li>
				<UL>
			<LI><A href="/orb/jsp/oracle/io/TSSize.jsp?">Size and status</A>
			<li><A href="/orb/jsp/oracle/io/TSParam.jsp?">Parameters</A>
			<li><A href="/orb/jsp/oracle/space/TSFreeSpace.jsp?">Free space</A>
				</ul></p>
			<li>Data files
				<UL>
			<LI><A href="/orb/jsp/oracle/io/DBFile.jsp?">Size and status</A>
			<li><A href="/orb/jsp/oracle/space/FreeSpace.jsp?">Free space</A>
				</ul></P>
			<li>Extents
				<ul>
					<li><A href="/orb/jsp/oracle/io/Extent.jsp?">Information</A>
					<li><A href="/orb/jsp/oracle/io/DynamicExtension.jsp?">Dynamic Extension (fragmentations)?</A>
				</ul></p>
			<li>Objects
				<ul>
					<li><A href="/orb/jsp/oracle/space/ObjSize.jsp?">Object size</A>
				</ul>
		</ul>
		</p>
	<li><P>Distribute the loads amount drives
		<ul>
			<li>How to?
			<li><p><A href="/orb/jsp/oracle/io/FileLocation.jsp">File location</A>
			<li><A href="/orb/jsp/oracle/io/MoveFile.jsp?">Move data files to different drives</A>
			<li><p><A href="/orb/jsp/oracle/io/ReadWrite.jsp?sqlTag=STAT_FILE">Do we have disk contentions?</A>

		</ul>
	  <P></P>

	<li><A href="/orb/jsp/oracle/io/TableScan.jsp?">How many table scan?</A>
	<li><A href="/orb/jsp/oracle/io/TableIndex.jsp?sqlTag=STAT_FILE">Put data files and index files on different drives</A>
	<li>Use partitions
		<ul>
			<li>How to?

			<li><A href="/orb/jsp/oracle/io/Partition.jsp?">Check partition informaiton</A></li>
		</ul>
	  <P></P>
	<li><P>Fragmentations
		<ul>
		  <li>Use the proper size
		  <LI>Create a new table and move the data
		  <LI>Export, compress, and re-import
		  <LI>Increase the size of next extent

		  <li><A href="/orb/jsp/oracle/space/Fragmentation.jsp?">Check fragmentations</A></li>
		</ul>
	  <P></P>
	<li><P>Row chaining</P>
	<li><P>Full table scanning</P>
	<li><P>Log contention
		<ul>
			<li><A href="/orb/jsp/oracle/io/Log.jsp?">Log information</A>
			<li><A href="/orb/jsp/oracle/io/LogHistory.jsp?">Last 100 log history</A>
			<li><A href="/orb/jsp/oracle/io/LogCommand.jsp?">Some helpful log commands</A></li>
		</ul>
	  <P></P>
	<li>All about sorting:
		<ul>
			<li><A href="/orb/jsp/oracle/io/SortParameter.jsp?">Parameters for sorting?</A>
			<li><A href="/orb/jsp/oracle/io/WhenToSort.jsp?">When will sort be performed?</A>
			<li><A href="/orb/jsp/oracle/io/WhereToSort.jsp?">Where to sort? Memory or disk?</A>
			<li><A href="/orb/jsp/oracle/io/TempTS.jsp?">What tablespace to sort (for each user)?</A>
		</ul>
	<li><P>Rollback segment contention?</P>
	<li><P>Where are the control file?</P></li>
</ul>


</body>
</html>
