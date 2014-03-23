<%@ page import = "UnixSar" %>

<%! long xCord = 300; %>
<%! long yCord = 0; %>

<%
	String unix = request.getParameter("machine");
	out.println(unix);
	UnixSar us = new UnixSar("devdcx", "oracle", "oracle00", "", "5", "5000");
	us.start();
	
	xCord += 100;
	
%>


<%
	Vector tagVect = new Vector();
	tagVect.add("%idle");
	tagVect.add("%usr");
	tagVect.add("%sys");
	tagVect.add("%wio");
	
	Vector nameVect = new Vector();
	nameVect.add("idle");
	nameVect.add("usr");
	nameVect.add("sys");
	nameVect.add("wio");

	Vector colorVect = new Vector();
	colorVect.add("silver");
	colorVect.add("green");
	colorVect.add("blue");
	colorVect.add("red");
%>

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title></title>
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>
	
	<META HTTP-EQUIV="refresh" content="5;
		URL=http:/orb/jsp/sys/SarNewData.jsp?machine=devdcx&load=null">
	</META>
</head>


<body>


<FORM NAME=form1>
<%	
	for (int i=0;i<nameVect.size();i++) {
		String nextName = (String) nameVect.elementAt(i);
		String textName = nextName + "Txt";
//		String pathName = nextName + "Path";
		
		String nextTag = (String) tagVect.elementAt(i);
		String yCordStr = us.get(nextTag);
		yCord = new Long(yCordStr).longValue();
		yCord = 100-yCord;
		yCord = yCord*(1000-200)/100 + 200;
		String currPnt = new Long(xCord).toString() 
					+ " " + new Long(yCord).toString() + " ";
%>
		<%=nextName+"Txt"%>
		<INPUT TYPE="text" NAME="<%=nextName+"Txt"%>" value="<%=currPnt%>"> <br>
<%
	}
%>	
</FORM>

<SCRIPT LANGUAGE=JavaScript>

	var Elem1 = window.parent.frames["SarGraph"].document.getElementById("abc");

	//////////////////////////
	// 		sample code:	//
	//////////////////////////
	var count = window.parent.frames["SarData"].document.form1.count.value;
	count ++;
	
	if (count == 20) {
		window.parent.frames["SarData"].document.form1.count.value = 0;

		// refresh the graph
		window.parent.frames["SarGraph"].location.href = "/orb/jsp/sys/SarGraph.jsp";

		<%	for (int i=0;i<nameVect.size();i++) { 
				String nextName = (String) nameVect.elementAt(i);
				String nextColor = (String) colorVect.elementAt(i);
				String textName = nextName + "Txt";
				String pathName = nextName + "Path";
		%>
		
/*	
		// draw the polyline
  		var polyLine = window.parent.frames["SarGraph"].document.createElement("v:polyline");
	  		var fill = window.parent.frames["SarGraph"].document.createElement("v:fill");
			fill.on = "false";
			polyLine.appendChild(fill);

  			polyLine.strokeweight = .1+"pt";
  			polyLine.strokecolor = "black";
			polyLine.points = <%=pathName%>;
			Elem1.appendChild(polyLine);
*/	
		<% } %>
	} else 
		window.parent.frames["SarData"].document.form1.count.value = count;

		
<%	for (int i=0;i<nameVect.size();i++) { 

		String nextName = (String) nameVect.elementAt(i);
		String nextColor = (String) colorVect.elementAt(i);
		String textName = nextName + "Txt";
		String pathName = nextName + "Path";
%>
	
		// new point	
		var newPoint = document.form1.<%=textName%>.value;

		// save the path data
		var <%=pathName%> = window.parent.frames["SarData"].document.form1.<%=pathName%>.value;
		var <%=pathName%> = <%=pathName%> + newPoint;
		window.parent.frames["SarData"].document.form1.<%=pathName%>.value = <%=pathName%>;
	
		// draw the line
		var line = window.parent.frames["SarGraph"].document.createElement("v:line");
		line.strokeweight = .1+"pt";
		line.strokecolor = "<%=nextColor%>";
		line.from = window.parent.frames["SarData"].document.form1.<%=textName%>.value;
		line.to = newPoint;
		Elem1.appendChild(line);

		window.parent.frames["SarData"].document.form1.<%=textName%>.value = newPoint;
	
<% } %>

</script>




</body>
</html>
