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

<FORM ACTION="(Empty Reference!)" NAME="bob" METHOD="get">
x:<INPUT TYPE="TEXT" NAME="leftVal" SIZE="3"><BR>
y:<INPUT TYPE="TEXT" NAME="topVal" SIZE="3"><BR>
</FORM>

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
var data = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);

//var data1 = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
var data1 = new Array(8359,10282,7528,10652,11772,23743,7402,4665,5541,8527,2848,9835,1068);
var data1 = new Array(363,358,358,366,364,361,361,358,359,360,372,359,359,378,370,373,378,360,360,360,
360,362,355,360,361,361,379,361,361,361,361,361,364,361,362,362,382,362,398,357,
441,364,362,386,379,363,377,367,369,370,365,375,373,382,382,383,364,364,364,382);

//var data2 = new Array(77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89, 34, 12, 43);
//var data3 = new Array(55, 90, 123, 45, 77, 84, 23, 65, 89, 34, 12, 43, 32, 65, 44, 78);
//var dataAll = new Array(data1, data2, data3);
var dataAll = new Array(data1);

//
// Global variables
//
var win;				// the pop-up window

var borderX = 4000;			// total
var borderY = 2000;			// total

var bgTop = 200;			// top of the graph (reversed)
var bgLeft = 500;
var bgHeight = 1000;		// usable for column, line, area, etc.
var bgWidth = 3000;		// usable for column, line, area, etc.

var hasPie = false;
var hasBackGround = false;
var hasColumn = false;
var hasLine = false;
var hasArea = false;
var randomColor = new Array();

// setup all colors 
for (i=0;i<dataAll.length;i++)
	randomColor[i] = parseInt(Math.random()*10000000%819200);


//
// is it an array in an array?
//
function validateArray(arrayname){
	return ((typeof eval(arrayname) == "object") && (eval(arrayname).length > 1));
}

//
//	hide all objects in the window
//
function hideAll() {
	var i = 0;
	
	// background 
	var xCord = document.getElementById("xcord");
	if (xCord != null)
		xCord.style.visibility = "hidden";
	
	var yCord = document.getElementById("ycord");
	if (yCord != null)
		yCord.style.visibility = "hidden";
	
	for (i=0;i<4;i++) {
		var yScale = document.getElementById("yscale" + i);
			if (yScale != null)
		yScale.style.visibility = "hidden";
	}
	
	var j = 0;
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];

		// the data
		for (i=0;i<data.length;i++) {
		
			// pie (ONLY 1 set!!!)
			if (j == 0) {
				var pie = document.getElementById("pie" + i);
				if (pie != null) 
					pie.style.visibility = "hidden";
			}
			
			// column
			var column = document.getElementById("column" + j + i);
			if (column != null)
				column.style.visibility = "hidden";
			
			// line
			var line = document.getElementById("line" + j + i);
			if (line != null)
				line.style.visibility = "hidden";

			// area
			var area = document.getElementById("area" + j + i);
			if (area != null)
				area.style.visibility = "hidden";
		}
	}

}
//
// display the pop-up window
//
function showWindow() {
	hideAll();
	
	win = document.getElementById("info");
	win.style.visibility = "visible";

}

//
// display the graph if there is one already
//
function displayGraph(type) {
	// pie
	if (type == "pie") {
		var i = 0;
		for (i=0;i<data.length;i++) {
			var obj = document.getElementById(type + i);
			obj.style.visibility = "visible";
		}
		return;
	}	

	// others
	var j = 0;
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];

		var i = 0;
		for (i=0;i<data.length;i++) {
			var obj = document.getElementById(type + j + i);
			obj.style.visibility = "visible";
		}
	}
}

function getRandomColor(i) {
	return randomColor[i];
}

/////////////////////////
//		Pie
/////////////////////////
function drawPie() {
	showWindow();

	// if there is one already, just display it
	if (hasPie) {
		displayGraph("pie");
		return;
	}
	
	// ONLY one set of data is used by pie chart
	data = dataAll[0];
	
	var total = 0;
	for (i=0;i<data.length;i++)
		total = total + data[i];

	var i;	
	var from = 0; 
	for (i=0;i<data.length;i++) {

		// scale it
		var height = data[i];
		height = (height*365)/total;
		height = height *65536;

		var arc = document.createElement("v:shape");
			arc.id = "pie" + i;
			arc.style.position = 'absolute';
			arc.style.width = 4320;
			arc.style.height = 3240;
			arc.strokeweight = "0.5pt"; 
			arc.fillcolor = "#" + parseInt(Math.random()*10000000%819200);
			arc.path="M 1000 700 AE 1000 700 500 320 " 
						+ parseInt(from) + " " 
						+ parseInt(height) + " X E";
		win.appendChild(arc);  
	
		from = from + height
	}

	hasPie = true;
}


/////////////////////////
//		Background for Column and line
/////////////////////////
function drawBackground(win) {

	if (hasBackGround) {
		// display it
		var xCord = document.getElementById("xcord");
		if (xCord != null)
			xCord.style.visibility = "visible";
	
		var yCord = document.getElementById("ycord");
		if (yCord != null)
			yCord.style.visibility = "visible";
	
		for (i=0;i<4;i++) {
			var yScale = document.getElementById("yscale" + i);
				if (yScale != null)
			yScale.style.visibility = "visible";
		}
		return;
	}
	
	// x cord
  	var l = document.createElement("v:line");
	l.id = "xcord";
  	l.strokeweight = "1.5pt";
  	l.strokecolor = "black";
  	l.from = (bgLeft-50) + " " + (bgHeight+14);	
  	l.to = (bgLeft+bgWidth) + " " + (bgHeight+14);
  	win.appendChild(l);
	
	// y cord
  	var l = document.createElement("v:line");
	l.id = "ycord";	
  	l.strokeweight = "1.5pt";
  	l.strokecolor = "black";
  	l.from = bgLeft + " " + bgTop;
  	l.to = bgLeft + " " + (bgHeight+100);
  	win.appendChild(l);

	// y scale	
	var diff = (bgHeight-bgTop)/5;
	var i = 0;
	for (i=0;i<4;i++) {
		var line  = document.createElement("v:line");
		line.id = "yscale" + i;
		line.style.position = "absolute";
		line.style.width = borderX; 
		line.style.height = borderY;
		line.from = (bgLeft-40) + " " + ((bgTop + diff) + i*diff);	
		line.to = (bgLeft+bgWidth) + " " + ((bgTop + diff) + i*diff);
		line.strokecolor = "silver";	
		line.strokeweight = "0.5pt";
		win.appendChild(line);  
	}
	hasBackGround = true;
}

/////////////////////////
//		Column
/////////////////////////
function drawColumn() {
	showWindow();	
	drawBackground(win);

	// if there is one already, just display it
	if (hasColumn) {
		displayGraph("column");
		return;
	}
	
	// ----- prepare to draw -----
	var j = 0;
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];
	
		var recCount = data.length;

		// find the max	
		var maxHeight = 0;
		var minHeight = data[0];
		for (i=0;i<recCount;i++) {
			if (data[i] > maxHeight) 
				maxHeight = data[i];
			if (data[i] < minHeight)
				minHeight = data[i];
		}
			
		var width = (bgWidth*3/5)/recCount;
		var lengthBetween = (bgWidth*2/5)/(recCount+1);
		var inc = bgLeft + lengthBetween;

		// draw it!!
		var color = getRandomColor(j);
		for (i=0;i<data.length;i++) {
		
			// scale it
			var height = data[i];
//			height = ((height-minHeight)*100)/(maxHeight-minHeight);
			height = (height*100)/maxHeight;

			// change it to between 0 and 100
			height = height * (bgHeight - bgTop)/100;
		
			// needs to reverse the data
			var top = bgHeight - height;

			var rect  = document.createElement("v:rect");
				rect.id = "Column" + j + i;
    			rect.style.position = 'absolute';
    			rect.style.left = inc + (width/dataAll.length)*j;
    			rect.style.top = top; 
    			rect.style.width = width/dataAll.length;
    			rect.style.height = height;
    			rect.style.backgroundcolor = "green"; 
				rect.fillcolor = "#" + color; 
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
	
	hasColumn = true;
}


/////////////////////////
//		line
/////////////////////////
function drawLine() {
	showWindow();	
	drawBackground(win);
	
	// if there is one already, just display it
	if (hasLine) {
		displayGraph("line");
		return;
	}
	
	var j = 0;
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];
	
		// ----- prepare to draw -----
		var recCount = data.length;

		// find the max	
		var maxHeight = 0;
		var minHeight = data[0];
		for (i=0;i<recCount;i++) {
			if (data[i] > maxHeight) 
				maxHeight = data[i];
			if (data[i] < minHeight)
				minHeight = data[i];
		}

		var width = bgWidth/(recCount-1);
		var inc = bgLeft;

		// draw it!!
		var color = getRandomColor(j);
		var prev = bgLeft;
		for (i=0;i<data.length;i++) {
		
			// scale it
			var height = data[i];
//			height = ((height-minHeight)*100)/(maxHeight-minHeight);
			height = (height*100)/maxHeight;

			// change it to between 0 and 100
			height = height * (bgHeight - bgTop)/100;
		
			// needs to reverse the data
			var top = bgHeight - height;

	 	 	var l = document.createElement("v:line");
			l.id = "line" + j + i;
  			l.strokeweight = ".5pt";
		  	l.strokecolor = "#" + color;
  			l.from = prev + " " + top;
  			l.to = inc + " " + top;
		  	win.appendChild(l);
		
			prev = l.to;
			inc = inc + width;
		}
	}

	////////////////////////////////////////////////////////
	// x: 40 ~ 440, 150
	// y: 20, 25 ~ 135
	////////////////////////////////////////////////////////
	var scale = 1;
	var count = 5;
	for (i=25;i<135;i=i+135/5) {
		var rect  = document.createElement("v:textbox");
    		rect.style.position = 'absolute';
    		rect.style.left = 20*scale;
    		rect.style.top = i*scale; 
			rect.innerText = "*";
//		win.appendChild(rect);  
	}
	
	var diff = (maxHeight - minHeight)/5;
	for (i=0;i<6;i++) {
		var rect  = document.createElement("v:textbox");
    		rect.style.position = 'absolute';
    		rect.style.left = 20*scale;
			rect.style.size = "6pt";
    		rect.style.top = (26+i*129/6)*scale; 
			//rect.style.text-align=center; // BAD
			rect.innerText = minHeight + diff*(5-i);
		win.appendChild(rect);  
	}
	//////////////////////////////////////////////////////////
	for (i=40;i<440;i++) {
		var rect  = document.createElement("v:textbox");
    		rect.style.position = 'absolute';
    		rect.style.left = i*scale;
    		rect.style.top = 150*scale; 
			rect.innerText = "*";
		//win.appendChild(rect);  
	}

	var count = 15;
	for (i=0;i<count+1;i++) {
		var rect  = document.createElement("v:textbox");
    		rect.style.position = 'absolute';
    		rect.style.left = (40+i*400/count)*scale; 
    		rect.style.top = 150*scale;
			rect.innerText = "*";
		win.appendChild(rect);  
	}

	
	hasLine = true;
}



/////////////////////////
//		area
/////////////////////////
function drawArea() {
	showWindow();	
	drawBackground(win);
	
	// if there is one already, just display it
	if (hasArea) {
		displayGraph("area");
		return;
	}

	var j = 0;
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];
	
		// ----- prepare to draw -----
		var recCount = data.length;

		// find the max	
		var maxHeight = 0;
		var minHeight = data[0];
		for (i=0;i<recCount;i++) {
			if (data[i] > maxHeight) 
				maxHeight = data[i];
			if (data[i] < minHeight)
				minHeight = data[i];
		}
			
		var width = bgWidth/(recCount-1);
		var inc = bgLeft+10;
	
		// draw it!!
		var color = getRandomColor(j);
		var prev = "0,0";
		var startPnt = "0,0";
	
		for (i=0;i<data.length;i++) {
		
			// scale it
			var height = data[i];
//			height = ((height-minHeight)*100)/(maxHeight-minHeight);
			height = (height*100)/maxHeight;

			// change it to between 0 and 100
			height = height * (bgHeight - bgTop)/100;
		
			// needs to reverse the data
			var top = bgHeight - height;

  			var p = document.createElement("v:polyline");
			p.id = "area" + j + i;
  				var fill = document.createElement("v:fill");
				fill.on = "true";
				fill.color = "#" + color;
				p.appendChild(fill);
  			p.strokeweight = .1+"pt";
  			p.strokecolor = "#" + (color-512);
  			//p.points = "50,235,50,145,12,123";
			var from;
			if (i==0) {
				from = inc + "," + top;
				startPnt = inc + "," + bgHeight;
			} else {
	  			from = prev;
			}
		
  			var to = inc + "," + top;
			var endPnt = inc + "," + bgHeight;
			p.points = startPnt + "," + from + "," + to + "," + endPnt;
  			win.appendChild(p);
	
			prev = inc + "," + top;
			startPnt = endPnt;
			inc = inc + width;
		}
	}
	
	hasArea = true;
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

		var abc = document.getElementById("info");
		document.bob.topVal.value = event.x;
		document.bob.leftVal.value = event.y;

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
		// hide the objects
		hideAll();
		
		// hide the background
		var Elem1 = document.getElementById("info");
		Elem1.style.visibility = "hidden";
	}


function createWindow(title, left, top, width, height, xCordSize, yCordSize) {

	// some default values
	if (left == null) left = "50pt";	
	if (top == null) top = "100pt";
	if (width == null) width = "400pt";
	if (height == null) height = "200pt";
	if (xCordSize == null || yCordSize == null) {
		xCordSize = borderX;
		yCordSize = borderY;
	}
	var cordStr = xCordSize + "," + yCordSize;
	
	var obj = document.createElement("v:group");
	obj.id = "info";
	obj.style.position = "absolute";
	obj.style.visibility = "hidden";
    obj.style.left = left;
    obj.style.top = top; 
    obj.style.width = width;
    obj.style.height = height;
    obj.coordsize = cordStr; 
	obj.onmousedown = mouseDown;
	obj.onmousemove = mouseMove;

	obj.onmouseup = mouseUp;
	document.body.appendChild(obj);

	var rect  = document.createElement("v:rect");
		rect.id = "bg";
		rect.style.position = 'absolute';
		rect.style.left = 0;
  		rect.style.top = 0; 
    	rect.style.width = borderX;
    	rect.style.height = borderY;
    	rect.style.backgroundcolor = "green"; 
		rect.fillcolor = "gray"; 
//		rect.strokecolor = "white"; 
			var title = document.createElement("h3");
			title.align = "center";
				var text = document.createTextNode("title here");
  				title.appendChild(text);
			rect.appendChild(title);
		obj.appendChild(rect);  
	
 	var rect  = document.createElement("v:rect");
		rect.style.position = 'absolute';
		rect.style.left = 30;
  		rect.style.top = 30; 
    	rect.style.width = 50;
    	rect.style.height = 50;
		rect.fillcolor = "white"; 
		rect.onmousedown = closeWin;
		obj.appendChild(rect);  
 
	var rect  = document.createElement("v:rect");
		rect.style.position = 'absolute';
		rect.style.left = 10;
  		rect.style.top = 130; 
    	rect.style.width = borderX-20;
    	rect.style.height = borderY-140;
		rect.fillcolor = "white"; 
		obj.appendChild(rect);  
}
	
	
createWindow("Put the title here", "80pt", "80pt", "400pt", "200pt", 4000, 2000);
//createWindow("Put the title here", "80pt", "80pt", "800pt", "400pt", 4000, 2000);
//createWindow("Put the title here", "10pt", "10pt", "1200pt", "600pt", 4000, 2000);
//createWindow("Put the title here", "10pt", "10pt", "4000pt", "2000pt", 4000, 2000);
</SCRIPT>



</body>
</html>
