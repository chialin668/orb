<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>

<ol>
	<li>Connect to server manager:
		<ul>
			<li> $ svrmgrl
			<li> SVRMGRL> connect internal
			<li> SVRMGRL> alter tablespace [tablespace name] offline;
			<li> SVRMGRL> exit
		</ul><p></p>
	<li>Copy the files<p></p>
	<li>Connect to the server manager again:
		<ul>
			<li> $ svrmgrl
			<li> SVRMGRL> alter tablespace [tablespace name] <br>
				rename '[the file name]' to '[the new file name]';
		</ul><p></p>
	<li>Bring the tablespace online again
		<ul>
			<li>alter tablespace [tablespace name] online;</li>
		</ul><p></p>
	<li>Delete the old file</li>
</ol>
	
	

</body>
</html>
