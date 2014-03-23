<%@ page import = "com.orb.oracle.Database" %>
<%@ page import = "com.orb.oracle.DBHtml" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "java.util.Vector" %>

<%@ include file="Session.jsp"%>

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<!--
	<META HTTP-EQUIV="refresh" content="5;
		URL=http:/orb/jsp/sys/Arc-NewData.jsp">
	</META>
-->
</head>


<body>

<h3>Datafile I/O</h3>
<ol>
<%
	String sqlTag = request.getParameter("sqlTag");
	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL(sqlTag, "Arc-NewData", null, null);
	int recordCount = dbhs.getRecordCount();
	out.println(dbhs.getHtmlTable());

%>
</ol>


<SCRIPT LANGUAGE="JScript">
function drawArcChart(sqlTag, recCount, columnNo) {
	var colors = new Array("#ff8080", "#804040", "#ff8040", "#004000", "#808040",
					"#004040", "#408080", "#004080", "#004080", "#808080",
					"#8BC5C5", "#C0C080", "#400040","#80FFc0", "#FF80c0");

	var theSelect = window.parent.frames["Arc-VML"].document.getElementById("ColNameSelect");
	var columnNo = 1;
	if (theSelect == null)
		columnNo = 1;
	else
		columnNo = theSelect.options[theSelect.selectedIndex].value;
//alert(columnNo);

	var Elem1 = window.parent.frames["Arc-VML"].document.getElementById("Arc-VML");

	// background color
	var arc = window.parent.frames["Arc-VML"].document.createElement("v:shape");
		arc.style.position = 'absolute';
		arc.style.width = 4320;
		arc.style.height = 3240;
		arc.strokeweight = "0.5pt";
		arc.fillcolor = "white";
		arc.path="M 1000 700 AE 1000 700 500 320 0  23592960 X E";
		Elem1.appendChild(arc);

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
document.write("total: " + parseInt(total) + "<br>");
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

		var arc = window.parent.frames["Arc-VML"].document.createElement("v:shape");
			arc.style.position = 'absolute';
			arc.style.width = 4320;
			arc.style.height = 3240;
			arc.strokeweight = "0.5pt";
			arc.fillcolor = "white";
			arc.fillcolor = colors[i%15];
			arc.path="M 1000 700 AE 1000 700 500 320 " + parseInt(from) + " "
												+ parseInt(height) + " X E";

		Elem1.appendChild(arc);
		from = from + height;

		tr = tr.nextSibling;
	}
}

drawArcChart("<%=sqlTag%>", <%=recordCount%>, 2);

</SCRIPT>


</body>
</html>


