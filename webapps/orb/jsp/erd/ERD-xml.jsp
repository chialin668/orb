<%@ page import = "com.orb.oracle.XmlSchemaIO" %>





<%
	String projectName = request.getParameter("projectName");
	String xmlStr = request.getParameter("xml");

	XmlSchemaIO sw = new XmlSchemaIO();
	sw.write(projectName, xmlStr);
%>


<h1> Done!!</h1>