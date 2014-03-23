<%@ page import = "java.util.Vector" %>


<%@ page import = "com.orb.oracle.Database" %>
<%@ page import = "com.orb.sys.Environment" %>
<%@ page import = "java.sql.ResultSetMetaData" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%
	String classId = request.getParameter("class");

	if (classId != null) {
%>
		<form target="monitorStatResult" action="/orb/jsp/oracle/stat/MonitorStatResult.jsp">
		<table cellspacing="2" cellpadding="2" border="0">
		<tr>
    		<td>Stat Name:</td>
		    <td>
			<select id=statName name=statName>
<%

			// get the stat name!!!
			Database db = new Database(machine, port, username, password, sid);
			db.executeSQL(classId);
			Vector resultVectX = db.getResultVect();
			for (int i=0;i<resultVectX.size();i++) {
				String data = (String) resultVectX.elementAt(i);
				data = data.substring(0, data.indexOf(Environment.DELIMITER));
				out.println("<OPTION VALUE='" + data + "'>" + data);
			}

%>
			</select>
		   </td>
		   </tr>

<%
		out.println("<tr>");
		Vector colVect = db.getColVect();
		for (int i=1;i<colVect.size();i++) {
			String colName = (String) colVect.elementAt(i);
			out.println("<td><input type=checkbox name=" + colName
					+ " value=" + colName + ">"
					+ colName + "</td>");
		}
		out.println("</tr>");


%>


		<td><input type="submit" value="Get Data" /></td>

		</table>

<%
		out.println("<input name='tag' type='hidden' value='" + classId + "'/>");
	}
%>

</body>
</html>
