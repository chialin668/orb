<%@ page import = "com.orb.oracle.SQLReader" %>
<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.sys.Environment" %>


<%
	// read the database server information
	ServerInfo si = new ServerInfo();
	si.init();

	// @@@ read the SQLs
	SQLReader sr = new SQLReader();
	// ???
	sr.read(Environment.SQL_FILE);

	// mark the session
	String id = session.getId();
	ServerSession ss = new ServerSession();
	ss.setLogin(id);

%>

<html>

<head>

<link rel="stylesheet" href="/css/ftie4style.css">

<!-- Infrastructure code for the tree -->
<script src="/js/infrastructure.js"></script>

<!-- Execution of the code that actually builds the specific tree -->
<script src="/js/treebuilder.js"></script>

<script>
initializeDocument()
</script>

</head>

<body bgcolor=white>

</html>
