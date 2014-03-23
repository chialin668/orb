<html>
<head>
	<title></title>
</head>

<body>
<P><u>OV_SYS_SHM_DETAIL:</u></P>
<p>This query shows you how many DB_BLOCK_BUFFERS are currently in used and how
many DB_BLOCK_BUFFERS&nbsp; are available.&nbsp; Hopefully, you sill have free
space in DB_BLOCK_BUFFERS (too much memory?).</p>
<p>&nbsp;</p>
<p>NOTE: How to cache a table</p>
<ul>
  <li>create table test (id number) tablespace users cache;</li>
  <li>alter table test cache;</li>
</ul>


</body>
</html>