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
	String day = request.getParameter("day");
	if (day == null) day = "11";

	String hour = request.getParameter("hour");
	if (hour == null) hour = "15";


	if (classId != null) {
%>
		<form target="statResult" action="/orb/jsp/oracle/stat/StatResult.jsp">
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

			day: <SELECT ID=selectDay NAME=day>
<%
			for (int i=1;i<31;i++) {
				int selectedDay = new Integer(day).intValue();
				if (selectedDay == i)
	   				out.println("<OPTION VALUE=" + i + " selected>" + i);
				else
					out.println("<OPTION VALUE=" + i + ">" + i);
			}
%>
			</select>

			hour: <SELECT ID=selectHour NAME=hour>
<%
			for (int i=1;i<24;i++) {
				int selectedHour = new Integer(hour).intValue();
				if (selectedHour == i)
	   				out.println("<OPTION VALUE=" + i + " selected>" + i);
				else
					out.println("<OPTION VALUE=" + i + ">" + i);
			}
%>
			</select>

			<td><input type="submit" value="Get Data" /></td>


			<select id=serverId name=serverId>
				<option value=REPOS>REPOS
				<option value=DDNA20>DDNA20
				<option value=DGT20>DGT20
				<option value=DNAC>DNAC
				<option value=QDNA20>QDNA20
				<option value=QGT20>QGT20
				<option value=DCPROD>DCPROD
			</select>

		</table>
<%
	}
%>

</body>
</html>
