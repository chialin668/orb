<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title></title>
	<xml:namespace prefix="v"/>
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>
	
</head>

<body>

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
 			left:100;top:200;
			width:10;height:10;  
			text-align=center; '>x</v:textbox>

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
 <v:polyline points="250 1000 3300 1000"  strokecolor="#000000" strokeweight=1.5pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>


	
<!-- Y Cord unit -->
 <v:shape style='position:absolute; width:4320; height:1950' 
 			strokecolor="black" strokeweight=0.5pt >
  <v:path v="M 260,360 L 280,360 X 
  				M 260,520 L 280,520 X 
				M 260,680 L 280,680 X 
				M 260,840 L 280,840 X E" />
 </v:shape>


 <v:shape style='position:absolute; width:4320; height:1950' 
 			strokecolor="silver" strokeweight=0.5pt >
  <v:path v="M 280,360 L 3040,360 X 
  				M 280,520 L 3040,520 X 
				M 280,680 L 3040,680 X 
				M 280,840 L 3040,840 X E" />
 </v:shape>

 <!-- YCord line -->
 <v:polyline points="300 200 300 1100"  strokecolor="#000000" strokeweight=1.0pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>
 

			
</body>

</html>



