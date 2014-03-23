<%@ include file="../common/header.jsp" %>
<%@ page import="java.util.*, com.dnas.lqt.html.*, com.dnas.lqt.data.patient.*" %>

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
				out.print ("<FORM NAME=patient ACTION='"+application_name+"/patient/index.jsp' METHOD='POST'>");

			%>
			<script language=javascript src="../common/util.js"></script>
			<script language=javascript>

			function setFocus ()
			{
				document.patient.patient_id.focus()
			}
			</script>


			<%
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=patient>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=add_patient>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=new>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=add>");
			out.print ("<TABLE valign=center align=center>");
			out.print ("<TR><TD><B>Test Type:</B></TD><TD>"+HTMLOutput.HTMLFormatTestType ("D")+"</TD></TR>");
			out.print ("<TR><TD><B>Accession Number:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=patient_id></TD></TR>");
			out.print ("<TR><TD><B>First Name:</B></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=first_name></TD></TR>");
			out.print ("<TR><TD><B>Last Name:</B></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=last_name></TD></TR>");
			out.print ("<TR><TD><B>SSN:</B></TD><TD><INPUT TYPE=TEXT SIZE=9 MAXLENGTH=9 NAME=ssn></TD></TR>");
			out.print ("<TR><TD><B>Age:</B></TD><TD>"+HTMLOutput.HTMLFormatAge("")+"</TD></TR>");
			out.print ("<TR><TD><B>Sex:</B></TD><TD>"+ HTMLOutput.HTMLFormatSex ("") + "</TD></TR>");
			out.print ("<TR><TD><B>Final Storage Tube:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=specimen></TD></TR>");
			out.print ("<TR><TD><B>Sample Draw Date (MM/DD/YYYY):</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=specimen_draw_date></TD></TR>");
			out.print ("<TR><TD><B>Sample Receive Date (MM/DD/YYYY):</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=specimen_receive_date></TD></TR>");
			out.print ("<TR><TD><B>Reporting Address:</B><TABLE><TR><TD><font size=-1>Address #1</font></TD></TR><TR><TD><font size=-1>Address #2</font></TD></TR><TR><TD><font size=-1>City State Zip</font></TD></TR></TABLE></TD><TD><TEXTAREA COLS=64 ROWS=3 NAME=reporting_address></TEXTAREA></TD></TR>");
			out.print ("<TR><TD><B>Billing Address:</B><TABLE><TR><TD><font size=-1>Address #1</font></TD></TR><TR><TD><font size=-1>Address #2</font></TD></TR><TR><TD><font size=-1>City State Zip</font></TD></TR></TABLE></TD><TD><TEXTAREA COLS=64 ROWS=3 NAME=billing_address></TEXTAREA></TD></TR>");
			out.print ("<TR><TD><B>Physician Name:</B></TD><TD><INPUT TYPE=TEXT SIZE=64 MAXLENGTH=64 NAME=physician_name></TD></TR>");
			out.print ("<TR><TD><B>Physician Institute:</B></TD><TD><TEXTAREA COLS=64 ROWS=4 NAME=physician_institute></TEXTAREA></TD></TR>");
			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=2><INPUT TYPE=BUTTON onClick='validateForm()' VALUE='Add Patient'></TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}
		else if (sub_command.equals ("add"))
		{
			String patient_id = request.getParameter ("patient_id").trim();
			String first_name = request.getParameter ("first_name").trim();
			String last_name = request.getParameter ("last_name").trim();
			String ssn = request.getParameter ("ssn").trim();
			String age = request.getParameter ("age").trim();
			String sex = request.getParameter ("sex").trim();
			String specimen = request.getParameter ("specimen").trim();
			String specimen_draw_date = request.getParameter ("specimen_draw_date").trim();			
			String specimen_receive_date = request.getParameter ("specimen_receive_date").trim();			
			String billing_address = request.getParameter ("billing_address");
			String reporting_address = request.getParameter ("reporting_address");
			String physician_name = request.getParameter ("physician_name").trim();
			String physician_institute = request.getParameter ("physician_institute").trim();

			Patient p = new Patient ();


			if (ssn != null)
				ssn = ssn.trim();

        		p.setPatient_id(patient_id);
        		p.setFirst_name(first_name);
        		p.setLast_name(last_name);
        		p.setSsn(ssn);
        		p.setAge(age);
        		p.setSex(sex);
			p.setSpecimen(specimen);
			p.setSpecimen_draw_date(specimen_draw_date);
			p.setSpecimen_receive_date(specimen_receive_date);
        		p.setReporting_address(reporting_address);
        		p.setBilling_address(billing_address);
        		p.setPhysician_name(physician_name);
        		p.setPhysician_institute(physician_institute);

			((PatientDataAccess)DATA_ACCESS_LAYER).addPatient (p,USER);				

			out.print ("<FORM ACTION='"+application_name+"/patient/index.jsp?section=patient&sub_section=add_patient&command=new&sub_command=getinfo' METHOD='POST'>");
			out.print ("<TABLE valign=center align=center >");
			out.print("<TR><TD>Patient Successfully Added!</TD></TR>");
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

		if (sub_command.equals ("getaccessionid"))
		{

			if (request.getSession().getAttribute("PATIENT_HTML_TABLE") == null || ((PatientDataAccess)DATA_ACCESS_LAYER).isPatientDataDirty())
			{
				// get a list of our patients
				Patient [] patients = ((PatientDataAccess)DATA_ACCESS_LAYER).getPatients ();
 
				// create an html table with all column descipriptors
      				HTMLTable table = new HTMLTable ();
      				HTMLTableColumn [] columns = {
					new HTMLTableColumn ("Accession Number",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=0",true,true,100,String.class, new int [] {0}),
					new HTMLTableColumn ("First Name",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=1",true,true,50,String.class, new int [] {1}),
					new HTMLTableColumn ("Last Name",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=2",true,true,100,String.class, new int [] {2}),
					new HTMLTableColumn ("SSN",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=3",false,true,70,String.class, null),
					new HTMLTableColumn ("Age",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=4",true,true,70,Integer.class, new int [] {4}),
					new HTMLTableColumn ("Sex",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=5",true,true,70,String.class, new int [] {5}),
					new HTMLTableColumn ("Final Storage Tube",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=6",false,true,10,String.class,null),
					new HTMLTableColumn ("Sample Draw Date",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=7",true,true,10,Date.class,new int [] {7}),
                                        new HTMLTableColumn ("Sample Receive Date",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=8",true,true,10,Date.class,new int [] {8}),
                                        new HTMLTableColumn ("Reporting Address",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=9",false,true,100,String.class,null),
					new HTMLTableColumn ("Billing Address",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=10",false,true,100,String.class,null),
					new HTMLTableColumn ("Physician Name",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=11",false,true,100,String.class,null),
					new HTMLTableColumn ("Physician Institute",""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getaccessionid&sort_index=12",false,true,100,String.class,null),
      				};
      				table.setColumns(columns,"Current Patients");


				// now create all our row objects
				for (int i=0;patients!=null&&i<patients.length;i++)
				{
					String action = ""+application_name+"/patient/index.jsp?section=patient&sub_section=modify_patient&command=modify&sub_command=getinfo&patient_wid="+patients[i].getPatient_wid();
						table.addRow (new HTMLTableRow ( new Object [] {
						patients[i].getPatient_id(),
						patients[i].getFirst_name(),
						patients[i].getLast_name(),
						patients[i].getSsn(),
						new Integer (patients[i].getAge()),
						patients[i].getSex(),
                                                patients[i].getSpecimen(),
                                                new Date(patients[i].getSpecimen_draw_date()),
                                                new Date(patients[i].getSpecimen_receive_date()),
                                                patients[i].getReporting_address(),
						patients[i].getBilling_address(),
						patients[i].getPhysician_name(),
						patients[i].getPhysician_institute()

					},action));
				}
				request.getSession().setAttribute ("PATIENT_HTML_TABLE",table);
				((PatientDataAccess)DATA_ACCESS_LAYER).setPatientDataDirty (false);
			}
			HTMLTable table = (HTMLTable)request.getSession().getAttribute ("PATIENT_HTML_TABLE");

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
			String patient_wid = request.getParameter ("patient_wid");
			Patient p = ((PatientDataAccess)DATA_ACCESS_LAYER).getPatient (patient_wid);

			out.print ("<FORM NAME=patient ACTION='"+application_name+"/patient/index.jsp' METHOD='POST'>");

			%>
			<script language=javascript src="../common/util.js"></script>
			<script language=javascript>

			function setFocus ()
			{
				document.patient.patient_id.focus()
			}
			</script>

			<%

			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=patient>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=modify_patient>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=update>");
			out.print ("<INPUT TYPE=HIDDEN NAME=patient_wid VALUE='"+p.getPatient_wid()+"'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=version_nbr VALUE='"+p.getVersion_nbr()+"'>");

			out.print ("<TABLE valign=center align=center>");
			//out.print ("<TR><TD><B>Test Type:</B></TD><TD>"+HTMLOutput.HTMLFormatTestType ("S")+"</TD></TR>");
			out.print ("<TR><TD><B>Accession Number:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=patient_id VALUE='"+p.getPatient_id()+"'></TD></TR>");
			out.print ("<TR><TD><B>First Name:</B></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=first_name VALUE='"+p.getFirst_name()+"'></TD></TR>");
			out.print ("<TR><TD><B>Last Name:</B></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=last_name VALUE='"+p.getLast_name()+"'></TD></TR>");
			out.print ("<TR><TD><B>SSN:</B></TD><TD><INPUT TYPE=TEXT SIZE=9 MAXLENGTH=9 NAME=ssn VALUE='"+p.getSsn()+"'></TD></TR>");
			out.print ("<TR><TD><B>Age:</B></TD><TD>"+HTMLOutput.HTMLFormatAge (p.getAge())+"</TD></TR>");
			out.print ("<TR><TD><B>Sex:</B></TD><TD>"+ HTMLOutput.HTMLFormatSex (p.getSex()) + "</TD></TR>");
			out.print ("<TR><TD><B>Final Storage Tube:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=specimen VALUE='"+p.getSpecimen()+"'></TD></TR>");
			out.print ("<TR><TD><B>Sample Draw Date (MM/DD/YYYY):</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=specimen_draw_date VALUE='"+p.getSpecimen_draw_date()+"'></TD></TR>");
			out.print ("<TR><TD><B>Sample Receive Date (MM/DD/YYYY):</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=specimen_receive_date VALUE='"+p.getSpecimen_receive_date()+"'></TD></TR>");
			out.print ("<TR><TD><B>Reporting Address:</B><TABLE><TR><TD><font size=-1>Address #1</font></TD></TR><TR><TD><font size=-1>Address #2</font></TD></TR><TR><TD><font size=-1>City State Zip</font></TD></TR></TABLE></TD><TD><TEXTAREA COLS=64 ROWS=3 NAME=reporting_address>"+p.getReporting_address()+"</TEXTAREA></TD></TR>");
			out.print ("<TR><TD><B>Billing Address:</B><TABLE><TR><TD><font size=-1>Address #1</font></TD></TR><TR><TD><font size=-1>Address #2</font></TD></TR><TR><TD><font size=-1>City State Zip</font></TD></TR></TABLE></TD><TD><TEXTAREA COLS=64 ROWS=3 NAME=billing_address>"+p.getBilling_address()+"</TEXTAREA></TD></TR>");
			out.print ("<TR><TD><B>Physician Name:</B></TD><TD><INPUT TYPE=TEXT SIZE=64 MAXLENGTH=64 NAME=physician_name VALUE='"+p.getPhysician_name()+"'></TD></TR>");
			out.print ("<TR><TD><B>Physician Institute:</B></TD><TD><TEXTAREA COLS=64 ROWS=4 NAME=physician_institute>"+p.getPhysician_institute()+"</TEXTAREA></TD></TR>");

			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=2><INPUT TYPE=BUTTON onClick='validateForm()' VALUE='Modify Patient'></TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");

		}
		else if (sub_command.equals ("update"))
		{
			String patient_wid = request.getParameter ("patient_wid");
			String patient_id = request.getParameter ("patient_id");
			String accession_number = request.getParameter ("accession_number");
			String first_name = request.getParameter ("first_name");
			String last_name = request.getParameter ("last_name");
			String ssn = request.getParameter ("ssn");
			String age = request.getParameter ("age");
			String sex = request.getParameter ("sex");
			String specimen = request.getParameter ("specimen");
			String specimen_draw_date = request.getParameter ("specimen_draw_date");			
			String specimen_receive_date = request.getParameter ("specimen_receive_date");			
			
			String reporting_address = request.getParameter ("reporting_address");
			String billing_address = request.getParameter ("billing_address");
			String physician_name = request.getParameter ("physician_name");
			String physician_institute = request.getParameter ("physician_institute");
			String version_nbr = request.getParameter ("version_nbr");

			Patient p = new Patient ();

			if (ssn != null)
				ssn = ssn.trim();

			p.setPatient_wid(patient_wid);
        		p.setPatient_id(patient_id);
        		p.setFirst_name(first_name);
        		p.setLast_name(last_name);
        		p.setSsn(ssn);
        		p.setAge(age);
        		p.setSex(sex);
			p.setSpecimen(specimen);
			p.setSpecimen_draw_date(specimen_draw_date);
			p.setSpecimen_receive_date(specimen_receive_date);
        		p.setReporting_address(reporting_address);
        		p.setBilling_address(billing_address);
        		p.setPhysician_name(physician_name);
        		p.setPhysician_institute(physician_institute);
			p.setVersion_nbr (version_nbr);

			((PatientDataAccess)DATA_ACCESS_LAYER).updatePatient (p,USER);

			out.print ("<FORM ACTION='"+application_name+"/patient/index.jsp' METHOD='POST'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=patient>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=modify_patient>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=getaccessionid>");
			out.print ("<TABLE valign=center align=center >");
			out.print("<TR><TD>Patient Successfully Updated!</TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("<TR><TD><INPUT TYPE=SUBMIT VALUE='Continue'></TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}

	}
%>
<%@ include file="../common/footer.jsp" %>
<script language=javascript>
	function validateForm ()
	{
		error = false
		error_string = ""
		test_type = "S";

		try
		{
			test_type = document.patient.test_type.options[document.patient.test_type.selectedIndex].value.toUpperCase()
		}
		catch (Exception) {}

		if (trimAll(document.patient.patient_id.value).length == 0)
		{
			error_string = error_string + 'Accession Number is a required field\n'
			error = true
		}

		if (trimAll(document.patient.patient_id.value).length > 0 && !validateValue( trimAll(document.patient.patient_id.value), "^[A-Za-z0-9]+$") )
		{
			error_string = error_string + 'Accession Number can only contain the following characters A-Z, a-z and 0-9\n'
			error = true
		}

		
		if (trimAll(document.patient.reporting_address.value).length == 0)
		{
			error_string = error_string + 'Reporting Address is a required field\n'
			error = true
		}

		if (trimAll(document.patient.specimen.value).length == 0)
		{
			error_string = error_string + 'Final Storage Tube is a required field\n'
			error = true
		}

		if (trimAll(document.patient.specimen.value).length > 0 && !validateValue( trimAll(document.patient.specimen.value), "^[A-Za-z0-9]+$") )
		{
			error_string = error_string + 'Final Storage Tube can only contain the following characters A-Z, a-z and 0-9\n'
			error = true
		}

		if (trimAll(document.patient.specimen_draw_date.value).length == 0)
		{
			error_string = error_string + 'Sample Draw Date is a required field\n'
			error = true
		}
		else 
		{
			if (!validateUSDate(trimAll(document.patient.specimen_draw_date.value)))
			{
				error_string = error_string + 'Sample Draw Date must be of the form MM/DD/YYYY with valid month,day and year\n'
				error = true
			}
		}

		if (trimAll(document.patient.specimen_receive_date.value).length == 0)
		{
			error_string = error_string + 'Sample Receive Date is a required field\n'
			error = true
		}
		else
		{
			if (!validateUSDate(trimAll(document.patient.specimen_receive_date.value)))
			{
				error_string = error_string + 'Sample Receive Date must be of the form MM/DD/YYYY with valid month,day and year\n'
				error = true
			}
		}

		var yrDate=new Date();
		var day=parseInt(yrDate.getUTCDate());
		var month=parseInt(yrDate.getMonth())+1;
		var year=yrDate.getFullYear();

		if (day < 10)
			day = "0" + day

		if (month < 10)
			month = "0" + month

		var currentDate = month + "/" + day + "/" + year

		if (compareUSDates(trimAll(document.patient.specimen_receive_date.value),
				trimAll(currentDate))==1)
		{
			error_string = error_string + 'Sample Draw Date and Receive Date cannot be in the future\n'
			error = true
		}


		if (compareUSDates(trimAll(document.patient.specimen_draw_date.value),
				trimAll(document.patient.specimen_receive_date.value))==1)
		{
			error_string = error_string + 'Sample Draw Date cannot be greater than Sample Receive Date\n'
			error = true
		}

		if (trimAll(document.patient.first_name.value).length > 0 && !validateValue( trimAll(document.patient.first_name.value), "^[ \-\.A-Za-z0-9]+$") )
		{
			error_string = error_string + 'First Name can only contain the following characters A-Z, a-z and 0-9\n'
			error = true
		}

		if (trimAll(document.patient.last_name.value).length > 0 && !validateValue( trimAll(document.patient.last_name.value), "^[ \-\.A-Za-z0-9]+$") )
		{
			error_string = error_string + 'Last Name can only contain the following characters A-Z, a-z and 0-9\n'
			error = true
		}

		if (trimAll(document.patient.physician_name.value).length > 0 && !validateValue( trimAll(document.patient.physician_name.value), "^[ \-\.A-Za-z0-9]+$") )
		{
			error_string = error_string + 'Physician Name can only contain the following characters A-Z, a-z and 0-9\n'
			error = true
		}

		if (trimAll(document.patient.ssn.value).length > 0 && !validateValue( trimAll(document.patient.ssn.value), "^[0-9]+$") )
		{
			error_string = error_string + 'SSN can only contain the digits 0-9\n'
			error = true
		}

		if (trimAll(document.patient.ssn.value).length > 0 && trimAll(document.patient.ssn.value).length != 9 )
		{
			error_string = error_string + 'SSN must be 9 digits in length\n'
			error = true
		}
		
		// if test_type is DIRECT then a bunch of other fields are required as well
		if (test_type == "D")
		{

			if (trimAll(document.patient.first_name.value).length == 0)
			{
				error_string = error_string + 'First Name is a required field\n'
				error = true
			}
			if (trimAll(document.patient.last_name.value).length == 0)
			{
				error_string = error_string + 'Last Name is a required field\n'
				error = true
			}
			if (trimAll(document.patient.age.value).length == 0)
			{
				error_string = error_string + 'Age is a required field\n'
				error = true
			}
			if (trimAll(document.patient.billing_address.value).length == 0)
			{
				error_string = error_string + 'Billing Address is a required field\n'
				error = true
			}
			if (trimAll(document.patient.physician_name.value).length == 0)
			{
				error_string = error_string + 'Physician Name is a required field\n'
				error = true
			}
			if (trimAll(document.patient.physician_institute.value).length == 0)
			{
				error_string = error_string + 'Physician Institute is a required field\n'
				error = true
			}	
		}
				

		if (error)
		{
			alert (error_string)
			return false
		}

		document.patient.submit()
		return true
	}
</script>

