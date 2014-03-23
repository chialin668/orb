<html>
<head>
	<title></title>
</head>

<body>
<P><u>OV_SQL:</u></P>
<p>&nbsp;</p>
<p>Distortion could happen:</p>
<ul>
  <li>Recursive calls</li>
</ul>
<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This is counted
as physical reads (but not logical reads).</p>
<ul>
  <li>Missing indexes (or suppressed by functions)</li>
</ul>
<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Then table scan
happens</p>
<ul>
  <li>Data in memory already</li>
  <li>Rollback segments</li>
</ul>
<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The header
blocks of the rollback segments is usually cached.&nbsp; </p>
<ul>
  <li>Multiple logical reads</li>
</ul>
<p>NOTE:</p>
<p>&nbsp;&nbsp;&nbsp; Physical reads causing the system to use CPU resource
since CPU needs to</p>
<p>&nbsp;&nbsp;&nbsp; do the buffer management.</p>
<p>&nbsp;</p>


</body>
</html>