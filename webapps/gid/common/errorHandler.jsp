<%@ page isErrorPage="true" import="java.io.*" %>
<html>
<head>
<% 
	String servlet_name = request.getRequestURI ();

   	String application_name = servlet_name.substring (0,servlet_name.substring(1).indexOf ("/")+1);	
	
	if (request.getAttribute ("header")==null)
{
%>
	<table cellpadding=0 cellspacing=0 border=0 width=75%>
	<tr>
	<td valign="top" ><img src="<%=application_name%>/images/dnas.gif" ></td>
	<td align=center valign="bottom" ><h1>CDRS</h1></td>
	</tr>
	</table>
<%
}
%>

	<title>Exceptional Even Occurred!</title>
	<style>
	body, p { font-family:Tahoma; font-size:10pt; padding-left:30; }
	pre { font-size:8pt; }
	</style>
</head>
<body>

<table valign=center align=center height=75% width=100%>
<tr>
<td>
<%-- Exception Handler --%>
<font color="red">
<% try { out.print (exception.toString()); } catch (Exception e) {} %><br>
</font>

<%
try
{
	out.println("<!--");
	StringWriter sw = new StringWriter();
	PrintWriter pw = new PrintWriter(sw);
	exception.printStackTrace(pw);
	out.print(sw);
	sw.close();
	pw.close();
	out.println("-->");
} catch (Exception e) {}
%>
</td>
</tr>
<TR>
<TD>
<FORM ACTION='<%=application_name%>/common/index.jsp'>
	<INPUT TYPE='SUBMIT' VALUE='Continue'>
</FORM>
</TD>
</TR>
</table>



<jsp:include page="footer.jsp" flush="true"/>