<%@ page import = "it.*" %>

<%
        String machine = request.getParameter("machine");
	String type = request.getParameter("load");
%>

<html>

<head>
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
        Client client = new Client("orb", 3341);
        client.openConnection();
//              System.out.println(client.getDataByCommand("top"));
	String outStr = client.getDataByCommand("unix df -k");
	ParseData p = new ParseData();
	p.dataToCSV(outStr);
        out.println(outStr);
        client.closeConnection();

%>


</body>

</html>

