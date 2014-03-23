</TD></TR>
</TABLE>
<table width=100% border=0 cellpadding=0 cellspacing=0 bgcolor=#3366cc>
<tr>
<td valign=bottom align=left bgcolor=#ffffff nowrap><font size=-3>
<%	
out.print(getServletContext().getAttribute("product_name")+"&nbsp;&nbsp;&nbsp;");
out.print(getServletContext().getAttribute("product_version"));
%>
<i> Last modified:</i> <last:lastModified/> 
</td></tr>
</table>
</body>
</html>