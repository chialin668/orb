<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.Database" %>

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
		<form target="statResultNew" action="/orb/jsp/oracle/stat/StatResultNew.jsp">
		<table cellspacing="2" cellpadding="2" border="0">
		<tr>
    		<td>Select an owner:</td>
		    <td>
			<select id=statName name=statName>
<%
			Database o = new Database(machine, port, username, password, sid);
			String sqlStr = "select name"
					+ " from v$statname"
					+ " where class = " + classId
					+ " order by statistic#";
			o.setSql(sqlStr);
			o.executeSQL("DUMMY");
			Vector resultVect = o.getResultVect();
			for (int i=0;i<resultVect.size();i++) {
				String data = (String) resultVect.elementAt(i);
				out.println("<OPTION VALUE='" + data + "'>" + data);
			}
%>
			</select>


			<td><input type="submit" value="Get Data" /></td>

		</table>
<%
	}
%>

</body>
</html>
