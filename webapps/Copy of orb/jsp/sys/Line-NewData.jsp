<%@ page import = "UnixSar" %>
<%@ page import = "SarData" %>
<%@ page import = "CordConverter" %>

<%! String pointStrIdle = ""; %>
<%! static String pointStrSys = ""; %>
<%! static String pointStrUsr = ""; %>
<%! static String pointStrWio = ""; %>

<%! static long xCord = 300; %>

<%
	long yCord = 0; 
	long inclement = 20;
%>


<%
	String machine = request.getParameter("machine");
	out.println("machine = " + machine + "<br>");
	
	UnixSar us = null;
	if (machine != null) {
		us = new UnixSar(machine, "oracle", "oracle00", "", "5", "5000");
		us.start();
	} else
		return;
	
	xCord += inclement;
	
	
%>

 

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<META HTTP-EQUIV="refresh" content="5;
		URL=http:/orb/jsp/sys/Line-NewData.jsp?machine=<%=machine%>">
	</META>
</head>



<body> 
<%
if (xCord > 3300) {
	xCord = 300;
	pointStrIdle = "";
	pointStrSys = "";
	pointStrUsr = "";
	pointStrWio = "";
}
///////////////////////////////////////////////////////////////////////////
			SarData s = new SarData();
			s.put("devdcx", "%idle", us.get("%idle"));
			s.put("devdcx", "%usr", us.get("%usr"));

			// generate points on the fly...
			CordConverter cc = new CordConverter();
			String retStr = "";
			Vector v = s.getDataVect("devdcx", "%idle");
			for (int j=0;j<v.size();j++) {


				retStr = retStr + cc.getX() + " "
					+ cc.getY(Integer.parseInt((String) v.elementAt(j))) + " ";
			}
			System.out.println(retStr);
	
///////////////////////////////////////////////////////////////	
	String yCordStr = us.get("%sys");
		yCord = new Long(yCordStr).longValue();
		yCord = 100-yCord;
		yCord = yCord*(1000-200)/100 + 200;
	pointStrSys = pointStrSys + xCord + " " + yCord + " ";
	//out.println(pointStrIdle);

		yCordStr = us.get("%usr");
		yCord = new Long(yCordStr).longValue();
		yCord = 100-yCord;
		yCord = yCord*(1000-200)/100 + 200;
	pointStrUsr = pointStrUsr + xCord + " " + yCord + " ";
	//out.println(pointStrIdle);

		yCordStr = us.get("%wio");
		yCord = new Long(yCordStr).longValue();
		yCord = 100-yCord;
		yCord = yCord*(1000-200)/100 + 200;
	pointStrWio = pointStrWio + xCord + " " + yCord + " ";
	//out.println(pointStrIdle);

%>


<SCRIPT LANGUAGE=JavaScript>

	var Elem1 = window.parent.frames["Line-VML"].document.getElementById("Line-VML");
		
		// background
		var rect  = window.parent.frames["Line-VML"].document.createElement("v:rect");
    		rect.style.position = 'absolute';
    		rect.style.left = 320;
    		rect.style.top = 200; 
    		rect.style.width = 3000;
    		rect.style.height = 780;
    		//rect.style.backgroundcolor = "green"; 
			rect.fillcolor = "white"; 
			rect.strokecolor = "white"; 
		Elem1.appendChild(rect);  

	
		// draw the polyline
  		var polyLine = window.parent.frames["Line-VML"].document.createElement("v:polyline");
	  		var fill = window.parent.frames["Line-VML"].document.createElement("v:fill");
			fill.on = "false";
			polyLine.appendChild(fill);

  			polyLine.strokeweight = .3+"pt";
	  		polyLine.strokecolor = "silver";
			polyLine.points = "<%=retStr%>";
		Elem1.appendChild(polyLine);  
 
		// draw the polyline
  		var polyLine = window.parent.frames["Line-VML"].document.createElement("v:polyline");
	  		var fill = window.parent.frames["Line-VML"].document.createElement("v:fill");
			fill.on = "false";
			polyLine.appendChild(fill);

  			polyLine.strokeweight = .3+"pt";
	  		polyLine.strokecolor = "blue";
			polyLine.points = "<%=pointStrSys%>";
		Elem1.appendChild(polyLine);  

		// draw the polyline
  		var polyLine = window.parent.frames["Line-VML"].document.createElement("v:polyline");
	  		var fill = window.parent.frames["Line-VML"].document.createElement("v:fill");
			fill.on = "false";
			polyLine.appendChild(fill);

  			polyLine.strokeweight = .3+"pt";
	  		polyLine.strokecolor = "green";
			polyLine.points = "<%=pointStrUsr%>";
		Elem1.appendChild(polyLine);  

		// draw the polyline
  		var polyLine = window.parent.frames["Line-VML"].document.createElement("v:polyline");
	  		var fill = window.parent.frames["Line-VML"].document.createElement("v:fill");
			fill.on = "false";
			polyLine.appendChild(fill);

  			polyLine.strokeweight = .3+"pt";
	  		polyLine.strokecolor = "red";
			polyLine.points = "<%=pointStrWio%>";
		Elem1.appendChild(polyLine);  
		
</script>



</body>
</html>
