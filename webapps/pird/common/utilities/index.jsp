<%@ include file="../header.jsp" %>
<%@ page import="java.util.*, com.dnas.lqt.html.*, com.dnas.lqt.security.*" %>

<%
	String command = "";

	if (request.getParameter ("command") != null)
		command = request.getParameter ("command");

	if (command.equals ("new"))
	{
		String sub_command = "";
		if (request.getParameter ("sub_command") != null)
			sub_command = request.getParameter ("sub_command");

		if (sub_command.equals ("getinfo"))
		{
			%>
			<script language=javascript src="../../common/util.js"></script>
			<script language=javascript>

			

			function setFocus ()
			{
				document.add_user.username.focus()
			}

			function validateForm ()
      			{

				error = false
				error_string = ""

				if (trimAll(document.add_user.firstname.value).length == 0)
				{
					error_string = error_string + 'First Name is a required field\n'
					error = true
				}
				if (trimAll(document.add_user.lastname.value).length == 0)
				{
					error_string = error_string + 'Last Name is a required field\n'
					error = true
				}
				if (trimAll(document.add_user.username.value).length == 0)
				{
					error_string = error_string + 'Username is a required field\n'
					error = true
				}
				if (trimAll(document.add_user.password.value).length < 8)
				{
					error_string = error_string + 'Password is a required field and must be atleast 8 characters long\n'
					error = true
				}

				if (error)
				{
					alert (error_string)
					return false
				}	

				document.add_user.submit()
				return true
   			}
			</script>
			<%

			Role [] roles = DATA_ACCESS_LAYER.getRoles();
			out.print ("<FORM NAME=add_user ACTION='"+application_name+"/common/utilities/index.jsp' METHOD='POST'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=utilities>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=add_user>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=new>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=add>");
			out.print ("<TABLE valign=center align=center>");
			out.print ("<TR><TD><B>User Name</B></TD><TD><B>First Name</B></TD><TD><B>Last Name</B></TD><TD><B>Password</B></TD><TD><B>Role</B></TD><TD><B>Status</B></TD></TR>");
			out.print ("<TR><TD><INPUT TYPE=TEXT SIZE=16 MAXLENTGH=16 NAME=username></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=firstname></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=lastname></TD><TD><INPUT SIZE=32 MAXLENGTH=32 TYPE=PASSWORD NAME=password></TD><TD>"+HTMLOutput.HTMLFormatRoles(roles,roles.length-1)+"</TD><TD>"+HTMLOutput.HTMLFormatStatus("")+"</TD></TR>");
			out.print ("<TR><TD span=5>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=5>&nbsp;</TD></TR>");
			out.print ("<TR><TD>");
			out.print ("<INPUT TYPE=BUTTON onClick=\"validateForm()\" VALUE='Add User'>");
			out.print ("</TD><TD&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}
		else if (sub_command.equals ("add"))
		{
			String firstname = request.getParameter ("firstname").trim();
			String lastname = request.getParameter ("lastname").trim();
			String username = request.getParameter ("username").trim();
			String password = request.getParameter ("password").trim();
			String status = request.getParameter ("status");
			String role_wid = request.getParameter ("role_wid");

			User u = new User();
            		u.setFirstname(firstname);
            		u.setLastname(lastname);
            		u.setUsername(username);
            		u.setPassword(Encryption.encryptPassword(password));
            		u.setStatus(status);

			// now find out what role this is and pass it to our new user object
			Role [] roles = DATA_ACCESS_LAYER.getRoles ();

			for (int i=0;i<roles.length;i++)
			{
				if (roles[i].getRole_wid().equals (role_wid))
					u.setRole (roles[i]);
			}

			DATA_ACCESS_LAYER.addUser (u);
			out.print ("<FORM ACTION='"+application_name+"/common/utilities/index.jsp' METHOD='POST'>");
			out.print ("<TABLE valign=center align=center >");
			out.print("<TR><TD>User Succesfully Added!</TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("<TR><TD><INPUT TYPE=SUBMIT VALUE='Continue'></TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}

	}

	else if (command.equals("modify"))
	{

		String sub_command = "";
		if (request.getParameter ("sub_command") != null)
			sub_command = request.getParameter ("sub_command");

		if (sub_command.equals ("getuser"))
		{
			if (request.getSession().getAttribute("USER_HTML_TABLE") == null || DATA_ACCESS_LAYER.isUserDataDirty())
			{
				// get a list of our users
				User [] users = DATA_ACCESS_LAYER.getUsers ();

				// create an html table with all column descipriptors
      				HTMLTable table = new HTMLTable ();
      				HTMLTableColumn [] columns = {
        				new HTMLTableColumn ("User Name",""+application_name+"/common/utilities/index.jsp?section=utilities&sub_section=modify_user&command=modify&sub_command=getuser&sort_index=0",true,true,100,String.class, new int[] {0}),
        				new HTMLTableColumn ("First Name",""+application_name+"/common/utilities/index.jsp?section=utilities&sub_section=modify_user&command=modify&sub_command=getuser&sort_index=1",true,true,100,String.class,new int[] {1}),
        				new HTMLTableColumn ("Last Name",""+application_name+"/common/utilities/index.jsp?section=utilities&sub_section=modify_user&command=modify&sub_command=getuser&sort_index=2",true,true,100,String.class,new int[] {2}),
        				new HTMLTableColumn ("Role",""+application_name+"/common/utilities/index.jsp?section=utilities&sub_section=modify_user&command=modify&sub_command=getuser&sort_index=3",true,true,70,String.class,new int[] {3}),
        				new HTMLTableColumn ("Status",""+application_name+"/common/utilities/index.jsp?section=utilities&sub_section=modify_user&command=modify&sub_command=getuser&sort_index=4",true,true,70,String.class,new int[] {4}),
      				};
      				table.setColumns(columns,"Current Users");
  
				// now create all our row objects
				for (int i=0;users!=null&&i<users.length;i++)
				{
					String action = ""+application_name+"/common/utilities/index.jsp?section=utilities&sub_section=modify_user&command=modify&sub_command=getinfo&user_wid="+users[i].getUserwid();
						table.addRow (new HTMLTableRow ( new Object [] {
						users[i].getUsername(),
						users[i].getFirstname(),
						users[i].getLastname(),
						users[i].getRole().getRole_name(),
						users[i].getStatus()

					},action));
				}
				request.getSession().setAttribute ("USER_HTML_TABLE",table);
				DATA_ACCESS_LAYER.setUserDataDirty (false);
			}
			HTMLTable table = (HTMLTable)request.getSession().getAttribute ("USER_HTML_TABLE");

			// make sure to sort the table if need be
			if (request.getParameter ("sort_index") != null)
			{
				int index = Integer.parseInt (request.getParameter("sort_index"));
				table.sort (index);
			}

			%>
			<%@ include file="/common/generateTable.jsp" %>
 
			<%
		}
		else if (sub_command.equals ("getinfo"))
		{

			%>
			<script language=javascript src="../../common/util.js"></script>
			<script language=javascript>

			

			function setFocus ()
			{
				document.modify_user.username.focus()
			}

			function validateForm ()
      			{

				error = false
				error_string = ""

				if (trimAll(document.modify_user.firstname.value).length == 0)
				{
					error_string = error_string + 'First Name is a required field\n'
					error = true
				}
				if (trimAll(document.modify_user.lastname.value).length == 0)
				{
					error_string = error_string + 'Last Name is a required field\n'
					error = true
				}
				if (trimAll(document.modify_user.username.value).length == 0)
				{
					error_string = error_string + 'Username is a required field\n'
					error = true
				}
				if (trimAll(document.modify_user.password.value).length < 8)
				{
					error_string = error_string + 'Password is a required field and must be atleast 8 characters long\n'
					error = true
				}

				if (error)
				{
					alert (error_string)
					return false
				}	

				document.modify_user.submit()
				return true
   			}
			</script>

			<%


			String user_wid = "";
			if (request.getParameter ("user_wid") != null)
				user_wid = request.getParameter ("user_wid");

			out.print ("<FORM NAME=modify_user ACTION='"+application_name+"/common/utilities/index.jsp?' METHOD='POST'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=utilities>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=modify_user>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=update>");
			out.print ("<INPUT TYPE=HIDDEN NAME=user_wid VALUE='"+user_wid+"'>");
			Role [] roles = DATA_ACCESS_LAYER.getRoles();
			User u = DATA_ACCESS_LAYER.getUser (user_wid);

			Role role = u.getRole ();
			out.print ("<INPUT TYPE=HIDDEN NAME=version_nbr VALUE='"+u.getVersion_nbr()+"'>");
			out.print ("<TABLE valign=center align=center>");
			out.print ("<TR><TD><B>User Name</B></TD><TD><B>First Name</B></TD><TD><B>Last Name</B></TD><TD><B>Password</B></TD><TD><B>Role</B></TD><TD><B>Status</B></TD></TR>");
			out.print ("<TR><TD><INPUT SIZE=16 MAXLENGTH=16 TYPE=TEXT NAME=username VALUE='"+u.getUsername()+"'></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=firstname VALUE='"+u.getFirstname()+"'></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=lastname VALUE='"+u.getLastname()+"'></TD><TD><INPUT SIZE=32 MAXLENGTH=32 TYPE=PASSWORD NAME=password VALUE='change_me'></TD><TD>"+HTMLOutput.HTMLFormatRoles(roles,role)+"</TD><TD>"+HTMLOutput.HTMLFormatStatus(u.getStatus())+"</TD></TR>");
			out.print ("<TR><TD span=5>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=5>&nbsp;</TD></TR>");
			out.print ("<TR><TD>");
			out.print ("<INPUT TYPE=BUTTON onClick=\"validateForm()\" VALUE='Modify User'>");
			out.print ("</TD><TD&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}
		else if (sub_command.equals ("update"))
		{

			String version_nbr = request.getParameter ("version_nbr");
			String user_wid = request.getParameter ("user_wid");
			String firstname = request.getParameter ("firstname").trim();
			String lastname = request.getParameter ("lastname").trim();
			String username = request.getParameter ("username").trim();
			String password = request.getParameter ("password").trim();
			String status = request.getParameter ("status");
			String role_wid = request.getParameter ("role_wid");

			// now find out what role this is and pass it to our new user object
			Role [] roles = DATA_ACCESS_LAYER.getRoles ();

			// need to get our user incase we don't need to change the password
			User u = DATA_ACCESS_LAYER.getUser (user_wid);
			u.setVersion_nbr (version_nbr);
            		u.setUserwid(user_wid);
            		u.setFirstname(firstname);
            		u.setLastname(lastname);
            		u.setUsername(username);
			
			// We have not way of decrypting passwords, we can only encrypt them.
			// So as a work around we default the password field to 'change_me'
			// and it it hasn't changed then don't change the password in our
			// USER object.
			if (!password.equals ("change_me"))
            			u.setPassword(Encryption.encryptPassword(password));
            		u.setStatus(status);

			for (int i=0;i<roles.length;i++)
			{
				if (roles[i].getRole_wid().equals (role_wid))
					u.setRole(roles[i]);
			}


			DATA_ACCESS_LAYER.updateUser (u);
			out.print ("<FORM ACTION='"+application_name+"/common/utilities/index.jsp' METHOD='POST'>");
			out.print ("<TABLE valign=center align=center >");
			out.print("<TR><TD>Updated User Succesfully!</TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("<TR><TD><INPUT TYPE=SUBMIT VALUE='Continue'></TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}
	}

	if (command.equals("change_password"))
	{
		String password = "";
		String old_password = "";
		if (request.getParameter ("new_password") != null)
			password = request.getParameter ("new_password").trim();

		if (request.getParameter ("old_password") != null)
			old_password = request.getParameter ("old_password").trim();

		if (password.equals (""))
		{

		%>
			<script language='javascript'>

				function setFocus ()
				{
					document.change_password.old_password.focus()
				}

				function changePassword ()
      				{
					if (document.change_password.new_password.value != document.change_password.password_confirm.value)
					{
						alert ('The passwords you typed do not match.  Type the new password in both text boxes.')
						return false;		
					}
					if (document.change_password.new_password.value.length < 8)
					{
						alert ('New password must be atleast 8 characters long')
						return false;
					}

					document.change_password.submit()
					return true
      				}
			</script>
		<%

			out.print ("<FORM NAME=change_password ACTION='"+application_name+"/common/utilities/index.jsp?command=change_password' METHOD='POST'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=utilities>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=change_password>");

			out.print ("<TABLE valign=center align=center>");
			out.print ("<TR><TD><B>Old Password:</B></TD><TD><INPUT TYPE=PASSWORD NAME='old_password' SIZE=32></TD></TR>");
			out.print ("<TR><TD><B>New Password:</B></TD><TD><INPUT TYPE=PASSWORD NAME='new_password' SIZE=32></TD></TR>");
			out.print ("<TR><TD><B>Confirm New Password:</B></TD><TD><INPUT TYPE=PASSWORD NAME='password_confirm' SIZE=32></TD></TR>");
			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD align=left><INPUT TYPE=BUTTON onClick='javascript:changePassword()' VALUE='Change Password'></TD><TD>&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}
		else
		{
			if (!Encryption.encryptPassword(old_password).equals (USER.getPassword()))
			{
				out.print ("<FORM ACTION='"+application_name+"/common/utilities/index.jsp' METHOD='POST'>");
				out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=utilities>");
				out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=change_password>");
				out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=change_password>");

				out.print ("<TABLE valign=center align=center >");
				out.print("<TR><TD>Old Password was incorrect!</TD></TR>");
				out.print ("<TR><TD>&nbsp;</TD></TR>");
				out.print ("<TR><TD><INPUT TYPE=SUBMIT VALUE='Continue'></TD></TR>");
				out.print ("<TR><TD>&nbsp;</TD></TR>");
				out.print ("</TABLE>");
				out.print ("</FORM>");
			}
			else
			{
				USER.setPassword (Encryption.encryptPassword(password));
				DATA_ACCESS_LAYER.updateUser (USER);
				out.print ("<FORM ACTION='"+application_name+"/common/utilities/index.jsp' METHOD='POST'>");
				out.print ("<TABLE valign=center align=center >");
				out.print("<TR><TD>Password updated Succesfully!</TD></TR>");
				out.print ("<TR><TD>&nbsp;</TD></TR>");
				out.print ("<TR><TD><INPUT TYPE=SUBMIT VALUE='Continue'></TD></TR>");
				out.print ("<TR><TD>&nbsp;</TD></TR>");
				out.print ("</TABLE>");
				out.print ("</FORM>");
			}
		}
	}

	

%>
<%@ include file="../footer.jsp" %>