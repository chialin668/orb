<%@ page import = "java.util.Vector" %>
<%@ page import = "DBMem" %>


<%@ include file="../sys/Session.jsp"%>

<%
	int graphWidth = 400;
	int graphHeight = 120;

	double graphXMin = 400;
	double graphXMax = 4180;
	double graphYMin = 530;
	double graphYMax = 2500;
	
	double x = graphXMin;
	double X_INCREMENT = 10;
	
	double y = 0.0;
	double yMax = 0.0;
	double yMin = 2147483647;  
	double dataHeight = 0;
	String yUnitArr[] = new String[6];
	
	//String graphTitle = "bytes sent via SQL*Net to client";
	//String graphTitle = "bytes received via SQL*Net from client";
	String graphTitle = "opened cursors cumulative";
	//String graphTitle = "logons current";
	
	///////////////////////////////////////////////////////
	// data should be between (400, 2500) and (4180, 530)
	//	x: 400 ~ 4180
	//	y: 530 ~ 2500
	///////////////////////////////////////////////////////
	String dataStr = "410 1500 420 1580 430 1200 440 1500 450 1580 460 1200 470 1700 480 1700 490 1797 500 1895 "
			+ "510 1590 520 1687 530 1602 540 1500 550 1280 560 1200 570 1700 580 1700 590 1797 600 1895 "
			+ "610 1590 620 1687 630 1602 640 1500 650 980 660 1200 670 1700 680 1700 690 1797 700 1895 ";


//	out.println(dataStr);

	String outStr = "";
	String statName = graphTitle;
	
	if (statName != null) {
		DBMem t = new DBMem();
		
		Vector valueVect = (Vector) t.getVect(sid, statName);
		if (valueVect != null) {

			///////////////////////////////
			// calculate the difference
			///////////////////////////////
			double prevData = 0.0;
			Vector diffVect = new Vector();
			for (int i=0;i<valueVect.size();i++) {
				if (i==0) {
					prevData = Double.parseDouble((String) valueVect.elementAt(i));
					continue;
				} else {
					y = Double.parseDouble((String) valueVect.elementAt(i)) - prevData;
					prevData = Double.parseDouble((String) valueVect.elementAt(i));
				}
				diffVect.add(new Double(y).toString());
			}
			
			///////////////////////////////
			// Find min and max
			///////////////////////////////
			for (int i=0;i<diffVect.size();i++) {
				double chkData = Double.parseDouble((String) diffVect.elementAt(i));
				if (chkData >= yMax) yMax = chkData;
				
				chkData = Double.parseDouble((String) diffVect.elementAt(i));
				if (chkData <= yMin) yMin = chkData;
			}

			dataHeight = yMax - yMin;
			out.println("<br><b>Max:</b> " + yMax 
					+ ", <b>Min:</b> " + yMin 
					+ ", <b>Height:</b> " + dataHeight + "<br>");

			///////////////////////////////
			// Generate the output string
			///////////////////////////////
			for (int i=0;i<diffVect.size();i++) {
				x = x + X_INCREMENT;
				y = Double.parseDouble((String) diffVect.elementAt(i));
				y = y - yMin;
				y = (int) (y*(graphYMax-graphYMin)/dataHeight);
				y = graphYMax - y;
				
				//out.println("x: " + x + "y: " + y + "<br>");
				outStr = outStr + " " + x + " " + y;
//@@@@				
dataStr = outStr;
			}
			
		} else
			out.println("sid: " + sid + " is NOT monitored!!");
		
			

		if (outStr.length()>1)
			outStr = outStr.substring(1);
		else 
			return;
			
//		out.print("==>" + outStr + "<==");		
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
 <p class=Chart style='position:absolute; left:30pt; top:100pt; width:16pt; height:6pt;'>24:00</p>
 <p class=Chart style='position:absolute; left:66pt; top:100pt; width:16pt; height:6pt;'>1:00</p>
 <p class=Chart style='position:absolute; left:102pt; top:100pt; width:16pt; height:6pt;'>2:00</p>
 <p class=Chart style='position:absolute; left:138pt; top:100pt; width:16pt; height:6pt;'>13:00</p>
 <p class=Chart style='position:absolute; left:174pt; top:100pt; width:16pt; height:6pt;'>4:00</p>
 <p class=Chart style='position:absolute; left:210pt; top:100pt; width:16pt; height:6pt;'>5:00</p>
 <p class=Chart style='position:absolute; left:246pt; top:100pt; width:16pt; height:6pt;'>16:00</p>
 <p class=Chart style='position:absolute; left:282pt; top:100pt; width:16pt; height:6pt;'>23:00</p>
 <p class=Chart style='position:absolute; left:318pt; top:100pt; width:16pt; height:6pt;'>8:00</p>
 <p class=Chart style='position:absolute; left:354pt; top:100pt; width:16pt; height:6pt;'>19:00</p>
 
 
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
	///////////////////////////////
	// calculate y unit
	///////////////////////////////
	int unitCount = 6;
	for (int i=0;i<unitCount;i++) {
		double result = yMin + i*dataHeight/(unitCount-1);

		// K
		if (Math.round(result)/1000000 > 0) {
			result = result/1000000;
			result = Math.round(result*10.0)/10.0;
			yUnitArr[i] = result + "M";
		
		} else if (Math.round(result)/1000 > 0) {
			result = result/1000;
			result = Math.round(result*10.0)/10.0;
			yUnitArr[i] = result + "K";
		} else
			yUnitArr[i] = new Double(result).toString();
	}
	
	int top = 90;
	int diff = 15;
	for (int i=0;i<6;i++) {
		out.println("<p class=Chart style='position:absolute; left:5pt; top:"
				+ (top - i*diff) + "pt; width:16pt; height:6pt; '>"
				+ yUnitArr[i] + "</p>");
	}
%>


<!------------------------------------------------------------------------------------------------------>

 <v:polyline points="<%=dataStr%>"
 strokecolor="red" strokeweight=.3pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>


<!-
<v:polyline points="400 2500 4180 530"
	strokecolor="green" strokeweight=.3pt >
	  <v:stroke joinstyle=round endcap=round  />
	 <v:fill on="false" />
</v:polyline>
 ->
 
 
</body>
</html>