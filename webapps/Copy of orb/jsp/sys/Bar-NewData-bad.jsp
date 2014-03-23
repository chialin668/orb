<%@ page import = "Database" %>
<%@ page import = "DBHtmlSortable" %>

<%@ include file="Session.jsp"%>

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<META HTTP-EQUIV="refresh" content="5;
		URL=http:/orb/jsp/sys/Bar-NewData.jsp">
	</META>
</head>



<body> 


<h3>Datafile I/O</h3>
<ol>
<% 
	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);	
	dbhs.executeSQL("OV_DISK_IO", "Bar-NewData", null, null);
//	out.println(dbhs.getHtmlTable()); 
%>
</ol>


<SCRIPT LANGUAGE="JScript">
function abc() {
  
  var outStr = document.form12.theDay.options[document.form12.theDay.selectedIndex].text;

   alert(outStr);
//	[myForm.secondYear.selectedIndex
}

function drawBarChart(sqlTag, recCount, columnNo) {
	var xLow = 200;
	var xHight = 1000;
	
	// background color
	var Elem1 = window.parent.frames["Bar-VML"].document.getElementById("Bar-VML");
	var rect  = window.parent.frames["Bar-VML"].document.createElement("v:rect");
    	rect.style.position = 'absolute';
    	rect.style.left = 320;
    	rect.style.top = 200; 
    	rect.style.width = 3000;
    	rect.style.height = 780;
    	//rect.style.backgroundcolor = "green"; 
		rect.fillcolor = "white"; 
		rect.strokecolor = "white"; 
	Elem1.appendChild(rect);  

	// draw the scale
	var x = 0;
	for (x=0;x<4;x++) {
		var line  = window.parent.frames["Bar-VML"].document.createElement("v:line");
		line.style.position = "absolute";
		line.style.width = 4320; 
		line.style.height = 1950;
		line.from = "305 " + (360 + x*151);	// @@@why 151 rather than 160???		
		line.to = "3040 " + (360 + x*151);
		line.strokecolor = "silver";	line.strokeweight = "0.5pt";
		Elem1.appendChild(line);  
	}

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
	var inc = 400;
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
		
		var Elem1 = window.parent.frames["Bar-VML"].document.getElementById("Bar-VML");
		var rect  = window.parent.frames["Bar-VML"].document.createElement("v:rect");
    		rect.style.position = 'absolute';
    		rect.style.left = inc;
    		rect.style.top = top; 
    		rect.style.width = 300;
    		rect.style.height = height;
    		rect.style.backgroundcolor = "green"; 
			rect.fillcolor = "red"; 
			rect.strokecolor = "white"; 
		Elem1.appendChild(rect);  
		
		inc = inc + 400;
		//alert(td.innerText);
		tr = tr.nextSibling;
	}
}
	
drawBarChart("OV_DISK_IO", 7, 1);

</SCRIPT>


</body>
</html>
