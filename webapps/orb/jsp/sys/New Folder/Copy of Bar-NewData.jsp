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
	out.println(dbhs.getHtmlTable()); 
%>
</ol>



<SCRIPT LANGUAGE="JScript">
	var Elem1 = window.parent.frames["Bar-VML"].document.getElementById("Bar-VML");
/*
	// background
	var rect  = window.parent.frames["Bar-VML"].document.createElement("v:rect");
   		rect.style.position = 'absolute';
   		rect.style.left = 320;
   		rect.style.top = 200; 
   		rect.style.width = 3000;
   		rect.style.height = 780;
		rect.fillcolor = "white"; 
		rect.strokecolor = "white"; 
	Elem1.appendChild(rect);  
*/		
	var table = document.getElementById("OV_DISK_IO");
	var tbody = table.firstChild;
	var tr = tbody.firstChild.nextSibling;
	
	var recCount = 7;
	var columnNo = 1;
	var i;
	var max = 0;
	for (i=0;i<recCount;i++) {
		var td = tr.firstChild;

		for (j=0;j<columnNo;j++) {
			td = td.nextSibling;
		}
		
		// find the max
		var height = td.innerText;
		if (height > max)
			max = height;
			
		tr = tr.nextSibling;
	}

	// ------------ draw the graph ------------------------------
	for (i=0;i<recCount;i++) {
		var td = tr.firstChild;

		for (j=0;j<columnNo;j++) {
			td = td.nextSibling;
		}
		
		// find the max
		var height = td.innerText;
		td.innerText = td.innerText/max;
		
		// conver it
		height = 100 - height;
		height = height * (1000-200)/100 + 200;
		
alert (height);		
		var Elem1 = window.parent.frames["Bar-VML"].document.getElementById("Bar-VML");
		var rect  = window.parent.frames["Bar-VML"].document.createElement("v:rect");
    		rect.style.position = 'absolute';
    		rect.style.left = 400;
    		rect.style.top = 200; 
    		rect.style.width = 500;
    		rect.style.height = height;
    		rect.style.backgroundcolor = "green"; 
			rect.fillcolor = "red"; 
			rect.strokecolor = "white"; 
		Elem1.appendChild(rect);  
		
		
		//alert(td.innerText);
		tr = tr.nextSibling;
	}


	
</SCRIPT>


</body>
</html>
