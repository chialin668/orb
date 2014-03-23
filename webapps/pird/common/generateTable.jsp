<!--- Generates a table from a given table object t ---!>
<!--- This file MUST be hard-included in a page which previously included header.jsp ---!>

<%-- 	Generates a table from a given table object table which must already exist
  	This file MUST be hard-included in a page which previously included header.jsp

--%>

<%

	out.println ("<b>"+table.getDescription()+"</b>");
	HTMLTableColumn [] c = table.getColumns();


	out.print("<table align=center border=1>");

	out.print("<tr><td width=70>&nbsp;</td>");

	for (int i=0;i<c.length;i++)
	{
		out.print ("<td width="+c[i].getWidth()+">");

		if (c[i].getAction() != null && c[i].getAction().length() > 0 && c[i].isSortable())
		{
			String name = c[i].getName();
			String sort = "";
			if (i == table.getSortIndex())
			{
				if (table.isAscendSort ())
					sort = "&gt;&gt;\n";
				else
					sort = "&lt;&lt;\n";
			}
			out.print (sort+"<a href=\""+c[i].getAction()+"&version="+(int)(Math.random()*100)+"\">"+name+"</a>");
                }
               	else
                	out.print (c[i].getName());
                out.print("</td>");
	}

	out.print("</tr>");

	boolean alternating = true;

	int j=0;
	Enumeration e = table.elements();
	while (e.hasMoreElements())
	{
		HTMLTableRow htr = (HTMLTableRow)e.nextElement();

		if (alternating)
			out.print ("<tr>");
		else
			out.print ("<tr bgcolor=#cccccc>");

		alternating = !alternating;

		out.print("<td width=70>");

		if (htr.getAction() != null && htr.getAction().length()>0)
			out.print("<a href='"+htr.getAction()+"'><img border=0 src='"+application_name+"/images/edit.gif'></a>");
		else
			out.print ("&nbsp;");
		out.print ("</td>");

		for (int i=0;i<htr.getLength();i++)
		{
			if (htr.toString(i).length() == 0)
				out.print ("<td width="+c[i].getWidth()+">&nbsp;</td>");
			else
				out.print("<td width="+c[i].getWidth()+">"+htr.toString(i)+"</td>");
		}

		out.print("</tr>");
	}
	out.print("</table>");
%>