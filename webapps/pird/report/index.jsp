<%@ include file="../common/header.jsp" %>
<%@ page import="com.dnas.lqt.html.*, com.dnas.lqt.data.patient.*, com.dnas.lqt.data.genotype.*,java.sql.*, java.util.*" %>

<%

	String command = "";

	if (request.getParameter ("command") != null)
		command = request.getParameter ("command");

	if (command.equals(""))
	{

		out.print ("<FORM NAME=report ACTION='"+application_name+"/report/index.jsp' METHOD='POST'>");
		%>
		<script language=javascript src="../common/util.js"></script>
		<script language=javascript>
		function submitForm ()
		{
			error = false
			error_string = ""

			if (trimAll(document.report.report_patient_id.value).length==0)
			{
				error_string = error_string + 'Patient ID is required\n'
				error = true
			}

			if (error)
			{
				alert (error_string)
				return false
			}

			if (confirm ('Please turn on the switch to connect to the network.\n  Press OK to continue'))
			{
				document.report.submit()
				return true
			}
			return false
		}
		</script>
		<%

		out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=report>");

		out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=runreport>");
		out.print ("<TABLE valign=top align=center>");

		out.print ("<TR><TD><B>Please input an Accession Number:</B></TD><TD align=right>");


		Patient [] patients = ((PatientDataAccess)DATA_ACCESS_LAYER).getPatients ();
		out.println ("<INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=report_patient_id>");
		out.println ("<B> or choose --> </B>");
		out.println (HTMLOutput.HTMLFormatPatient_ids (patients, null,"onChange=\"document.report.report_patient_id.value=document.report.patient_id.options[document.report.patient_id.selectedIndex].value\"",true));

		out.print ("</TD></TR>");

		out.print ("<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>");
		out.print ("<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>");


		out.print ("<TR><TD>");
		out.print ("<INPUT TYPE=BUTTON onClick=\"submitForm()\" VALUE='Generate Report'>");
		out.print ("</TD><TD&nbsp;</TD></TR>");
		out.print ("</TABLE>");
		out.print ("</FORM>");
	}
	else if (command.equals ("runreport"))
	{
		String gid_connection_string = "";
		String gid_username = "";
		String gid_password = "";
		String patient_id = "";

		if (request.getParameter ("report_patient_id") != null)
			patient_id = request.getParameter ("report_patient_id");
		else
			throw new Exception ("Report.runreport.report_patient_id == null");

		if (getServletContext().getInitParameter ("gid_connection_string") != null)
			gid_connection_string = getServletContext().getInitParameter ("gid_connection_string");
		else
			throw new Exception ("Report.runreport.gid_connection_string == null");

		if (getServletContext().getInitParameter ("gid_username") != null)
			gid_username = getServletContext().getInitParameter ("gid_username");
		else
			throw new Exception ("Report.runreport.gid_username == null");

		if (getServletContext().getInitParameter ("gid_password") != null)
			gid_password = getServletContext().getInitParameter ("gid_password");
		else
			throw new Exception ("Report.runreport.gid_username == null");

		Patient patient = ((PatientDataAccess)DATA_ACCESS_LAYER).getPatientByPatientID (patient_id);

		if (patient == null)
			throw new Exception ("Report.runreport: Failed to find patient for accession number- " + patient_id);


		Connection connection = DriverManager.getConnection(gid_connection_string,gid_username,gid_password);
		Report report = new Report(patient, connection);
		Consensus [] consensus = report.getConsensus();


		HTMLTable table = new HTMLTable ();
		HTMLTableColumn [] columns = {
		    new HTMLTableColumn ("Gene","",false,true,100,String.class,null),
		    new HTMLTableColumn ("Location","",false,true,100,Integer.class,null),
		    new HTMLTableColumn ("Offset","",false,true,100,Integer.class,null),
		    new HTMLTableColumn ("Genotype","",false,true,100,String.class,null),
		    new HTMLTableColumn ("AminoAcid","",false,true,100,String.class,null),
		    new HTMLTableColumn ("Wild Type Allele","",false,true,100,String.class,null),
		    new HTMLTableColumn ("Wild Type AA","",false,true,100,String.class,null),
		    new HTMLTableColumn ("Approved","",false,true,100,String.class,null),
		    new HTMLTableColumn ("Phenotype","",false,true,100,String.class,null),
		    new HTMLTableColumn ("Warnings","",false,true,100,String.class,null),
		    new HTMLTableColumn ("Errors","",false,true,100,String.class,null),
		};
		table.setColumns(columns,"Preview Report for accession:" + patient.getPatient_id());

                VariantInfo[] variant_info = report.getVariantInfo();
                String[] warnings = report.getWarnings();
                String[] errors = report.getErrors();
                for (int i=0; consensus!=null && i<consensus.length ;i++) {
		  Consensus c = consensus[i];
		  String phenotype = variant_info[i]==null?new String(""):
		    variant_info[i].getPhenotype();

		  table.addRow (new HTMLTableRow ( new Object [] {
		    c.getGene().getGene_name(),
		    new Integer (c.getLocation ()),
		    new Integer (c.getOffset ()),
		    new String (c.getAllele1() + "/" + c.getAllele2()),
		    new String (HTMLOutput.HTMLFormatAminoAcid(c.getAa1()) 
				+ "/" + 
				HTMLOutput.HTMLFormatAminoAcid(c.getAa2())),
		    c.getWildTypeAllele(),
		    HTMLOutput.HTMLFormatAminoAcid(c.getWildTypeAa()),
		    c.getApproved(),
		    phenotype,
		    warnings[i],
		    errors[i]
		  }, null));
                }


		%>
		<%@ include file="/common/generateTable.jsp" %>
		<%

		out.print ("<TABLE valign=center align=center >");
		out.print("<TR><TD>Report for patient: " + patient.getPatient_id() +
		  " contains " + report.getNumWarnings() + " warnings & "
		  + report.getNumErrors() + " errors</TD></TR>");
		out.print ("<TR><TD>&nbsp;</TD></TR>");

		if(report.getNumErrors() == 0) {

		%>

		<script language=javascript>
		function runReport ()
		{

			if (confirm ('Please turn on the switch to dis-connect from the network.\n  Press OK to continue'))
			{
				document.report.submit()
				return true
			}
			return false
		}
		</script>
		<%

		  out.print ("<FORM NAME=report ACTION='"+ application_name
			     + "/report/printreport.jsp' METHOD='POST'>");
		  session.setAttribute("report_object", report);
		  out.print ("<TR><TD><INPUT TYPE=BUTTON onClick=\"runReport()\" VALUE='View Printable Report'>"
			     + "</TD></TR>");
		  out.print ("</FORM>");
		}
		else {
		  out.print ("<FORM ACTION='"+ application_name
			     + "/report/index.jsp' METHOD='POST'>");
		  out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=report>");
		  out.print ("<TR><TD>Printable Report will not be generated</TD></TR>");
		  out.print ("<TR><TD><INPUT TYPE=SUBMIT VALUE='Continue'></TD></TR>");
		  out.print ("</FORM>");
		}
		out.print ("<TR><TD>&nbsp;</TD></TR>");
		out.print ("</TABLE>");
	}

%>
<%@ include file="../common/footer.jsp" %>
