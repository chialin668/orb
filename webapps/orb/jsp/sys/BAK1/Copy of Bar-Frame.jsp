<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%
	String machine = request.getParameter("machine");
%>
	
<html>
<head>
<!-- frames -->
<frameset  rows="33%,33%,*">
    <frame name="Bar-VML" 
			src="Bar-VML.jsp" 
			marginwidth="10" 
			marginheight="10" 
			scrolling="no" 
			frameborder="1">
    <frame name="Bar-NewData" 
			src="Bar-NewData.jsp?machine=<%=machine%>" 
			marginwidth="10" 
			marginheight="10" 
			scrolling="auto" 
			frameborder="1">
</frameset>
</head>

<body>
	
</body>
</html>
