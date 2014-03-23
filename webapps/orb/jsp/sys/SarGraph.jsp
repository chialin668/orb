<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<xml:namespace prefix="v"/>
	
	<title></title>
	
	<object id="VMLRender" classid="CLSID:10072CEC-8CC1-11D1-986E-00A0C955B42E" 
		width="0" height="0">
	</object>
	
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>
	
	<style>
		 v\:* {behavior=url(#VMLRender)}
		/* Default style for all chart text elements - deviations are issued in-line */
		 p.Chart {position=absolute; font-size=8pt; font-family="times"; color=black; text-align=right}
		/* Miscellaneous document styles */
		 p.copy {font-size=8pt; font-style=italic}
	</style>
</head>

<body>

<div id="hello" style="margin-top=12pt">
<v:group id="abc" style="height=200pt; width=400pt" coordsize="4000,2000"></div>


 <!-- the title -->
 <p class=Chart style='position:absolute;
 		left:0pt;top:0pt;width:300pt;height:15pt;  
		color="#000080";font-style=italic;  
		font-size=10pt; text-align=center; '>Test Graph</p>
 
 <!-- xCord # -->
<v:shape style='position:absolute; width:4000; height:2000' strokeweight=0.7pt >
 
	<v:path v="M 600,1000 L 600,1030 X 
				M 900,1000 L 900,1030 X 
				M 1200,1000 L 1200,1030 X 
				M 1500,1000 L 1500,1030 X
				M 1800,1000 L 1800,1030 X 
				M 2100,1000 L 2100,1030 X 
				M 2400,1000 L 2400,1030 X
				M 2700,1000 L 2700,1030 X 
				M 3000,1000 L 3000,1030 X E" />
</v:shape>

<!-- XCord title -->
 <p class=Chart style='position:absolute;
 	left:200pt;top:110pt;width:132pt;height:8.3pt;  
	color="#008080"; font-size=8pt;'>The X Cord is here!!</p>
	
<!-- XCord unit -->
 <p class=Chart style='position:absolute;
 	left:48.4pt;top:155.36pt;width:16pt;height:6.64pt;  
	text-align=center; '>P1</p>

 <!-- xCord line -->
 <v:polyline points="3300 1000 250 1000"  strokecolor="#000000" strokeweight=1.2pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>

	
<!-- Y Cord unit -->
 <v:shape style='position:absolute; width:4320; height:1950' strokeweight=0.5pt >
  <v:path v="M 260,360 L 3040,360 X 
  				M 260,520 L 3040,520 X 
				M 260,680 L 3040,680 X 
				M 260,840 L 3040,840 X E" />
 </v:shape>

 <!-- YCord title -->
 <v:shape style='position:absolute; 
 	width:4320; height:3240' path="M 132,600 L 132,100" fillcolor="#008080" >
  <v:stroke on=0 /><v:path textpathok="t" />
  <v:textpath on=1 style='font-family="Times New Roman"; 
  	font-size=8pt' string="The Y Cord" />
 </v:shape>

 <!-- YCord unit -->
 <p class=Chart style='position:absolute;
 	left:0pt;top:30;width:16pt;height:6.64pt; ; '>100</p>
 
 <p class=Chart style='position:absolute;
 	left:0pt;top:55;width:16pt;height:6.64pt; ; '>80</p>

 <p class=Chart style='position:absolute;
 	left:0pt;top:80;width:16pt;height:6.64pt; ; '>60</p>

 <p class=Chart style='position:absolute;
 	left:0pt;top:105;width:16pt;height:6.64pt; ; '>40</p>

 <p class=Chart style='position:absolute;
 	left:0pt;top:130;width:16pt;height:6.64pt; ; '>20</p>
	
 <p class=Chart style='position:absolute;
 	left:0pt;top:155;width:16pt;height:6.64pt; ; '>0</p>

	
 <!-- YCord line -->
 <v:polyline points="300 200 300 1100"  strokecolor="#000000" strokeweight=1.2pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>

 
<!-- lagend -->
 <v:polyline points="400 1500 520 1500"  strokecolor="#808000" strokeweight=0.3pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>
 
 <p class=Chart style='position:absolute;
	 		left:58pt;top:166pt;width:120pt;height:8.3pt;  
			color="#000080"; font-size=10pt; text-align=left'>Cum Variance</p>
			
</body>

</html>



