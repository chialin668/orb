<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%
	String machine = request.getParameter("machine");
	String sqlTag = request.getParameter("sqlTag");	
	String chartType = request.getParameter("chartType");
	String columnNo = request.getParameter("columnNo");	
	String urlParams = "machine=" + machine
						+ "&sqlTag=" + sqlTag
						+ "&chartType=" + chartType
						+ "&columnNo=" + columnNo;
%>
	
<html>
<head>
<!-- frames -->
<frameset  width=800 height=500 rows="50%,50%,*">
    <frame name="Graph-VML" 
			src="Graph-VML.jsp?<%=urlParams%>" 
			marginwidth="10" 
			marginheight="10" 
			scrolling="no" 
			frameborder="1">
    <frame name="Graph-NewData" 
			src="Graph-NewData.jsp?<%=urlParams%>" 			
			marginwidth="10" 
			marginheight="10" 
			scrolling="auto" 
			frameborder="1">
</frameset>
</head>

<body>
	
</body>
</html>
