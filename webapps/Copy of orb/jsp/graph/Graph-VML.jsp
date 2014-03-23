<%@ include file="../sys/Session.jsp"%>


<%
	int height 	= 200;
	int width 	= 400;
	
	String sqlTag = request.getParameter("sqlTag");	
	String columnNo = request.getParameter("columnNo");	
	
	String urlParams = "machine=" + machine
						+ "&sqlTag=" + sqlTag
						+ "&columnNo=" + columnNo;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/RightClickMenu.js"></SCRIPT>
	
	<title></title>
	<xml:namespace prefix="v"/>

	<style>
		v\:* { behavior: url(#default#VML); }
		@import url("/css/RightClickMenu.css");
	</style>
	
	
</head>

<body>


<!--
<FORM NAME=form12>
<SELECT ID=ColNameSelect NAME=colName
	onchange='return refresh();' >
   <OPTION VALUE=1 SELECTED>Physical reads
   <OPTION VALUE=2>Physical writes
   <OPTION VALUE=3>Read time
   <OPTION VALUE=4>Write time
</SELECT>
</FORM>
-->

<SCRIPT LANGUAGE="JScript">
//function refresh() {
//	window.parent.frames["Graph-NewData"].document.location.reload();
//}
</SCRIPT>

<!-- the title -->				
<v:textbox style='position:absolute;
				left:100pt;top:0pt;
				width:300pt;height:15pt;
				color="#000080";  
				font-style=italic;  
				font-size=10pt;
				text-align=left; '>Title Here</v:textbox>

<!-- XCord unit --> 
<v:textbox style='position:absolute;
			left:0;top:100;
 			text-align=center;'>x</v:textbox>

<!-- YCord unit --> 	
<v:textbox style='position:absolute;
				left:0;top:115;
				width:50;height:100;
				text-align=left; '>y</v:textbox>
	
	
<!------------------------------------------------------------------------>
<!---------------------------- The Object ---------------------------->
<!------------------------------------------------------------------------>
<v:group id="Graph-VML" style="position:absolute;
							left:10pt; top:10pt;
							height=<%=height%>pt; width=<%=width%>pt" 
							coordsize="4000,2000"></div>
</v:group>



<!------------------------------------------------------------------------>
<!---------------------------- Right click menu -------------------------->
<!------------------------------------------------------------------------>

<div id="ie5menu" class="skin0" 
		onMouseover="highlightie5()" 
		onMouseout="lowlightie5()" 
		onClick="jumptoie5();">
	<div class="menuitems" url="/orb/jsp/graph/Graph-Frame.jsp?<%=urlParams%>&chartType=Bar" 
							target="Graph">Bar</div>
	<div class="menuitems" url="/orb/jsp/graph/Graph-Frame.jsp?<%=urlParams%>&chartType=Pie" 
							target="Graph">Pie</div>
</div>

<script language="JavaScript1.2">
	if (document.all && window.print) {
		ie5menu.className = menuskin;
		document.oncontextmenu = showmenuie5;
		document.body.onclick = hidemenuie5;
	}
	

</script>
 
 
</body>
</html>



