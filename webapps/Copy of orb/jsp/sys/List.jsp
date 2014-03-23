<%@ page import = "SQLReader" %>
<%@ page import = "ServerInfo" %>
<%@ page import = "ServerSession" %>

<%
	// read the database server information
	ServerInfo si = new ServerInfo();
	si.init();

	// @@@ read the SQLs	
	SQLReader sr = new SQLReader();
	// ???
	sr.read("C:\\Chialin\\tomcat-321\\webapps\\orb\\WEB-INF\\classes\\test.sql");
	
	// mark the session
	String id = session.getId();
	ServerSession ss = new ServerSession();
	ss.setLogin(id);
	
%>
	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>List</title>
</head>

<body>
<h4><U>Machine List:</U> </h4>

<h4>Test</h4>
<A href="/orb/jsp/sys/Overview.jsp?sid=CHIALIN" target=body >Chialin</a><br>
<A href="/orb/jsp/sys/Overview.jsp?sid=REPOS" target=body >REPOS</a><br>
<h4>DNA Connects</h4>
<A href="/orb/jsp/sys/Overview.jsp?sid=DNAC" target=body >DNAC</a><br>
<A href="/orb/jsp/sys/Overview.jsp?sid=DCPROD" target=body >DCPROD</a><br>
<A href="/orb/jsp/sys/Overview.jsp?sid=QADNAC" target=body >QADNAC</a><br>
<h4>LIMS</h4>
<A href="/orb/jsp/sys/Overview.jsp?sid=DEVLIMS" target=body >DEVLIMS</a><br>
<A href="/orb/jsp/sys/Overview.jsp?sid=QALIMS" target=body >QALIMS</a><br>
<A href="/orb/jsp/sys/Overview.jsp?sid=PRODLIMS" target=body >PRODLIMS</a><br>
<h4>dna.com</h4>
<A href="/orb/jsp/sys/Overview.jsp?sid=DDNA20" target=body >DDNA20</a><br>
<A href="/orb/jsp/sys/Overview.jsp?sid=QDNA20" target=body >QDNA20</a><br>
<h4>GT</h4>
<A href="/orb/jsp/sys/Overview.jsp?sid=DGT20" target=body >DGT20</a><br>
<A href="/orb/jsp/sys/Overview.jsp?sid=QGT20" target=body >QGT20</a><br>

<p>
<h4>CPU</h4>
<A href="/orb/jsp/sys/UnixSar.jsp?sid=QGT20&machine=devdcx" target=body >devdcx</a><br>
<A href="/orb/jsp/sys/UnixSar.jsp?sid=QGT20&machine=devsql" target=body >devsql</a><br>

</body>
</html>
