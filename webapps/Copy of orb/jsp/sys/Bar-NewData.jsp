<%@ page import = "Database" %>
<%@ page import = "DBHtmlSortable" %>

<%@ include file="Session.jsp"%>

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<!--
	<META HTTP-EQUIV="refresh" content="5;
		URL=http:/orb/jsp/sys/Bar-NewData.jsp">
	</META>
-->	
</head>


<body> 

<h3>Datafile I/O</h3>
<ol> 
<% 
	String sqlTag = request.getParameter("sqlTag");
	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);	
	dbhs.executeSQL(sqlTag, "Bar-NewData", null, null);
	int recordCount = dbhs.getRecordCount();
	out.println(dbhs.getHtmlTable()); 
	
System.out.println("sqlTag=" + sqlTag);	
%>
</ol>


<SCRIPT LANGUAGE="JScript">
function drawBarChart(sqlTag, recCount, columnNo) {
	var xLow = 200;
	var xHight = 1000;
	var yWidth = 3000;

	var theSelect = window.parent.frames["Bar-VML"].document.getElementById("ColNameSelect");	
	var columnNo = 1;
	if (theSelect == null)
		columnNo = 1;
	else
		columnNo = theSelect.options[theSelect.selectedIndex].value;
	
	//alert(columnNo);
	
	// background color
	var Elem1 = window.parent.frames["Bar-VML"].document.getElementById("Bar-VML");
	var rect  = window.parent.frames["Bar-VML"].document.createElement("v:rect");
    	rect.style.position = 'absolute';
    	rect.style.left = 315;
    	rect.style.top = 200; 
    	rect.style.width = 3000;
    	rect.style.height = 800;
    	//rect.style.backgroundcolor = "green"; 
		rect.fillcolor = "white"; 
		rect.strokecolor = "white"; 
	Elem1.appendChild(rect);  

	// draw the scale
	var x = 0;
	for (x=0;x<4;x++) {
		var line  = window.parent.frames["Bar-VML"].document.createElement("v:line");
		line.style.position = "absolute";
		line.style.width = 3000; 
		line.style.height = 800;
		line.from = "305 " + (360 + x*160);	
		line.to = "3300 " + (360 + x*160);
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

		var Elem1 = window.parent.frames["Bar-VML"].document.getElementById("Bar-VML");
		var rect  = window.parent.frames["Bar-VML"].document.createElement("v:rect");
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
	

drawBarChart("<%=sqlTag%>", <%=recordCount%>, 2);	

</SCRIPT>

sqlTag = <%=sqlTag.toString()%>;

</body>
</html>
