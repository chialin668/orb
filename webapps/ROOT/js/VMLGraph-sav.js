////////////////////////////////////////////////////////////////////////////////////
//								Option
////////////////////////////////////////////////////////////////////////////////////
function refresh() {
//	window.parent.frames["Graph-NewData"].document.location.reload();
	document.location.reload();
}

function test() {
	alert("this is a test");
}


function addSelect(sqlTag, recCount, columnNo) {
/*
	var theSelect = window.parent.frames["Graph-VML"].document.getElementById("ColNameSelect");	
	if (theSelect != null)
		return;

	var oSelect = window.parent.frames["Graph-VML"].document.createElement("select");
	oSelect.id = "ColNameSelect";
	oSelect.name = "colName";
	oSelect.onchange = refresh;
	
		// ----- get the table -----
		var table = document.getElementById(sqlTag);  // sqlTag: the name of the table
		var tbody = table.firstChild;
		var tr = tbody.firstChild;

		var i;
		var td = tr.firstChild;
			
			for (i=0;i<recCount;i++) {
			
				//alert(td.innerText);
				var oOption = window.parent.frames["Graph-VML"].document.createElement("option");
				oOption.value = i; 
				oOption.innerText = td.innerText;
				if (i == 0)
					oOption.selected = "True"
					
				oSelect.appendChild(oOption);

				td = td.nextSibling;
			}
		//}


	window.parent.frames["Graph-VML"].document.body.appendChild(oSelect);
*/	
}

////////////////////////////////////////////////////////////////////////////////////
//								Bar Chart
////////////////////////////////////////////////////////////////////////////////////
function drawBarChart(sqlTag, recCount, columnNo) {
	var xLow = 200;
	var xHight = 1000;
	var yWidth = 3000;

	
	if (columnNo == 0) {
		var theSelect = window.parent.frames["Graph-VML"].document.getElementById("ColNameSelect");	
		var columnNo = 1;
		if (theSelect == null)
			columnNo = 1;
		else
			columnNo = theSelect.options[theSelect.selectedIndex].value;
	}
	
	//alert(columnNo);
	
	// get the object
	var Elem1 = window.parent.frames["Graph-VML"].document.getElementById("Graph-VML");
	
	// background color
	var rect  = window.parent.frames["Graph-VML"].document.createElement("v:rect");
    	rect.style.position = 'absolute';
    	rect.style.left = 315;
    	rect.style.top = 200; 
    	rect.style.width = 4000;  // was 3000
    	rect.style.height = 2000; // was 800
    	//rect.style.backgroundcolor = "green"; 
		rect.fillcolor = "white"; 
		rect.strokecolor = "white"; 
	Elem1.appendChild(rect);  

	// draw x cord
	var line  = window.parent.frames["Graph-VML"].document.createElement("v:line");
	line.style.position = "absolute";
	line.style.width = 4000; 
	line.style.height = 2000;
	line.from = "250 1014";
	line.to = "3300 1014";
	line.strokecolor = "black";	
	line.strokeweight = "1.5pt";
	Elem1.appendChild(line);  
	
	// draw the scale
	var x = 0;
	for (x=0;x<4;x++) {
		var line  = window.parent.frames["Graph-VML"].document.createElement("v:line");
		line.style.position = "absolute";
		line.style.width = 4000; 
		line.style.height = 2000;
		line.from = "305 " + (360 + x*160);	
		line.to = "3300 " + (360 + x*160);
		line.strokecolor = "silver";	
		line.strokeweight = "0.5pt";
		Elem1.appendChild(line);  
	}

	// draw y cord
	var line  = window.parent.frames["Graph-VML"].document.createElement("v:line");
	line.style.position = "absolute";
	line.style.width = 4000; 
	line.style.height = 2000;
	line.from = "300 200";
	line.to = " 300 1100";
	line.strokecolor = "black";	
	line.strokeweight = "1.5pt";
	Elem1.appendChild(line);  
	
	
	var table = document.getElementById(sqlTag);  // sqlTag: the name of the table
	var tbody = table.firstChild;
	var tr = tbody.firstChild.nextSibling;

	var i, j;

	// find the MAX
	var maxHeight = 0;
	for (i=0;i<recCount;i++) {
		var td = tr.firstChild;

		for (j=0;j<columnNo;j++)
			td = td.nextSibling;

		if (parseInt(td.innerText) > maxHeight) 
			maxHeight = parseInt(td.innerText);
		
		tr = tr.nextSibling;
	}

	////////////////////////////////////	
	// draw the chart
	var width = (yWidth*2/3)/recCount;
	var lengthBetween = (yWidth*1/3)/(recCount+1);
	var inc = 300 + lengthBetween;

	var tr = tbody.firstChild.nextSibling;
	for (i=0;i<recCount;i++) {
		var td = tr.firstChild;

		for (j=0;j<columnNo;j++)
			td = td.nextSibling;
		
		// scale it
		var height = parseInt(td.innerText);
		height = (height*100)/maxHeight;

		// change it to between 0 and 100
		height = height * (xHight - xLow)/100;
		
		// needs to reverse the data
		var top = xHight - height;

		var Elem1 = window.parent.frames["Graph-VML"].document.getElementById("Graph-VML");
		var rect  = window.parent.frames["Graph-VML"].document.createElement("v:rect");
    		rect.style.position = 'absolute';
    		rect.style.left = inc;
    		rect.style.top = top; 
    		rect.style.width = width;
    		rect.style.height = height;
    		rect.style.backgroundcolor = "green"; 
			rect.fillcolor = "red"; 
			rect.strokecolor = "white"; 
		Elem1.appendChild(rect);  
		
		inc = inc + width + lengthBetween;
//		alert(td.innerText);
		tr = tr.nextSibling;
	}
}

////////////////////////////////////////////////////////////////////////////////////
//								Pie Chart
////////////////////////////////////////////////////////////////////////////////////


function drawPieChart(sqlTag, recCount, columnNo) {
	var colors = new Array("#ff8080", "#804040", "#ff8040", "#004000", "#808040",
					"#004040", "#408080", "#004080", "#004080", "#808080",
					"#8BC5C5", "#C0C080", "#400040","#80FFc0", "#FF80c0");

	if (columnNo == 0) {
		var theSelect = window.parent.frames["Graph-VML"].document.getElementById("ColNameSelect");	
		var columnNo = 1;
		if (theSelect == null)
			columnNo = 1;
		else
			columnNo = theSelect.options[theSelect.selectedIndex].value;
	}
//alert(columnNo);

	var Elem1 = window.parent.frames["Graph-VML"].document.getElementById("Graph-VML");

	// background color
	var Graph = window.parent.frames["Graph-VML"].document.createElement("v:shape");
		Graph.style.position = 'absolute';
		Graph.style.width = 4320;  // was 4320
		Graph.style.height = 3240; // was 3240
		Graph.strokeweight = "0.5pt"; 
		Graph.fillcolor = "white";
		Graph.path="M 1000 700 AE 1000 700 500 320 0  23592960 X E";
		Elem1.appendChild(Graph);  
	
	var table = document.getElementById(sqlTag);  // sqlTag: the name of the table
	var tbody = table.firstChild;
	var tr = tbody.firstChild.nextSibling;
	
	var i, j;
	
	// find the MAX
	var total = 0;
	for (i=0;i<recCount;i++) {
		var td = tr.firstChild;

		for (j=0;j<columnNo;j++)
			td = td.nextSibling;

			total = total + parseInt(td.innerText);
		
		tr = tr.nextSibling;
	}
	
	//document.write("total: " + parseInt(total) + "<br>");
	
	////////////////////////////////////	
	// draw the chart
	////////////////////////////////////	
	var tr = tbody.firstChild.nextSibling;
	var from = 0;

	for (i=0;i<recCount;i++) {
		var td = tr.firstChild;

		for (j=0;j<columnNo;j++)
			td = td.nextSibling;
		
		// scale it
		var height = parseInt(td.innerText);
		height = (height*365)/total;

		// change it to between 0 and 100
		height = height *65536;
		
		var Graph = window.parent.frames["Graph-VML"].document.createElement("v:shape");
			Graph.style.position = 'absolute';
			Graph.style.width = 4320;
			Graph.style.height = 3240;
			Graph.strokeweight = "0.5pt"; 
			Graph.fillcolor = "white";
			Graph.fillcolor = colors[i%15];
			Graph.path="M 1000 700 AE 1000 700 500 320 " + parseInt(from) + " " 
												+ parseInt(height) + " X E";

		Elem1.appendChild(Graph);  
		from = from + height;
		
		tr = tr.nextSibling;
	}
}
