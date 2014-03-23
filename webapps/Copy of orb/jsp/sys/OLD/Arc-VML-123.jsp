<%@ include file="Session.jsp"%>

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


<FORM NAME=form12>
<SELECT ID=ColNameSelect NAME=colName
	onchange='return refresh();' >
   <OPTION VALUE=1 SELECTED>Physical reads
   <OPTION VALUE=2>Physical writes
   <OPTION VALUE=3>Read time
   <OPTION VALUE=4>Write time
</SELECT>
</FORM>


<SCRIPT LANGUAGE="JScript">
function refresh() {
	window.parent.frames["Arc-NewData"].document.location.reload();
}
</SCRIPT>

<!-- the title -->				
<v:textbox style='position:absolute;
				left:100pt;top:0pt;
				width:300pt;height:15pt;
				color="#000080";  
				font-style=italic;  
				font-size=10pt;
				text-align=left; '>Title</v:textbox>

	
	
<!------------------------------------------------------------------------>
<!---------------------------- The background ---------------------------->
<!------------------------------------------------------------------------>
<v:group id="Arc-VML" style="position:absolute;
							left:10pt;top:10pt;
							height=200pt; width=400pt" 
							coordsize="4000,2000"></div>

 

<!--
 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="green" 
	path="M 1000 700 
		AE 1000 700 500 320 0 23592960
		X E" />
	
 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="green" 
	path="M 2000 700 
		AE 2000 700 500 320 0 5898240
		X E" />
		
 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="red" 
	path="M 2000 700 
		AE 2000 700 500 320 5898240 11796480
		X E" />

 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="white" 
	path="M 2000 700 
		AE 2000 700 500 320 17694720 1966080
		X E" />
		
 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="blue" 
	path="M 2000 700 
		AE 2000 700 500 320 19660800 3932160
		X E" />
-->		


<!------------------------------------------------------------------------>
<!---------------------------- Right click menu -------------------------->
<!------------------------------------------------------------------------>
<div id="ie5menu" class="skin0" 
		onMouseover="highlightie5()" 
		onMouseout="lowlightie5()" 
		onClick="jumptoie5();">
	<div class="menuitems" url="/orb/jsp/sys/Bar-Frame.jsp" target="Graph">Bar Chart</div>
	<div class="menuitems" url="/orb/jsp/sys/Arc-Frame.jsp" target="Graph">Pie Chart</div>
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



