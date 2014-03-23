<%@ page isErrorPage="false" errorPage="errorHandler.jsp" %>

<html>
<head>
<body onLoad="document.loginForm.username.focus()">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<% 
   String product_name = "";

   if (getServletContext().getInitParameter ("product_name") != null)
	product_name = getServletContext().getInitParameter ("product_name");

   String servlet_name = request.getRequestURI ();

   String application_name = servlet_name.substring (0,servlet_name.substring(1).indexOf ("/")+1);	

   if (request.getAttribute ("page") != null)
   {
	String redirect_page = (String)request.getAttribute("page");
	out.println("<meta http-equiv=\"refresh\" content=\"5;url="+redirect_page+"\">");
   }
%>
<title>CDRS Header Page</title>
<table cellpadding=0 cellspacing=0 border=0 width=75%>
<tr>
<td valign="top" ><img src="<%=application_name%>/images/dnas.gif" ></td>
<td align=center valign="bottom" ><h1><%=product_name%></h1></td>
</tr>
</table>
</head>

<table bgcolor="#ffffff" cellpadding=0 cellspacing=0 border=0 width=100% height=80%>

<form name="loginForm" method="post" action="<%=application_name%>/servlet/Login
<%  if (request.getParameter("page")!=null)
	out.print("?page="+request.getParameter("page"));
%>">

<tr>
<td valign=top width=66>	
</td>

<td bgcolor="#ffffff">

<table align=center border="0">
	<tr>
            <th align="right">Login name:</th>
            <td><input type="text" size="20" name="username"></td>
	    <td>&nbsp;</td>        
	</tr>
        <tr>
            <th align="right">Password:</th>
            <td><input type="password" size="20" name="password"></td>
	    <td>&nbsp;</td>
        </tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr>
	    <td>&nbsp;</td>
       
            <td align=right><input type="submit" value="Login"></td>
        </tr>
</table>
</form>
</td>
<td>
&nbsp
</td>
</tr>
<tr>
<td>
&nbsp
</td>
</tr>

</table>
</form>

<jsp:include page="footer.jsp" />