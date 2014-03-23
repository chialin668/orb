<%@ include file="Session.jsp"%>


<%
	int height 	= 200;
	int width 	= 400;
	
	String sqlTag = request.getParameter("sqlTag");	
	String urlParams = "machine=" + machine
						+ "&sqlTag=" + sqlTag;
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
function refresh() {
	window.parent.frames["Bar-NewData"].document.location.reload();
}
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
<!---------------------------- The background ---------------------------->
<!------------------------------------------------------------------------>
<v:group id="Bar-VML" style="position:absolute;
							left:10pt; top:10pt;
							height=<%=height%>pt; width=<%=width%>pt" 
							coordsize="4000,2000"></div>

<!-- image background 
<v:rect style='position:absolute; width=4000; height=2000' 
		fillcolor="green">
  	<v:shadow on="true" 
		offset="4pt,3pt" 
		color="silver" />
</v:rect>
-->
							
<!-- background color -->							
 <v:rect style='position:absolute;
 	left:315;top:200;
	width:3000;height:800;' 
	fillcolor="white" >
  <v:stroke on="false" /> 
 </v:rect>


 <!-- xCord line -->
 <v:polyline points="250 1014 3300 1014"  strokecolor="#000000" strokeweight=1.5pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>


	
<!-- Y Cord unit -->
 <v:shape style='position:absolute; width:4000; height:2000' 
 			strokecolor="black" strokeweight=0.5pt >
  <v:path v="M 260,360 L 300,360 X 
  				M 260,520 L 300,520 X 
				M 260,680 L 300,680 X 
				M 260,840 L 300,840 X E" />
 </v:shape>


 <v:shape style='position:absolute; width:4000; height:2000' 
 			strokecolor="silver" strokeweight=0.5pt >
  <v:path v="M 300,360 L 3300,360 X 
  				M 300,520 L 3300,520 X 
				M 300,680 L 3300,680 X 
				M 300,840 L 3300,840 X E" />
 </v:shape>

<!-- YCord unit TEST --> 	
<v:textbox style='position:absolute;
				left:30pt; top:101.4pt;'>
				ABC
</v:textbox>
	
<!-- YCord unit TEST --> 	
<v:textbox style='position:absolute;
				left:330pt; top:101.4pt;'>
				XYZ
</v:textbox>


 <!-- YCord line -->
 <v:polyline points="300 200 300 1100"  strokecolor="#000000" strokeweight=1.5pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>

</v:group>



<!------------------------------------------------------------------------>
<!---------------------------- Right click menu -------------------------->
<!------------------------------------------------------------------------>
<div id="ie5menu" class="skin0" 
		onMouseover="highlightie5()" 
		onMouseout="lowlightie5()" 
		onClick="jumptoie5();">
	<div class="menuitems" url="/orb/jsp/sys/Bar-Frame.jsp?<%=urlParams%>" target="Graph">Bar Chart</div>
	<div class="menuitems" url="/orb/jsp/sys/Arc-Frame.jsp?<%=urlParams%>" target="Graph">Pie Chart</div>
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



