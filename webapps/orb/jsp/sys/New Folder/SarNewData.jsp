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

<SCRIPT LANGUAGE=JavaScript>
	var nameArray = new Array("idle", "usr", "sys", "wio");
	var tagArray = new Array("%idle", "%usr", "%sys", "%wio");
	var colorArray = new Array("silver", "green", "blue", "red");
	alert(nameArray.length);

	var Elem1 = window.parent.frames["SarGraph"].document.getElementById("abc");

	//////////////////////////
	// 		sample code:	//
	//////////////////////////
	var count = window.parent.frames["SarData"].document.form1.count.value;
	count ++;
	
	<% if (xCord >= 3300) { %>

		// refresh the graph
		window.parent.frames["SarGraph"].location.href = "/orb/jsp/sys/SarGraph.jsp";
//		var pathData = window.parent.frames["SarData"].document.form1.PATH.value;
/*	
		// draw the polyline
  		var polyLine = window.parent.frames["SarGraph"].document.createElement("v:polyline");
	  		var fill = window.parent.frames["SarGraph"].document.createElement("v:fill");
			fill.on = "false";
			polyLine.appendChild(fill);

  			polyLine.strokeweight = .1+"pt";
  			polyLine.strokecolor = "black";
			polyLine.points = somePoints;
			Elem1.appendChild(polyLine);  
*/	
		<% xCord = 300;
	} // if %> 

		
	<%	for (int i=0;i<nameVect.size();i++) { 

		String nextName = (String) nameVect.elementAt(i);
		String nextColor = (String) colorVect.elementAt(i);
		String textName = nextName + "Txt";
		String pathName = nextName + "Path";
		String pathData = nextName + "Data";
		
		// get the data
		String nextTag = (String) tagVect.elementAt(i);
		String yCordStr = us.get(nextTag);
		yCord = new Long(yCordStr).longValue();
		yCord = 100-yCord;
		yCord = yCord*(1000-200)/100 + 200;
%>	
		///////////////////////////////////////////
		// save the path data
		var <%=pathData%> = window.parent.frames["SarData"].document.form1.<%=pathName%>.value;
		var <%=pathData%> = <%=pathData%> + <%=yCord%> + " ";
		window.parent.frames["SarData"].document.form1.<%=pathName%>.value = <%=pathData%>;
	
		// draw the line
		var oldX = window.parent.frames["SarData"].document.form1.xCord.value;
		var oldY = window.parent.frames["SarData"].document.form1.<%=textName%>.value;
		
		var line = window.parent.frames["SarGraph"].document.createElement("v:line");
		line.strokeweight = .1+"pt"; 
		line.strokecolor = "<%=nextColor%>";
		line.from = oldX + " " + oldY;
		line.to = <%=xCord%> + " " + <%=yCord%>;
		Elem1.appendChild(line);
		
		window.parent.frames["SarData"].document.form1.<%=textName%>.value = <%=yCord%>;
	
	<% } %>

	window.parent.frames["SarData"].document.form1.xCord.value = <%=xCord%>;
	
</script>




</body>
</html>
