//var data = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
//var data1 = new Array(65, 23, 25, 77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89);
//var data2 = new Array(77, 12, 63, 75, 55, 90, 123, 45, 77, 84, 23, 65, 89, 34, 12, 43);
//var data3 = new Array(55, 90, 123, 45, 77, 84, 23, 65, 89, 34, 12, 43, 32, 65, 44, 78);
//var dataAll = new Array(data1, data2, data3);
//var dataAll = new Array(data1);

//
// Some variables
//
var win;					// the pop-up window

var borderX = 4000;			// total
var borderY = 2000;			// total

var bgTop = 200;			// top of the graph (reversed)
var bgLeft = 500;			// left of the graph 
var bgHeight = 1700;		// usable for column, line, area, etc.
var bgWidth = 3300;			// usable for column, line, area, etc.

var hasPie = false;			// has Pie chart already?
var hasBackGround = false;	// has background alerady?
var hasColumn = false;		//
var hasLine = false;		//
var hasArea = false;		//

var hasDesc = false;
	
////////////////////////////////////////////////////////////////////////////////////////////////

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


////////////////////////////////////////////////////////////////////////////////////////////////


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

				arc.data = rowNameArray[i] + ": "
							+ colNameArray[colArray[1]] + " " 
							+ data[i];

			arc.style.position = 'absolute';
			arc.style.width = 4320;
			arc.style.height = 3240;
			arc.strokeweight = "0.5pt"; 
				arc.onmouseover = showDesc;
				arc.onmouseout = hideDesc;
			
			arc.fillcolor = "#" + parseInt(Math.random()*10000000%819200);
			arc.path="M 1000 700 AE 1000 700 500 320 " 
						+ parseInt(from) + " " 
						+ parseInt(height) + " X E";
		win.appendChild(arc);  
	
		from = from + height
	}

	hasPie = true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////
//		Background for Column and line
//////////////////////////////////////////////////
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

//
// show the description pop-up
//
function showDesc() {
	var srcElem = event.srcElement;
	//alert(srcElem.data);
	
	if (!hasDesc) {
	    var desc = document.createElement('v:roundrect');
		desc.id = "desc";
			// the text in the pop-up
			var text = document.createTextNode("abc here");
			desc.appendChild(text);
			
		document.body.appendChild(desc);
		hasDesc = true;
		
	} else {
		var desc = document.getElementById("desc");
	}
	
	// setup the text
	text = desc.firstChild;  //@@@ couldn't set the id?????
	desc.innerText = event.srcElement.data;
	
	// properties for the pop-up desc
	desc.style.position = 'absolute';
	desc.style.width = 100;
	desc.style.height = 50;
	desc.style.top = event.y-10;
	desc.style.left = event.x+10;
	desc.fillcolor = "yellow"; 
	desc.style.visibility = "visible";	
}

//
// hide the description pop-up
//
function hideDesc() {
	var desc = document.getElementById("desc");
	desc.style.visibility = "hidden";
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
	
	// find the max	
	var maxHeight = 0;
	var minHeight = 4294967296; // 2^32
	
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];

		var recCount = data.length;
		for (i=0;i<recCount;i++) {
			if (data[i] > maxHeight) 
				maxHeight = data[i];
			if (data[i] < minHeight)
				minHeight = data[i];
		}
	}
	
	// ----- prepare to draw -----
	var j = 0;
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];
	
		var recCount = data.length;
		
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
				rect.data = rowNameArray[i] + ": "
							+ colNameArray[colArray[j+1]] + " " 
							+ data[i];
    			rect.style.position = 'absolute';
    			rect.style.left = inc + (width/dataAll.length)*j;
    			rect.style.top = top; 
    			rect.style.width = width/dataAll.length;
    			rect.style.height = height;
    			rect.style.backgroundcolor = "green"; 
				rect.fillcolor = "#" + color; 
				rect.strokecolor = "white"; 
				rect.onmouseover = showDesc;
				rect.onmouseout = hideDesc;
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
	
	drawUnits(minHeight, maxHeight);	
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
	
	// find the max	
	var maxHeight = 0;
	var minHeight = 4294967296; // 2^32
	
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];
	
		var recCount = data.length;
		for (i=0;i<recCount;i++) {
			if (data[i] > maxHeight) 
				maxHeight = data[i];
			if (data[i] < minHeight)
				minHeight = data[i];
		}
	}
	
	// ----- prepare to draw -----
	var j = 0;
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];
	
		var recCount = data.length;

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
				l.data = rowNameArray[i] + ": "
							+ colNameArray[colArray[j+1]] + " " 
							+ prev + "," + top + ":" 
							+ inc + "," + top;
			
  			l.strokeweight = ".5pt";
		  	l.strokecolor = "#" + color;
  			l.from = prev + " " + top;
  			l.to = inc + " " + top;
		  	win.appendChild(l);

				l.onmouseover = showDesc;
				l.onmouseout = hideDesc;
		
			prev = l.to;
			inc = inc + width;
		}
	}

	drawUnits(minHeight, maxHeight);
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

	
	// find the max	
	var maxHeight = 0;
	var minHeight = 4294967296; // 2^32
	
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];
	
		var recCount = data.length;
		for (i=0;i<recCount;i++) {
			if (data[i] > maxHeight) 
				maxHeight = data[i];
			if (data[i] < minHeight)
				minHeight = data[i];
		}
	}

	// ----- prepare to draw -----
	var j = 0;
	for (j=0;j<dataAll.length;j++) {
		data = dataAll[j];

		var recCount = data.length;

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
				p.data = rowNameArray[i] + ": "
							+ colNameArray[colArray[j+1]] + " " 
							+ data[i];
			
  				var fill = document.createElement("v:fill");
				fill.on = "true";
				fill.color = "#" + color;
				p.appendChild(fill);
				
				p.onmouseover = showDesc;
				p.onmouseout = hideDesc;
				
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
	
	drawUnits(minHeight, maxHeight);	
	hasArea = true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////


function drawUnits(minHeight, maxHeight) {
	////////////////////////////////////////////////////////
	// x: 40 ~ 440, 150
	// y: 20, 25 ~ 135
	////////////////////////////////////////////////////////
	var variableY = 280;			//@@ CHANGE THIS!!
	
	var scale = 1;
	var count = 5;
	
	var diff = (maxHeight - minHeight)/5;
	
	for (i=0;i<6;i++) {
		var rect  = document.createElement("v:textbox");
    		rect.style.position = 'absolute';
    		rect.style.left = 20*scale;
			rect.style.size = "6pt";
    		rect.style.top = (26+i*variableY/6)*scale; 
			//rect.style.text-align=center; // BAD
			var data = minHeight + diff*(5-i);
			data = parseInt(data*100)/100;
			rect.innerText = data;
		win.appendChild(rect);  
	}
	//////////////////////////////////////////////////////////

	var count = 15;
	for (i=0;i<count+1;i++) {
		var rect  = document.createElement("v:textbox");
    		rect.style.position = 'absolute';
    		rect.style.left = (40+i*400/count)*scale; 
    		rect.style.top = 150*scale;
			rect.innerText = "*";
//		win.appendChild(rect);  
	}

}

