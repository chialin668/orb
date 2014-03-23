<%@ include file="Session.jsp"%>

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title></title>
	<xml:namespace prefix="v"/>
	<style>
	v\:* { behavior: url(#default#VML); }
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
				text-align=left; '>Title</v:textbox>

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
							left:10pt;top:10pt;
							height=200pt; width=400pt" 
							coordsize="4000,2000"></div>

<!-- background color -->							
 <v:rect style='position:absolute;
 	left:300;top:200;
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
  <v:path v="M 300,360 L 3040,360 X 
  				M 300,520 L 3040,520 X 
				M 300,680 L 3040,680 X 
				M 300,840 L 3040,840 X E" />
 </v:shape>


 <!-- YCord line -->
 <v:polyline points="300 200 300 1100"  strokecolor="#000000" strokeweight=1.5pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>
 

			
</body>

</html>



