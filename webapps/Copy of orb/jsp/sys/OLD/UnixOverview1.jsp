
<%
	String machine = request.getParameter("machine");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<script LANGUAGE="JavaScript1.2">
	function open_window1(windowName, machine) {
		var newWindow;
		newWindow = window.open("/orb/jsp/sys/Line-Frame.jsp?machine=" + machine, 
							windowName, 
							"width=800,height=800");
	}
	
</script>

<h3>Test</h3>
<A href="/orb/jsp/sys/UnixOverview1.jsp?machine=devdcx" 
	onclick="return open_window()">devdcx</a><br>

	<P></P>
<h3>Sar performance on CPU</h3>	
<A href="/orb/jsp/sys/UnixOverview1.jsp?machine=devdcx" 
	onclick="return open_window1('devdcx', 'devdcx')">devdcx</a><br>
	
<A href="/orb/jsp/sys/UnixOverview1.jsp?machine=devsql" 
	onclick="return open_window1('devsql', 'devsql')">devsql</a><br>

	<p></p>
<A href="/orb/jsp/sys/New.jsp?sid=QGT20&machine=devdcx">devdcx</a><br>

<h3>some commands</h3>
<A href="/orb/jsp/sys/UnixCommand.jsp?sid=<%=machine%>&command=df -k">df -k</a><br>
<A href="/orb/jsp/sys/UnixCommand.jsp?sid=<%=machine%>&command=ps -ef">ps -ef</a><br>
<A href="/orb/jsp/sys/UnixCommand.jsp?sid=<%=machine%>&command=crontab -l">crontab -l</a><br>

<h3>Check Oracle daily dump</h3>
<A href="/orb/jsp/sys/UnixCommand.jsp?sid=<%=machine%>&command=ls -al /tmp/export.log">Check the date of the log</a><br>
<A href="/orb/jsp/sys/UnixCommand.jsp?sid=<%=machine%>&command=cat /tmp/export.log">Check the export log</a><br>
<A href="/orb/jsp/sys/UnixCommand.jsp?sid=<%=machine%>&command=ls -al /db/dbdump/*.dmp">Check the dump file</a><br>


<h3>some commands on plain text</h3>
<A href="/orb/servlet/UnixCommandServlet?sid=<%=machine%>&command=df -k">df -k</a><br>
<A href="/orb/servlet/UnixCommandServlet?sid=<%=machine%>&command=ps -ef">ps -ef</a><br>
<A href="/orb/servlet/UnixCommandServlet?sid=<%=machine%>&command=crontab -l">crontab -l</a><br>
<A href="/orb/servlet/UnixCommandServlet?sid=<%=machine%>&command=dmesg">dmesg</a><br>

<A href="/orb/servlet/UnixCommandServlet?sid=<%=machine%>&command=ls -al /tmp">Check the log</a><br>




</body>
</html> 
