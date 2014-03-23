<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Final Report</TITLE>
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<META content="Microsoft FrontPage 4.0" name=GENERATOR>
<link rel="StyleSheet" type="text/css" href="classes.css">
</HEAD>
<BODY><%@ page language="Java" import="com.dnas.lqt.data.*,com.dnas.lqt.data.patient.*,com.dnas.lqt.security.*,java.util.*, java.text.* " %><%
// if we don't have an active USER object then redirect to login page.
if (request.getSession().getAttribute ("USER") == null) {
%><jsp:forward page="/common/login.jsp" /><%
}
%>
<jsp:useBean class="com.dnas.lqt.data.Menu" id="MENU_INFO" scope="application"/>
<jsp:useBean class="com.dnas.lqt.data.User" id="USER" scope="session"/>
<%
String servlet_name = request.getRequestURI ();
String jsp_name = servlet_name.substring (servlet_name.substring(1).indexOf ("/")+1);
// if we aren't allowed access to this page then throw an exception
if (!SecurityContext.isAllowedAccess (USER, jsp_name))
  throw new Exception (jsp_name +" : Access DENIED!");
Report report = (Report)session.getAttribute("report_object");
Patient patient = report.getPatient();
DataAccess DATA_ACCESS_LAYER = (DataAccess)request.getSession().getAttribute("DATA_ACCESS_LAYER");
((PatientDataAccess)DATA_ACCESS_LAYER).createReport(patient, USER);
%>
<TABLE width="100%">
  <TBODY>
  <TR>
    <TD vAlign=top class="headingRed"><I><B><font face="TradeGothic CondEighteen">CONFIDENTIAL</font></B></I></TD>
    <TD class="bodyText">
      <p align="right"><font face="TradeGothic CondEighteen"><img border="0" src="../images/dnas_small.jpg" width="147" height="65"></font></p>
    </TD></TR></TBODY></TABLE>
<font face="TradeGothic CondEighteen">
<CENTER>
<span class="heading"><b>LQT Analysis <BR>Comprehensive LQT Gene Sequence Analysis Result</b></span>

</CENTER>
<br>
</font>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <tr>
    <td valign="top" width="33%"><TABLE width="100%" border=0 cellpadding="4" cellspacing="0">
        <TBODY>
          <TR> 
            <TH class="bodyTextWhite" bgColor="#0000000"><font face="TradeGothic CondEighteen">PHYSICIAN</font></TH>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Name:
              <% out.print(patient.getPhysician_name()); %>
              </font>
            </TD>
          </TR>
          <TR> 
		<% 
			String address_1 = "";
			String address_2 = "";
			String city_state_zip = "";
			String [] tokens = patient.getReporting_address().split("\n");
			address_1 = tokens[0];

			if (tokens.length == 2)
				city_state_zip = tokens[1];
			else if (tokens.length > 2)
			{
				address_2 = tokens[1];
				city_state_zip = tokens[2];
			}
		%>
			
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Address #1:<% out.print(address_1); %></font></TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Address #2:<% out.print(address_2); %></font></TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">City, State Zip:<% out.print(city_state_zip); %></font></TD>
          </TR>
        </TBODY>
      </TABLE></td>
    <td width="33%"><TABLE width="100%" border=0 cellpadding="4" cellspacing="0">
        <TBODY>
          <TR> 
            <TH class="bodyTextWhite" bgColor="#0000000"><font face="TradeGothic CondEighteen">SPECIMEN</font></TH>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Specimen: 
              <% out.print(patient.getSpecimen()); %>
              </font>
            </TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Specimen draw date: 
              <% out.print(patient.getSpecimen_draw_date()); %>
              </font>
            </TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Specimen receive date: 
              <% out.print(patient.getSpecimen_receive_date()); %>
              </font>
            </TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Result date:
		<% out.print(new SimpleDateFormat ("MM/dd/yyyy").format(new Date())); %></font></TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">&nbsp;</font></TD>
          </TR>
	<TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">&nbsp;</font></TD>
          </TR>
        </TBODY>
      </TABLE></td>
    <td valign="top" width="33%"><TABLE width="100%" border=0 cellpadding="4" cellspacing="0">
        <TBODY>
          <TR> 
            <TH class="bodyTextWhite" bgColor="#0000000"><font face="TradeGothic CondEighteen">PATIENT</font></TH>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Name:
              <% out.print(patient.getFirst_name() + " "
	  + patient.getLast_name()); %>
              </font>
            </TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Age:
		<%= patient.getAge()%> </font></TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Date of birth:</font></TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Sample ID: 
              <% out.print(patient.getPatient_id()); %>
              </font>
            </TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">Gender: 
              <% out.print(patient.getSex()); %>
              </font>
            </TD>
          </TR>
          <TR> 
            <TD class="bodyText"><font face="TradeGothic CondEighteen">&nbsp;</font></TD>
          </TR>
        </TBODY>
      </TABLE></td>
  </tr>
</table>
<p><font face="TradeGothic CondEighteen"><BR>
  <BR>
  <%
Consensus[] consensus = report.getConsensus();
VariantInfo[] variant_info = report.getVariantInfo();
%>
</font>
</p>
<table width="50%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <tr>
    <td><table width="100%" border=0 cellpadding="4" cellspacing="0">
        <tbody>
          <tr> 
            <th class="bodyTextWhite" bgcolor="#0000000" colspan="2"><font face="TradeGothic CondEighteen">TEST RESULT</font></th>
          <tr> 
            <td align=middle width="50%" class="bodyText"><div align="middle"><font face="TradeGothic CondEighteen">Gene Analyzed:</font></div></td>
            <td align=middle width="50%" class="bodyText"><div align="middle"><font face="TradeGothic CondEighteen">Specific Gene Variant:</font></div></td>
          </tr>
          <%
  Vector v = new Vector();
for(int i=0; consensus!=null && i<consensus.length; i++) {
  Consensus c = consensus[i];
  VariantInfo vi = variant_info[i];
  if(c.getApproved().equalsIgnoreCase("Y")) {
    String nuc_change = new String("");
    String reference_link = new String("");
    String wild_type_allele = c.getWildTypeAllele();
    String allele1 = c.getAllele1();
    String allele2 = c.getAllele2();
    if(allele1.equalsIgnoreCase(allele2)) {
      //allele1 & allele2 both cannot be wildtype
      nuc_change += c.getLocation() + wild_type_allele + ">" + allele1;
    }
    else {
      if(!c.getVariantType1().getType().equalsIgnoreCase("wild type")) 
	nuc_change += c.getLocation() + wild_type_allele + ">" + allele1;
      if(!c.getVariantType2().getType().equalsIgnoreCase("wild type")) {
        if(!nuc_change.equals(""))
           nuc_change += " ";
	nuc_change += c.getLocation() + wild_type_allele + ">" + allele2;
      }
    }
    if(vi != null && vi.getReference() != null
       && !vi.getReference().equals("")) {
       v.add(vi.getReference());
       reference_link = String.valueOf(v.size());
    }
%>
          <tr> 
            <td align=middle class="bodyText"><font face="TradeGothic CondEighteen">&nbsp; 
              <% out.print(c.getGene().getGene_name()); %>
              &nbsp;</font> </td>
            <td align=middle class="bodyText"><font face="TradeGothic CondEighteen">&nbsp; 
     		<% out.print(nuc_change); %>
              <font size=-2>
              <sup><% out.print(reference_link); %></sup>
              &nbsp; </font></font></td>
          </tr>
          <%
  }
}
%>
        </tbody>
      </table></td>
  </tr>
</table>
<p><font face="TradeGothic CondEighteen"><BR>
</font>
</p>
<HR width="100%" size="1" noshade>
<TABLE width="100%" height=48 border=0 cellpadding="4" cellspacing="0">
  <TBODY>
  <TR>
    <TH align=middle height=21 class="headingSmall"><font face="TradeGothic CondEighteen">INTERPRETATION</font></TH></TR>
  <TR vAlign=center>
    <TD align=middle height=19 rowSpan=2 class="bodyText"><B><font face="TradeGothic CondEighteen">&nbsp; <% if(report.hasKnownVariant())    
     out.print("POSITIVE FOR A DISEASE-ASSOCIATED MUTATION");
   else if(report.hasUnknownVariant())
     out.print("POSITIVE FOR GENETIC VARIANT OF UNKNOWN SIGNIFICANCE");
   else if(report.hasBenignVariant())
     out.print("POSITIVE FOR SINGLE NUCLEOTIDE POLYMORPHISM");
   else
     out.print("NO DELETERIOUS GENETIC VARIANT DETECTED");
%>&nbsp;</font></B> </TD></TR></TBODY></TABLE>
<P class="bodyText"><B><font face="TradeGothic CondEighteen">REFERENCES:</font></B> </P>
<OL><%
if(!v.isEmpty()) {
  for(int i=0; i<v.size(); i++) {
%>
  <LI class="bodyText"><font face="TradeGothic CondEighteen">&nbsp;<% out.print((String)v.get(i)); %>&nbsp; <%
  }
}
%></font></LI></OL>
<P> </P>
<P class="bodyText"><font face="TradeGothic CondEighteen">Authorized Signature:</font> 
<TABLE width="100%" border=0 cellpadding="4" cellspacing="0">
  <TBODY>
  <TR>
    <TH align=middle>
      <P align=left class="bodyText"><font face="TradeGothic CondEighteen">X:</font>
      <hr align="left" width="90%">
    </TH></TR>
  <TR vAlign=center>
    <TD align=middle rowSpan=2 class="bodyText">
      <P align=left class="bodyText"><font face="TradeGothic CondEighteen">&nbsp;&nbsp;&nbsp;&nbsp;
      Jessica Booker, Medical 
      Director&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Phone: 
      XXX-XXX-XXXX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> 
      </P></TD></TR></TBODY></TABLE>
<P class="bodyTextSmall">&nbsp;</P>
<P class="bodyTextSmall">&nbsp;</P>
<P class="bodyTextSmall"><font size="1" face="TradeGothic CondEighteen"><B>GENERAL DISCLAIMER:</B>&nbsp;&nbsp;This genetic test was 
developed by DNA Sciences and the test specifications are included with this 
report on a separate document.&nbsp; This test is conducted in a CLIA certified 
laboratory facility but is not an FDA approved test (FDA approval is not 
required).&nbsp; The characterization of a particular amino acid substitution or 
belonging to the class of "disease-associated mutation" is based on information 
current at the time of the test report.&nbsp; As new knowledge in the field is 
developed, the list of disease causing mutations will be serially revised.&nbsp; 
The physician may contact DNA Sciences at anytime in the future to obtain 
further information [877-XXX-XXXX].&nbsp; The proper clinical use and 
interpretation of this test result requires the physician to interpret the 
genetic test results in the context of the relevant clinical information, and, 
when appropriate, to obtain a consultation with a medical geneticist.&nbsp; 
Communication of the test results to the patient should optimally be accompanied 
by a referral to a genetic counselor.&nbsp; &nbsp;</font></P>
&nbsp; 
</BODY></HTML>
