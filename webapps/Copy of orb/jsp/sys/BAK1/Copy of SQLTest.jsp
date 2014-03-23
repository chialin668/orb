<%@ page import = "Database" %>
<%@ page import = "DBHtml" %>
<%@ page import = "DBHtmlSortable" %>
<%@ page import = "ServerSession" %>


<%@ include file="Session.jsp"%>

<%
	// @@@
	username = "sys";
	
	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");
	
	// SQL
	String sqlTag = request.getParameter("sqlTag");
	if (sqlTag == null)
		sqlTag = chkTag;
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title><%=machine%></title>
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>
	
</head>

<body>

<h3>Machine: <%=machine%></h3>
<h3>SID: <%=sid%></h3>

<ol>
<% 
	SQLReader sqlReader = new SQLReader();
	sqlReader.refresh();
	
	DBHtml dbh = new DBHtml(machine, port, username, password, sid);
//	dbh.executeSQL("OV_INIT_PARAM");
//	out.println(dbh.getHtmlTable()); 

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);	
	dbhs.executeSQL(sqlTag, "SQLTest", chkTag, colName);
	out.println(dbhs.getHtmlTable()); 
	
%>

<script language="Javascript">
var angles = new Array(30, 60, 45, 90, 30, 60, 45);

/////////////////////////
//		Pie
/////////////////////////
function drawPie() {
	
	var win = document.getElementById("info");
	win.style.visibility = "visible";

	var i;	
	var from = 0;
	for (i=0;i<angles.length;i++) {

		var height = angles[i] *65536;

		var arc = document.createElement("v:shape");
			arc.style.position = 'absolute';
			arc.style.width = 4320;
			arc.style.height = 3240;
			arc.strokeweight = "0.5pt"; 
			arc.fillcolor = "white";
			arc.path="M 1000 700 AE 1000 700 500 320 " 
						+ from + " " 
						+ height + " X E";
		win.appendChild(arc);  
	
		from = from + height
	}
}


/////////////////////////
//		Background for Column and line
/////////////////////////
function drawBackground(win) {
	// x cord
  	var l = document.createElement("v:line");
  	l.strokeweight = "1.5pt";
  	l.strokecolor = "black";
  	l.from = "250 1014";
  	l.to = "3300 1014";
  	win.appendChild(l);
	
	// y cord
  	var l = document.createElement("v:line");
  	l.strokeweight = "1.5pt";
  	l.strokecolor = "black";
  	l.from = "300 200";
  	l.to = "300 1100";
  	win.appendChild(l);

	// y scale	
	var x = 0;
	for (x=0;x<4;x++) {
		var line  = document.createElement("v:line");
		line.style.position = "absolute";
		line.style.width = 4000; 
		line.style.height = 2000;
		line.from = "260 " + (360 + x*160);	
		line.to = "3300 " + (360 + x*160);
		line.strokecolor = "silver";	
		line.strokeweight = "0.5pt";
		win.appendChild(line);  
	}
}

/////////////////////////
//		Column
/////////////////////////
function drawColumn() {
	
	var win = document.getElementById("info");
	win.style.visibility = "visible";

	drawBackground(win);
	
	// ----- prepare to draw -----
	var yLow = 200;
	var yHeight = 1000;
	var xWidth = 3000;
	
	var recCount = angles.length;

	// find the max	
	var maxHeight = 0;
	for (i=0;i<recCount;i++)
		if (angles[i] > maxHeight) 
			maxHeight = angles[i];
			
	var width = (xWidth*2/3)/recCount;
	var lengthBetween = (xWidth*1/3)/(recCount+1);
	var inc = 300 + lengthBetween;

	// draw it!!
	for (i=0;i<angles.length;i++) {
		
		// scale it
		var height = angles[i];
		height = (height*100)/maxHeight;

		// change it to between 0 and 100
		height = height * (yHeight - yLow)/100;
		
		// needs to reverse the data
		var top = yHeight - height;

		var rect  = document.createElement("v:rect");
    		rect.style.position = 'absolute';
    		rect.style.left = inc;
    		rect.style.top = top; 
    		rect.style.width = width;
    		rect.style.height = height;
    		rect.style.backgroundcolor = "green"; 
			rect.fillcolor = "red"; 
			rect.strokecolor = "white"; 
		win.appendChild(rect);  

		
/*
	  	var l = document.createElement("v:line");
  		l.strokeweight = "1.5pt";
	  	l.strokecolor = "black";
		if (i == 0)
			l.from = (inc + width/2) + " " + top;
		else
	  		l.from = prev;
  		l.to = (inc + width/2) + " " + top;
	  	win.appendChild(l);
*/
		
		inc = inc + width + lengthBetween;
	}
}


/////////////////////////
//		line
/////////////////////////
function drawLine() {
	
	var win = document.getElementById("info");
	win.style.visibility = "visible";

	drawBackground(win);
	
	// ----- prepare to draw -----
	var yLow = 200;
	var yHeight = 1000;
	var xWidth = 3000;
	
	var recCount = angles.length;

	// find the max	
	var maxHeight = 0;
	for (i=0;i<recCount;i++)
		if (angles[i] > maxHeight) 
			maxHeight = angles[i];
			
	var width = xWidth/(recCount-1);
	var inc = 300;
	
	// draw it!!
	var prev = 300;
	for (i=0;i<angles.length;i++) {
		
		// scale it
		var height = angles[i];
		height = (height*100)/maxHeight;

		// change it to between 0 and 100
		height = height * (yHeight - yLow)/100;
		
		// needs to reverse the data
		var top = yHeight - height;

	  	var l = document.createElement("v:line");
  		l.strokeweight = "1.5pt";
	  	l.strokecolor = "green";
  		l.from = prev + " " + top;
  		l.to = inc + " " + top;
	  	win.appendChild(l);
		
		prev = l.to;
		inc = inc + width;

	}
}

/////////////////////////
//		area
/////////////////////////
function drawArea() {
	
	var win = document.getElementById("info");
	win.style.visibility = "visible";

	drawBackground(win);
	
	// ----- prepare to draw -----
	var yLow = 200;
	var yHeight = 1000;
	var xWidth = 3000;
	
	var recCount = angles.length;

	// find the max	
	var maxHeight = 0;
	for (i=0;i<recCount;i++)
		if (angles[i] > maxHeight) 
			maxHeight = angles[i];
			
	var width = (xWidth*2/3)/recCount;
	var lengthBetween = (xWidth*1/3)/(recCount+1);
	var inc = 300 + lengthBetween;

	// draw it!!
	var prev = "0,0";
	var startPnt = "0,0";
	for (i=0;i<angles.length;i++) {
		
		// scale it
		var height = angles[i];
		height = (height*100)/maxHeight;

		// change it to between 0 and 100
		height = height * (yHeight - yLow)/100;
		
		// needs to reverse the data
		var top = yHeight - height;

  		var p = document.createElement("v:polyline");
  			var fill = document.createElement("v:fill");
			fill.on = "true";
			fill.color = "green";
			p.appendChild(fill);
  		p.strokeweight = .1+"pt";
  		p.strokecolor = "green";
  		//p.points = "50,235,50,145,12,123";
		var from = "200,200";
		if (i==0) {
			from = (inc + width/2) + "," + top;
			startPnt = (inc + width/2) + "," + (top+1000-top);
		} else 
	  		from = prev;
			
  		var to = (inc + width/2) + "," + top;
		var endPnt = (inc + width/2) + "," + (top+1000-top);
		p.points = startPnt + "," + from + "," + to + "," + endPnt;
//alert(p.points);					
  		win.appendChild(p);
	
		prev = (inc + width/2) + "," + top;
		startPnt = endPnt;
		inc = inc + width + lengthBetween;
	}
}


</script>


<A href="/orb/jsp/graph/Graph-Frame.jsp?
					sqlTag=<%=sqlTag%>
					&chartType=Pie
					&columnNo=1
					"
					target="Graph">Graph-Frame Chart</a><br>

<A href="/orb/jsp/graph/Chart.jsp?
					">New Chart</a><br>

					
	<A href="javascript:drawPie()">Pie</a><br>
	<A href="javascript:drawColumn()">Column</a><br>
	<A href="javascript:drawLine()">Line</a><br>
	<A href="javascript:drawArea()">Area</a><br>
</ol>

<A href="/orb/jsp/oracle/doc/Desc-<%=sqlTag%>.jsp" target="desc.htm">Description-1</a><br>



<SCRIPT LANGUAGE="JavaScript">
	var downX = 0;
	var downY = 0;
	var upX = 0;
	var upY = 0;
	
	function mouseDown() {
		downX = event.x;
		downY = event.y;
	}
	
	function mouseUp() {
		upX = event.x;
		upY = event.y;
		var diffX = upX - downX;
		var diffY = upY - downY;

		var Elem1 = document.getElementById("info");
		Elem1.style.left = parseInt(Elem1.style.left) + diffX;
		Elem1.style.top = parseInt(Elem1.style.top) + diffY;
	}
	
	function mouseMove() {
		//alert(event.x);
	}
	
	function closeWin() {
		// hide the background
		var Elem1 = document.getElementById("info");
		Elem1.style.visibility = "hidden";
	}
	
</SCRIPT>



	
	<v:group id="info" style="position:absolute; visibility:hidden;
							left:10pt; 
							top:10pt;
							height=200pt; 
							width=400pt";
							coordsize="4000,2000">
							<A 
							onmousedown="mouseDown()" 
							onmousemove="mouseMove()"
							onmouseup="mouseUp()">							
							
							
 <v:rect style='position:absolute;
 	left:0;top:0;
	width:4000;height:2000;' 
	fillcolor="black" ><H3 align=center><FONT color=#ffffff>agcT</FONT></H3> 
  <v:stroke on="false" /> 
 </v:rect>

 <v:rect style='position:absolute;
 	left:30;top:30;
	width:50;height:50;' 
	fillcolor="white" 
	onmousedown = "closeWin()">
  <v:stroke on="false" /> 
 </v:rect>
 
 <v:rect style='position:absolute;
 	left:10;top:130;
	width:3980;height:1860;' 
	fillcolor="white" >
  <v:stroke on="false" /> 
 </v:rect>

<v:textbox style='position:absolute;
			left:200;top:50;
 			text-align=center;'>x</v:textbox>
 
	</v:group>	



</body>
</html>
