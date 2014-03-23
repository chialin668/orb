<%@ page import = "java.util.*" %>
<%@ page import = "com.orb.sys.Environment" %>
<%@ page import = "com.orb.oracle.DBMem" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.sys.VMLString" %>


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
	int graphWidth = Environment.GRAPH_WIDTH;
	int graphHeight = Environment.GRAPH_HEIGHT;
	String statName = request.getParameter("statName");
	String tag = request.getParameter("tag");

	String graphTitle = statName;

	out.println("<b>machine:</b> " + machine);
	out.println("<b>SID:</b> " + sid);
	out.println("&nbsp;&nbsp;&nbsp;");


	///////////////////////////////////////////////////
	Enumeration colNames = request.getParameterNames();

	Vector colVect = new Vector();

	String colName = null;
	while(colNames.hasMoreElements()) {
		String outStr = (String)colNames.nextElement();

		// @@@ What if we have more???
		if (!outStr.equals("statName") && !outStr.equals("class") && !outStr.equals("tag")) {
			colName = outStr;
			colVect.add(colName);
		} else
			continue;

	}


	if (colName == null) {
		out.println("Choose a colunm name!!!");
		return;
	}



	///////////////////////////////////////////////////////
	// data should be between (400, 2500) and (4180, 530)
	//	x: 400 ~ 4180
	//	y: 530 ~ 2500
	///////////////////////////////////////////////////////
	Vector dataVect = new Vector();
	Vector colorVect = new Vector();
	colorVect.add("red");
	colorVect.add("green");
	colorVect.add("blue");
	colorVect.add("yellow");
	colorVect.add("silver");

	String dataStr = "";


	VMLString vml = new VMLString(sid, tag, statName, colName);

	if (statName != null) {

		dataStr = vml.generate();
		if (dataStr == null) {
			out.println("<br>No value for stat: " + statName);
			return;
		}


	} else
		return;

%>


<html>
<head>
	<Title></title>
		<xml:namespace prefix="v"/>
		<object id="VMLRender"
			classid="CLSID:10072CEC-8CC1-11D1-986E-00A0C955B42E"
			width="0" height="0">
		</object>

		<style>
			v\:* {behavior=url(#VMLRender)}
			 p.Chart {position=absolute;
			 			font-size=8pt;
			 			font-family="times";
			 			color=black;
			 			text-align=right}
			 p.copy {font-size=8pt;
			 			font-style=italic}
		</style>
</head>

<body>

<div style="margin-top=12pt">
<v:group style="height=<%=graphHeight%>pt; width=<%=graphWidth%>pt" coordsize="4320,3240">

<!-- the border -->
<v:rect
 	style='width=4320; height=3240'
	fillcolor="white">
  	<v:shadow on="true" offset="4pt,3pt" color="silver" />
</v:rect>



 <p class=Chart style='position:absolute;
	 		left:10pt;top:8pt;
	 		width:200pt;height:6pt;
			color="#000080";
			font-size=10pt;'><%=graphTitle%></p>

<!------------------------------------------------------------------------------------------------------>

<!-- xCord unit -->
<v:shape style='position:absolute; width:4000; height:2000' strokeweight=0.7pt >

<!-- X coord -->
<v:path v="M 820,4200 L 820,4000
		X M 1240,4200 L 1240,4000
		X M 1660,4200 L 1660,4000
		X M 2080,4200 L 2080,4000
		X M 2500,4200 L 2500,4000
		X M 2920,4200 L 2920,4000
		X M 3340,4200 L 3340,4000
		X M 3760,4200 L 3760,4000
		X M 4180,4200 L 4180,4000
		X  E" />
</v:shape>

 <!-- xCord line -->
 <v:polyline points="350 2500 4200 2500"  strokecolor="#000000" strokeweight=1.2pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>

<!-- XCord title
 <p class=Chart style='position:absolute;
	 		left:230pt;top:108pt;
	 		width:120pt;height:6pt;
			color="#000080";
			font-size=10pt;'>The X Cord is here!!</p>
-->

<!-- XCord unit -->
 <p class=Chart style='position:absolute; left:30pt; top:100pt; width:16pt; height:6pt;'>0:00</p>
 <p class=Chart style='position:absolute; left:66pt; top:100pt; width:16pt; height:6pt;'>1:00</p>
 <p class=Chart style='position:absolute; left:102pt; top:100pt; width:16pt; height:6pt;'>2:00</p>
 <p class=Chart style='position:absolute; left:138pt; top:100pt; width:16pt; height:6pt;'>3:00</p>
 <p class=Chart style='position:absolute; left:174pt; top:100pt; width:16pt; height:6pt;'>4:00</p>
 <p class=Chart style='position:absolute; left:210pt; top:100pt; width:16pt; height:6pt;'>5:00</p>
 <p class=Chart style='position:absolute; left:246pt; top:100pt; width:16pt; height:6pt;'>6:00</p>
 <p class=Chart style='position:absolute; left:282pt; top:100pt; width:16pt; height:6pt;'>7:00</p>
 <p class=Chart style='position:absolute; left:318pt; top:100pt; width:16pt; height:6pt;'>8:00</p>
 <p class=Chart style='position:absolute; left:354pt; top:100pt; width:16pt; height:6pt;'>9:00</p>


<!------------------------------------------------------------------------------------------------------>

<!-- Y Cord -->

<v:shape style='position:absolute;
		width:4320; height:3240'
		strokeweight=0.7pt
		strokecolor='silver'>
		<v:path v="M 405,2090 L 4180,2090
			X M 405,1700 L 4180,1700
			X M 405,1310 L 4180,1310
			X M 405,920 L 4180,920
			X M 405,530 L 4180,530
			X  E" />
</v:shape>

<v:shape style='position:absolute;
		width:4320; height:3240'
		strokeweight=0.7pt>
		<v:path v="M 393,2090 L 356,2090
			X M 393,1700 L 356,1700
			X M 393,1310 L 356,1310
			X M 393,920 L 356,920
			X M 393,530 L 356,530
			X  E" />
</v:shape>

 <!-- YCord line -->
 <v:polyline points="400 480 400 2530"  strokecolor="#000000" strokeweight=1.2pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>

 <!-- XCord title
 <p class=Chart style='position:absolute;
	 		left:0pt;top:10pt;
	 		width:120pt;height:6pt;
			color="#000080";
			font-size=10pt;'>The Y Cord is here!!</p>



<!-- YCord title (VERTICAL)
	<v:shape style='position:absolute;
					width:4320; height:3240'
					path="M 132,2063 L 132,530"
					fillcolor="#000080" >
		<v:stroke on=0 />
		<v:path textpathok="t" />
		<v:textpath on=1
				style='font-family="Times New Roman";font-size=9pt'
				string="The Y Cord is here!!" />
	</v:shape>
-->

 <!-- YCord unit
 <p class=Chart style='position:absolute; left:5pt; top:90pt; width:16pt; height:6pt; '>0</p>
 <p class=Chart style='position:absolute; left:5pt; top:75pt; width:16pt; height:6pt; '>1</p>
 <p class=Chart style='position:absolute; left:5pt; top:60pt; width:16pt; height:6pt; '>2</p>
 <p class=Chart style='position:absolute; left:5pt; top:45pt; width:16pt; height:6pt; '>3</p>
 <p class=Chart style='position:absolute; left:5pt; top:30pt; width:16pt; height:6pt; '>124</p>
 <p class=Chart style='position:absolute; left:5pt; top:15pt; width:16pt; height:6pt; '>523k</p>
 -->


<%
	out.println(vml.getYUnit());
%>


<!--------------------------------------------------------------------------------------------------

 <v:polyline points='<%=dataStr%>'
 strokecolor='red' strokeweight=.3pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on='false' />
 </v:polyline>

---->


<%

	for (int i=0;i<colVect.size();i++) {
		String colName1 = (String) colVect.elementAt(i);

		VMLString vmlx = new VMLString(sid, tag, statName, colName1);
		String outStr = vmlx.generate();
		dataVect.add(outStr);
	}


	for (int i=0;i<dataVect.size();i++) {
		String dataStr1 = (String) dataVect.elementAt(i);
		String color = (String) colorVect.elementAt(i);

		out.println("<v:polyline points='" + dataStr1 + "'");
		out.println("strokecolor='" + color + "' strokeweight=.3pt >");
		out.println(" <v:stroke joinstyle=round endcap=round  />");
		out.println(" <v:fill on='false' />");
		out.println("</v:polyline>");
	}

%>


<!-
<v:polyline points="400 2500 4180 530"
	strokecolor="green" strokeweight=.3pt >
	  <v:stroke joinstyle=round endcap=round  />
	 <v:fill on="false" />
</v:polyline>
 ->


</body>
</html>