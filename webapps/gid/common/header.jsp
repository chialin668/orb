<html>
<head> 
<META HTTP-EQUIV="expires" CONTENT="0">
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<% if (request.getAttribute ("page") != null)
   {
	String redirect_page = (String)request.getAttribute("page");
	out.println("<meta http-equiv=\"refresh\" content=\"5;url="+redirect_page+"\">");
   }
   request.setAttribute ("show_header","true");


   String servlet_name = request.getRequestURI ();

   String application_name = servlet_name.substring (0,servlet_name.substring(1).indexOf ("/")+1);

   // we need to strip off the application name from the front.  Eg. /gid so that
   // we are application independent when performing security.  This allows us to install
   // this application under any context we choose.
   String jsp_name = servlet_name.substring (servlet_name.substring(1).indexOf ("/")+1);

%>
<title>CDRS Header Page</title>
<table cellpadding=0 cellspacing=0 border=0 width=75%>
<tr>
<td valign="top" ><img src="<%=application_name%>/images/dnas.gif" ></td>
<% String product_name = "";
	if (getServletContext().getInitParameter ("product_name") != null)
		product_name = getServletContext().getInitParameter ("product_name");
%>
<td align=center valign="bottom" ><h1><%= product_name %></h1></td>
</tr>
</table>
</head>
<BODY onLoad="setFocus()">
<script language=javascript>

	function setFocus ()
	{
	}
</script>
<%@ taglib uri="/common/lastmodtaglib.tld" prefix="last" %> 
<%@ page isErrorPage="false" errorPage="/common/errorHandler.jsp" %>
<%@ page language="Java" import="com.dnas.lqt.data.*,com.dnas.lqt.security.* " %>
<%
	// if we don't have an active USER object then redirect to login page.
	if (request.getSession().getAttribute ("USER") == null)
	{
	%> <jsp:forward page="/common/login.jsp" /> <%
	}
%>
<jsp:useBean id="MENU_INFO" scope="application" class="com.dnas.lqt.data.Menu" />
<jsp:useBean id="USER" scope="session" class="com.dnas.lqt.data.User" />

<%
   // we can't instantiate this one through the jsp:useBean tag because we
   // don't know the explicit class required at compile time of the JSP, only at run-time
   DataAccess DATA_ACCESS_LAYER = (DataAccess)request.getSession().getAttribute ("DATA_ACCESS_LAYER");

   // if we aren't allowed access to this page then throw an exception
   if (!SecurityContext.isAllowedAccess (USER, jsp_name))
	throw new Exception (jsp_name+" : Access DENIED!");
%>


<table cellpadding=0 cellspacing=0 valign=top>
<tr>

<%
	//System.err.println ("User: " + USER.getUsername() + " accessing " + servlet_name);
	// first lets print the main menu
	MenuItem [] menuItems = MENU_INFO.getMenuItems ("/common/index.jsp");
	String section = "";

	if (request.getParameter ("section") != null)
		section = request.getParameter ("section");

	String sub_section = "";

	if (request.getParameter ("sub_section") != null)
		sub_section = request.getParameter ("sub_section");

	if (menuItems != null)
	{
		for (int i=0;i<menuItems.length;i++)
		{
			String action = menuItems[i].getAction().trim();
			String description = menuItems[i].getDescription().trim();
			String descriptor = menuItems[i].getDescriptor().trim();
			// if we are allowed access for our User role then link it.
			if (SecurityContext.isAllowedAccess (USER, action))
			{ 

				if (descriptor.equals (section))
				{
					out.println("<td height=30 bgcolor=#659ace width=120 nowrap><center><font size=-1 color=#ffffff>&nbsp;<b>"+description+"</b>&nbsp;</font></center></td>");

				}
				else
				{
					out.println("<td height=30 bgcolor=#3366cc width=120 nowrap><center><font size=-1><a STYLE='color:#FFFFFF' href='"+application_name+action+"'>&nbsp;"+description+"&nbsp;</a></font></center></td>");
				}
				out.println("<td height=30 width=1 bgcolor=#ffffff><img width=1 height=1 alt=''></td>");

			} 
			// else just show it
			else
			{ 
				out.println("<td height=30 bgcolor=#3366cc width=120 nowrap><center><font color=#ffffff size=-1>&nbsp;"+description+"&nbsp;</font></center></td>");
				out.println("<td height=30 width=1 bgcolor=#ffffff><img width=1 height=1 alt=''></td>");
			} 
		}
		// now put in our logout
		
		out.println("<td height=30 style=cursor:pointer;cursor:hand; bgcolor=#3366cc width=120 nowrap><center><font size=-1><a STYLE='color:#FFFFFF' href=\"javascript:if(confirm('OK to logout?')) location='"+application_name+"/servlet/Login?logout=true'\">&nbsp;Logout&nbsp;</a></font></center></td>");
		out.println("<td height=30 align=left bgcolor=#3366cc width=100% nowrap><font size=-1>&nbsp;</font></td>");
		out.println("</TR><TR>");

		for (int i=0;i<menuItems.length;i++)
		{
			String action = menuItems[i].getAction().trim();
			String description = menuItems[i].getDescription().trim();
			String descriptor = menuItems[i].getDescriptor().trim();
			// if we are allowed access for our User role then link it.
			if (SecurityContext.isAllowedAccess (USER, action))
			{ 

				if (descriptor.equals (section))
				{
					out.println("<td height=1 bgcolor=#659ace width=120></td>");
				}
				else
				{
					out.println("<td height=1 bgcolor=#ffffff width=120></td>");
				}
				out.println("<td height=1 width=1 bgcolor=#ffffff></td>");

			} 
			// else just show it
			else
			{ 
				out.println("<td height=1 bgcolor=#ffffff width=120></td>");
				out.println("<td height=1 width=1 bgcolor=#ffffff></td>");
			} 
		}
		out.println("<td height=1 width=100% bgcolor=#ffffff></td>");

	}
	

%>
</TR>
</TABLE>
<TABLE width=100% cellpadding=0 cellspacing=0 valign=top>
	<TR>
	<td height=5 align=left bgcolor=#659ace width=100%></td>
	</TR>
</TABLE>
	<%
	// if we are on the index page then don't drop any side menu
	if (!jsp_name.equals("/common/index.jsp"))
	{
		// now lets print the menu items for this screen
		menuItems = MENU_INFO.getMenuItems (jsp_name);

		if (menuItems != null)
		{
			out.println("<TABLE width=100% cellpadding=0 cellspacing=0 valign=top>");
			out.println ("<TR>");
			for (int i=0;i<menuItems.length;i++)
			{
				String menuitem_action = menuItems[i].getAction().trim();
				String menuitem_descriptor = menuItems[i].getDescriptor ().trim();
				String menuitem_description = menuItems[i].getDescription().trim();
				// if we are allowed access for our User role then link it.
				if (SecurityContext.isAllowedAccess (USER, menuitem_action))
				{
					// only link if we are not currently on this selection
					// else just display it
					if (!sub_section.equals (menuitem_descriptor))
					{
						out.println("<td align=left valign=bottom width=120 height=1 border=0 bgcolor=#659ace><img bgcolor=#000000 height=1 width=120 src="+application_name+"/images/spacer.bmp></img></td>");
					}
					else
					{
						out.println("<td align=left valign=bottom width=120 height=1 border=0 bgcolor=#000000><img bgcolor=#000000 height=1 width=120 src="+application_name+"/images/spacer.bmp></img></td>");
					}
					
				}
			}
			out.println("<td valign=bottom height=1 width=100% border=0 bgcolor=#659ace></td>");
			out.println("</TR></TABLE>");

			out.println("<TABLE cellpadding=0 cellspacing=0 valign=top>");
			out.println ("<TR>");

			boolean first_item = true;
			for (int i=0;i<menuItems.length;i++)
			{
				String menuitem_action = menuItems[i].getAction().trim();
				String menuitem_descriptor = menuItems[i].getDescriptor ().trim();
				String menuitem_description = menuItems[i].getDescription().trim();
				// if we are allowed access for our User role then link it.
				if (SecurityContext.isAllowedAccess (USER, menuitem_action))
				{
					// only link if we are not currently on this selection
					// else just display it
					if (sub_section.equals (menuitem_descriptor))
					{
						if (!first_item)
							out.println("<td valign=bottom width=1 height=30 border=0 bgcolor=#000000><img bgcolor=#000000 height=30 width=1 src="+application_name+"/images/spacer.bmp></img></td>");
						out.println("<td valign=bottom width=120 height=30 border=0 align=center bgcolor=#ffffff nowrap><font color=#000000 size=-1>&nbsp;"+menuitem_description+"&nbsp;</font></td>");
						out.println("<td valign=bottom width=1 height=30 border=0 bgcolor=#000000><img bgcolor=#000000 height=30 width=1 src="+application_name+"/images/spacer.bmp></img></td>");
					}
					else
					{
						out.println("<td valign=bottom width=120 height=30 border=0 align=center style=cursor:pointer;cursor:hand; bgcolor=#659ace nowrap><font size=-1><a STYLE='color:#ffffff'href='"+application_name+menuitem_action+"'>&nbsp;"+menuitem_description+"&nbsp;</a></font></td>");
					}
					first_item = false;
					
				}
			}
			out.println("<td valign=bottom width=100% height=30 border=0 bgcolor=#659ace></td>");
			out.println ("</TR><TABLE>");


			out.println("<TABLE cellpadding=0 cellspacing=0 valign=top>");
			out.println ("<TR>");
			for (int i=0;i<menuItems.length;i++)
			{
				String menuitem_action = menuItems[i].getAction().trim();
				String menuitem_descriptor = menuItems[i].getDescriptor ().trim();
				String menuitem_description = menuItems[i].getDescription().trim();
				// if we are allowed access for our User role then link it.
				if (SecurityContext.isAllowedAccess (USER, menuitem_action))
				{
					// only link if we are not currently on this selection
					// else just display it
					if (!sub_section.equals (menuitem_descriptor))
					{
						out.println("<td valign=bottom width=120 height=1 border=0 bgcolor=#000000><img bgcolor=#000000 height=1 width=120 src="+application_name+"/images/spacer.bmp></img></td>");
						out.println("<td valign=bottom width=1 height=1 border=0 bgcolor=#000000><img bgcolor=#000000 height=1 width=1 src="+application_name+"/images/spacer.bmp></img></td>");
					}
					else
					{
						out.println("<td valign=bottom width=120 height=1 border=0 bgcolor=#ffffff><img bgcolor=#000000 height=1 width=120 src="+application_name+"/images/spacer.bmp></img></td>");
					}
					
				}
	
			}
				out.println("<td valign=bottom width=100% height=1 border=0 bgcolor=#000000></td>");
			out.println("</TR></TABLE>");
		}


	}
%>
<TABLE height=60% valign=top>
<TR valign=top><TD valign=top>
<PRE>


</PRE>