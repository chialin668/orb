<%@ page import = "it.*" %>

<%
        String machine = request.getParameter("machine");
	String type = request.getParameter("load");
%>

<html>

<head>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/graph.js"></SCRIPT>
<META HTTP-EQUIV="refresh" content="5;
	URL=http://orb:8080/examples/jsp/it/it.jsp?
	machine=<%= request.getParameter("machine") %>
	&load=<%= request.getParameter("load") %>
">

</head>

<body>
<ul>
	<li> Current time: <%= new java.util.Date() %>
	<li> Client host: <%= request.getRemoteHost() %>
	<li> Server machine: <%= request.getParameter("machine") %>
	<li> Load type: <%= request.getParameter("load") %>
</ul>


<%
	out.println(machine);
	ProbeUnix pu = new ProbeUnix(machine, 3341);
	pu.run();
	out.println(pu.getJSString(type));
	out.println(pu.getCurrDataByType(type));
%>


</body>

</html>

