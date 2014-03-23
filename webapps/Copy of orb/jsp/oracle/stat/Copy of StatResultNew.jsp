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
	out.println(statName);
	int maxHeight = 0;
	int minHeight = 2147483647;

	if (statName != null) {
		DBMem t = new DBMem();
		//out.println(t.get(sid, statName));

		Vector valueVect = (Vector) t.getVect(sid, statName);
		if (valueVect != null)
			// find the maxHeight!
			for (int i=0;i<valueVect.size();i++) {
				String value = (String) valueVect.elementAt(i);
				int valueInt = Integer.parseInt(value);

				if (maxHeight < valueInt)
					maxHeight = valueInt;
				if (minHeight > valueInt)
					minHeight = valueInt;

			}
			out.println("<br>");
			out.println("maxHeight: " + maxHeight + "<br>");
			out.println("minHeight:" + minHeight + "<br>");
			out.println("height:" + (maxHeight - minHeight) + "<br>");

			for (int i=0;i<valueVect.size();i++) {
				String value = (String) valueVect.elementAt(i);
				int height = maxHeight - minHeight;
				if (height == 0) height = 1;

				int intValue = Integer.parseInt(value);
				intValue = 100-((intValue-minHeight)*100)/height;

//				out.print(value + " " + intValue + "<br>");
				outStr = outStr + ", " + i + ", " + intValue;

			}
		outStr = outStr.substring(1);

		out.print("==>" + outStr + "<==");
	}


%>

<p>
<v:polyline points = "30,30,
			31,80,
			32,50,
			33,20,
			34,25,
			35,50,
			36,51,
			37,24,
			38,59,
			39,44,
			40,21,
			41,24,
			42,35,
			43,54,
			44,34
			"
strokecolor = "red" strokeweight = "1pt"></v:polyline>

<v:polyline points = "<%=outStr%>"
strokecolor = "green" strokeweight = "1pt"></v:polyline>



</body>
</html>
