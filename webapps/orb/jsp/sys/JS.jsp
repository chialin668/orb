<%@ page import = "java.util.Hashtable" %>
<%@ page import = "ServerReader" %>

foldersTree = gFld("<b>All</b>", "http://www.cisco.com")



<%

	ServerReader ServerReader = new ServerReader();
	out.println(ServerReader.buildTree("ROOT"));
%>

