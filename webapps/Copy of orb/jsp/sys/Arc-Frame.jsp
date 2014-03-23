<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%
	String machine = request.getParameter("machine");
	String sqlTag = request.getParameter("sqlTag");	
	String urlParams = "machine=" + machine
						+ "&sqlTag=" + sqlTag;
%>
	
<html>
<head>
<!-- frames -->
<frameset  rows="50%,50%,*">
    <frame name="Arc-VML" 
			src="Arc-VML.jsp?<%=urlParams%>" 
			marginwidth="10" 
			marginheight="10" 
			scrolling="no" 
			frameborder="1">
    <frame name="Arc-NewData" 
			src="Arc-NewData.jsp?<%=urlParams%>" 
			marginwidth="10" 
			marginheight="10" 
			scrolling="auto" 
			frameborder="1">
</frameset>
</head>

<body>
	
</body>
</html>
