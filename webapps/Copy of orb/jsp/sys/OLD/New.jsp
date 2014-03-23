<%@ page import = "UnixSar" %>

<%! long xCord = 300; %>
<%! String usrStr = ""; %>
<%! String sysStr = ""; %>
<%! String wioStr = ""; %>
<%! String idleStr = ""; %>

<%
	String unix = request.getParameter("machine");
	out.println(unix);
	UnixSar us = new UnixSar(unix, "oracle", "oracle00", "", "5", "5000");
	us.start();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title></title>
	
	<META HTTP-EQUIV="refresh" content="5;
		URL=http:/orb/jsp/sys/New.jsp?machine=<%=unix%>&load=null">

<xml:namespace prefix="v"/>
<object id="VMLRender" classid="CLSID:10072CEC-8CC1-11D1-986E-00A0C955B42E" 
		width="0" height="0"></object>
	
	
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

<SCRIPT LANGUAGE=JavaScript>
function drawVML() {
	var test = "<v:polyline points = \"0,17,1,126,2,23,3,54,4,67,5,45,6,55,7,87\""
		+ " strokecolor=\"green\" strokeweight=\".3pt\"></v:polyline>"
		
	document.write(test);
}
</script>


<div style="margin-top=12pt">
<v:group style="height=200pt; width=400pt" coordsize="4000,2000">


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
 
 

 <v:polyline points="
<%
	xCord += 10;
	String xCordStr = new Long(xCord).toString();
	
	//-------------------------------------------
	String yCordStr = us.get("%idle");
	long yCord = new Long(yCordStr).longValue();
	yCord = 100-yCord;
	yCord = yCord*(1000-200)/100 + 200;
	System.out.print("i:" + yCord + ", ");
	idleStr = idleStr + new Long(xCord).toString() + " " + new Long(yCord).toString() + " ";
	out.println(idleStr);
%>
"  
 strokecolor="silver" strokeweight=.3pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
 </v:polyline>  

 
  
  <v:polyline points="
<%
	xCordStr = new Long(xCord).toString();
	
	//-------------------------------------------
	yCordStr = us.get("%wio");
	yCord = new Long(yCordStr).longValue();
	yCord = 100-yCord;
	yCord = yCord*(1000-200)/100 + 200;
	System.out.print("w:" + yCord + ", ");
	wioStr = wioStr + new Long(xCord).toString() + " " + new Long(yCord).toString() + " ";
	out.println(wioStr);
%>
"  
 strokecolor="blue" strokeweight=.3pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
  </v:polyline>


  <v:polyline points="
<%
	xCordStr = new Long(xCord).toString();
	
	//-------------------------------------------
	yCordStr = us.get("%sys");
	yCord = new Long(yCordStr).longValue();
	yCord = 100-yCord;
	yCord = yCord*(1000-200)/100 + 200;
	System.out.print("s:" + yCord + ", ");
	sysStr = sysStr + new Long(xCord).toString() + " " + new Long(yCord).toString() + " ";
	out.println(sysStr);
%>
"  
 strokecolor="red" strokeweight=.3pt >
  <v:stroke joinstyle=round endcap=round  />
  <v:fill on="false" />
  </v:polyline>


  
  
  <v:polyline points="
<%
	xCordStr = new Long(xCord).toString();
	
	//-------------------------------------------
	yCordStr = us.get("%usr");
	yCord = new Long(yCordStr).longValue();
	yCord = 100-yCord;
	yCord = yCord*(1000-200)/100 + 200;
	System.out.println("u:" + yCord);
	usrStr = usrStr + new Long(xCord).toString() + " " + new Long(yCord).toString() + " ";
	out.println(usrStr);
%>
"  
 strokecolor="green" strokeweight=.3pt >
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
