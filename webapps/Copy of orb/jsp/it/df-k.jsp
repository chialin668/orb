<%@ page import = "it.*" %>
<%	 Client client = new Client("orb", 3341);
        client.openConnection();
	String outStr = client.getDataByCommand("unix df -k");
	ParseData p = new ParseData();
	out.println(p.dataToCSV(outStr));
        client.closeConnection();
%>

