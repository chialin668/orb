<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<%@ include file="../Header.jsp"%>


<table id=hello border=1 cellpadding=5 cellspacing=0>
<tr>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Type"><strong>Type</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Name"><strong>Name</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Ext Id"><strong>Ext Id</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=File Name"><strong>File Name</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Blk Id"><strong>Blk Id</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Blocks"><strong>Blocks</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Blocks"><strong>Blocks</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Blocks"><strong>Blocks</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Blocks"><strong>Blocks</strong></a></p></td>
		<td><P align=center><a href="/orb/jsp/sys/ExtentSummaryResult.jsp?chkTag=SPACE_SEGMENT_EXTENT1&orderBy=Blocks"><strong>Blocks</strong></a></p></td>

	</tr>
</table>

<SCRIPT language=JScript>

// Start processing
 var row;
 var cell;
 var tbody = hello.childNodes[0];
 hello.appendChild( tbody );
 for (var i=0; i<5; i++)
 {
  row = document.createElement( "TR" );
  tbody.appendChild( row );
  for (var j=0; j<10; j++)
  {
    cell = document.createElement( "TD" );
    row.appendChild( cell );
    cell.innerText = "Row " + i + ", Cell " + j;
  }
 }



</script>


</body>
</html>
