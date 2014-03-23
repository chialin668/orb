<%@ include file="header.jsp" %>

<table align=center border="0" height=75% width=100%>
	<tr>
	<td align=center>
	<%
		String message = "";
		try
		{
		   message = (String)request.getAttribute ("message");
                } catch (Exception e) {}
		out.print ("<HTML><B>"+message+"</B></HTML>");
	%>
	</td>
	</tr>
</table>

<jsp:include page="footer.jsp" />