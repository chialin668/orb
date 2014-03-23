<%@ page import = "java.util.Vector" %>
<%@ page import = "com.orb.oracle.DBMem" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title><%=machine%></title>
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>

</head>

<body>
<%
	String outStr = "";
	String statName = request.getParameter("statName");

	if (statName != null) {
		DBMem t = new DBMem();

		Vector valueVect = (Vector) t.getVect(sid, statName);
		if (valueVect != null) {
			double diff = 0.0;
			double prevData = 0.0;
			for (int i=0;i<valueVect.size();i++) {
				if (i==0) {
					prevData = Double.parseDouble((String) valueVect.elementAt(i));
					continue;
				} else {
					diff = Double.parseDouble((String) valueVect.elementAt(i)) - prevData;
					prevData = Double.parseDouble((String) valueVect.elementAt(i));

				}
				outStr = outStr + "," + diff;

			}
		} else
			out.println("sid: " + sid + " is NOT monitored!!");



		if (outStr.length()>1) {
			outStr = outStr.substring(1);
//			outStr = "0," + outStr;
		} else
			return;

		out.print("==>" + outStr + "<==");
	} else
		return;


%>


<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/DataTable.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/PopupWin.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/VML-Graph.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
	createWindow("<%=statName%>", "100pt", "100pt", "400pt", "200pt", 4000, 2000);
	var colArray = new Array(-1, 2);  // what column (2 here) of data do you want to retrieve
	var data1 = new Array(<%=outStr%>);
	//var data1 = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
	//var data1 = new Array(99,99,100,100,100);
	var dataAll = new Array(data1);
	randomColor = getRandomColorArr(dataAll);

	drawLine();
	//drawColumn();
	//drawArea();
	//drawPie();
</SCRIPT>





</body>
</html>
