<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="../Header.jsp"%>


<h3>Some Useful Commands:</h3>
<ul>
	<p><li>Add log members:<br>
		alter database add logfile member '[file name]' to group 1;</p>
	<p><li>Drop log member:<br>
		alter database drop logfile member '[file name]';
	<p><li>Add a new group: <br>
		alter datbase add logfile member '[file name]' size 5M;
	<p><li>Drop a group:<br>
		alter database drop logfile group 1;
	<p><li>Switch log files: <br>
		alter system switch logfile;
</ul>


</body>
</html>
