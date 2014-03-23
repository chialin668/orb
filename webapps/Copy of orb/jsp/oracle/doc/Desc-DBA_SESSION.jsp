<html>
<head>
	<title></title>
</head>

<body>
<P><u>DBA_SESSION:</u></P>
<P>Make sure that a user (username) doesn't have many sessions running at the
same time.&nbsp; This may be caused by not closing connections before creating a
new connection in a program.</P>
<P>Kill a session:</P>
<P>&nbsp;&nbsp;&nbsp; SQL&gt; alter system kill session '7,15';&nbsp; (sid,
serial#)</P>
<P>&nbsp;</P>
<ul>
  <li>Sid: session id</li>
  <li>Username: Oracle username (schema name)</li>
  <li>Serial #: <FONT face="Times New Roman">Used to identify uniquely a session's 
objects.</FONT></li>
  <li><FONT face="Times New Roman">Machine: OS machine name</FONT></li>
  <li><FONT face="Times New Roman">Program: OS program name</FONT></li>
  <li><FONT face="Times New Roman">Logon Time: Time when logon</FONT></li>
</ul>
<P><FONT face="Times New Roman">Status:</FONT></P>
<ul>
  <LI>ACTIVE: Currently executing SQL
  <LI>INACTIVE: 
  <LI>KILLED: Marked to be killed
  <LI>CACHED: Temporary cached for use by Oracle*XA
  <LI>SNIPED: Session inactive, waiting on the client</LI>
</ul>
<UL type=circle></UL>
<dl>
<DT></DT></dl>


</body>
</html>