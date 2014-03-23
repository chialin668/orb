<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title>Untitled</title>
	<style>
	v\:* { behavior: url(#default#VML); }
	</style>

</head>

<body>
<SCRIPT LANGUAGE="JavaScript">
	var downX = 0;
	var downY = 0;
	var upX = 0;
	var upY = 0;
	
	function mouseDown() {
		downX = event.x;
		downY = event.y;
	}
	
	function mouseUp() {
		upX = event.x;
		upY = event.y;
		var diffX = upX - downX;
		var diffY = upY - downY;

		var Elem1 = document.getElementById("info");
		Elem1.style.left = parseInt(Elem1.style.left) + diffX;
		Elem1.style.top = parseInt(Elem1.style.top) + diffY;
	}
	
	function mouseMove() {
		//alert(event.x);
	}
	
	function closeWin() {
		// hide the background
		var Elem1 = document.getElementById("info");
		Elem1.style.visibility = "hidden";
		Elem1.style.height = 0;
		
		// hide the image
		var Elem1 = document.getElementById("Bar-VML");
		Elem1.style.visibility = "hidden";
	}
	
function addArc() {
	var Elem = document.getElementById("Bar-VML");
	var arc = Elem.createElement("v:shape");
		arc.style.position = 'absolute';
		arc.style.width = 4320;
		arc.style.height = 3240;
		arc.strokeweight = "0.5pt"; 
		arc.fillcolor = "black";
		arc.path="M 1000 700 AE 1000 700 500 320 0  23592960 X E";
		Elem.appendChild(arc);  
}
	
</SCRIPT>


<DIV id="info" 
	style="position:absolute; 
	left: 50; top: 50; 
	width: 400; height: 200;  
	background-color:gray;
	layer-background-color: green; 
	onmousedown: test;	
	clip: rect(0,500,200,0)">
	<A onmousedown="mouseDown()" 
		onmousemove="mouseMove()"
		onmouseup="mouseUp()">
	<H3 align=center>Title</H3> 

	<v:rect style='position:absolute;
 		left:3; top:3;
		width:8; height:8;' 
		fillcolor="white" 
		onmousedown = "closeWin()">
  		<v:stroke on="false" /> 
	</v:rect>
	
	
	<!-- border-->
	<v:rect style='position:absolute;
 		left:3; top:15;
		width:394; height:182;' 
		fillcolor="white" >
  		<v:stroke on="false" /> 
	</v:rect>



	
<v:textbox style='position:absolute;
			left:200;top:50;
 			text-align=center;'>x</v:textbox>
	
	<v:group id="Bar-VML" style="position:absolute;
							left:10pt; top:10pt;
							height=200pt; width=400pt" 
							coordsize="4000,2000"></div>


 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="green" 
	path="M 500 400 
		AE 500 400 500 320 0 5898240
		X E" />
		
 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="red" 
	path="M 500 400 
		AE 500 400 500 320 5898240 11796480
		X E" />

 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="white" 
	path="M 500 400 
		AE 500 400 500 320 17694720 1966080
		X E" />
		
 <v:shape style='position:absolute; width:4320; height:3240' 
 	strokeweight=0.5pt 
	fillcolor="blue" 
	path="M 500 400 
		AE 500 400 500 320 19660800 3932160
		X E" />

	</v:group>	

</DIV>

<SCRIPT LANGUAGE="JavaScript">
	addArc();

</SCRIPT>


</body>
</html>
