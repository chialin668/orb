<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Result:</h3>
<!--
ACCEPT v_blksize PROMPT 'Enter the Oracle Block Size: '
ACCEPT v_rows PROMPT 'Enter the number of Rows: '
ACCEPT v_pctf PROMPT 'Enter Percent Free:          '
ACCEPT v_initr PROMPT 'Enter Init Trans:            '
ACCEPT v_avg PROMPT 'Enter Average Row Length:    '
ACCEPT v_250c PROMPT 'Enter number of columns with 250 bytes or less:   '
ACCEPT v_251c PROMPT 'Enter number of columns with more than 250 bytes: '

//SELECT
// CEIL ( (v_rows)/
// FLOOR ((v_blksize-(v_initr * 24)-57-4)*(1-(v_pctf/100)) /
//       (v_avg+2+3+v_250c+(3 * v_251c))) ) BLOCKS
//FROM dual

-->

<%
	float header = 48;  // bytes
	String bs = request.getParameter("blockSize");

	if (bs != null) {
		float blockSize = Float.parseFloat(bs)-header;
		float rows = Float.parseFloat(request.getParameter("rows"));
		float pctFree = Float.parseFloat(request.getParameter("pctFree"));
		float initTran = Float.parseFloat(request.getParameter("initTran"));
		float rowLen = Float.parseFloat(request.getParameter("rowLen"));
		float b250 = Float.parseFloat(request.getParameter("b250"));
		float b251 = Float.parseFloat(request.getParameter("b251"));


/*
	out.println(blockSize + "<br>");
	out.println(rows + "<br>");
	out.println(pctFree + "<br>");
	out.println(initTran + "<br>");
	out.println(rowLen + "<br>");
	out.println(b250 + "<br>");
	out.println(b251 + "<br>");
*/
 		float blocks = ( (rows)/((blockSize-(initTran * 24)-57-4)*(1-(pctFree/100)) /
	    				   (rowLen+2+3+b250+(3 * b251))) );
		out.println("You need: <b>" + (int)blocks + "</b> blocks <br>");
		float mByte = blocks*blockSize/1024/1024;
		out.println("You need: <b>" + mByte + "</b> M bytes <br>");
	}
%>



</body>
</html>
