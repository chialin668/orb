<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<!--
REM    SQL> @size 
REM    Enter the Oracle Block Size: 4048 
REM    Enter the number of Rows:1000 
REM    Enter Percent Free:          20 
REM    Enter Init Trans:1 
REM    Enter Average Row Length:    500 
REM    Enter number of columns with 250 bytes or less:   10 
REM    Enter number of columns with more than 250 bytes: 2 
-->

<form target="bcResult" action="/orb/jsp/oracle/space/BlockCountResult.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Block Size:</td>
    <td>
	<select id=blockSize name=blockSize>
		<OPTION VALUE="2048">2K
		<OPTION VALUE="4096">4K
		<OPTION VALUE="8192">8K
		<OPTION VALUE="16384">16K
		<OPTION VALUE="32768">32K
		<OPTION VALUE="65536">64K
	</select>	
	</td>
</tr>
<tr>
    <td>Number of Rows:</td>  
	<td><INPUT name=rows size=6 value=10000></td>
</tr>	
	<td>Init Trans:</td>  
	<td><INPUT name=initTran size=3 value=1></td>
<tr>
	<td>Pct Free:</td>
	<td><INPUT name=pctFree size=3 value=10></td>
</tr>	
	<td>Average Row Length:</td>  
	<td><INPUT name=rowLen size=3 value=500></td>
</tr>	
	<td>Columns with 250 bytes or less:</td>  
	<td><INPUT name=b250 size=5 value=10></td>
</tr>	
	<td>olumns with more than 250 bytes:</td>  
	<td><INPUT name=b251 size=5 value=2></td>
</tr>
<tr>
	<td></td><td><input type="submit" value="Calculate" /></td>
</tr>
</table>

<A target=basefrm href="/orb/jsp/oracle/space/Space.jsp?">Back</A>

</body>
</html>
