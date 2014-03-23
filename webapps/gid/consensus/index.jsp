<%@ include file="../common/header.jsp" %>
<%@ page import="java.util.*, com.dnas.lqt.html.*, com.dnas.lqt.data.genotype.*" %>
<%
	String command = "";

	if (request.getParameter ("command") != null)
		command = request.getParameter ("command");

	if (command.equals ("modify"))
	{
		String sub_command = "";
		if (request.getParameter ("sub_command") != null)
			sub_command = request.getParameter ("sub_command");

		if (sub_command.equals ("getinfo"))
		{
			String sample_id = "";

			if (request.getParameter ("selected_sample_id") != null)
				sample_id = request.getParameter ("selected_sample_id");



			Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes();

			String [] sample_ids = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getSample_ids();

			out.print ("<FORM NAME=consensus ACTION='"+application_name+"/consensus/index.jsp'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=consensus>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=edit_consensus>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=getinfo>");

			out.print ("<TABLE><TR>");
			out.print ("<TD><B>Please input a sample id: </B></TD>");
			out.print ("<TD><INPUT TYPE=TEXT NAME=selected_sample_id VALUE='"+sample_id+"' SIZE=10 MAXLENGTH=10></TD>");
			out.print ("<TD><B>or choose</B> --></TD>");
			out.print ("<TD>"+HTMLOutput.HTMLFormatSample_ids (sample_ids,sample_id,"onChange=\"document.consensus.selected_sample_id.value=document.consensus.sample_id.options[document.consensus.sample_id.selectedIndex].value\" ",false,true)+"</TD>");
			out.print ("<TD><INPUT TYPE=SUBMIT VALUE='View Consensus'></TD>");
			out.print ("</TR></TABLE>");
			out.print ("</FORM>");

			boolean newQuerySelected = false;

			if (request.getSession().getAttribute ("CURRENT_CONSENSUS_SAMPLE_ID")!=null)
			{

				String current_sample_id = (String)request.getSession().getAttribute ("CURRENT_CONSENSUS_SAMPLE_ID");
				if (!current_sample_id.equals (sample_id))
				{
					newQuerySelected = true;
					request.getSession().setAttribute ("CURRENT_CONSENSUS_SAMPLE_ID",sample_id);
				}

			}
			else
			{
				newQuerySelected = true;
				request.getSession().setAttribute ("CURRENT_CONSENSUS_SAMPLE_ID",sample_id);
			}
	

			if (newQuerySelected || request.getSession().getAttribute("CONSENSUS_HTML_TABLE") == null || ((GenotypeDataAccess)DATA_ACCESS_LAYER).isConsensusDataDirty())
			{
				// set gene_wid to -1 so that we get ALL consensus for a sample_id regardless of gene_wid
				Consensus [] consensus = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getConsensus (sample_id,"-1");

 
				String SORT_ACTION = application_name+"/consensus/index.jsp?section=consensus&sub_section=edit_consensus&command=modify&sub_command=getinfo&selected_sample_id=" + sample_id;
				// create an html table with all column descipriptors
      				HTMLTable table = new HTMLTable ();

      				HTMLTableColumn [] columns = {
					new HTMLTableColumn ("Gene",SORT_ACTION+"&sort_index=0",true,true,100,String.class, new int [] {0}),
					new HTMLTableColumn ("Approved",SORT_ACTION+"&sort_index=1",true,true,100,String.class, new int [] {1}),
					new HTMLTableColumn ("Location",SORT_ACTION+"&sort_index=2",true,true,100,Integer.class, new int [] {0,2}),
					new HTMLTableColumn ("Offset",SORT_ACTION+"&sort_index=3",true,true,100,Integer.class, new int [] {0,2,3}),
					new HTMLTableColumn ("Variant Type 1",SORT_ACTION+"&sort_index=4",true,true,100,String.class, new int [] {4}),
					new HTMLTableColumn ("Variant Length 1",SORT_ACTION+"&sort_index=5",true,true,100,String.class, new int [] {5}),
					new HTMLTableColumn ("Variant Type 2",SORT_ACTION+"&sort_index=6",true,true,100,String.class, new int [] {6}),
					new HTMLTableColumn ("Variant Length 2",SORT_ACTION+"&sort_index=7",true,true,100,String.class, new int [] {7}),
					new HTMLTableColumn ("Allele 1",SORT_ACTION+"&sort_index=8",true,true,100,String.class, new int [] {8}),
					new HTMLTableColumn ("Allele 2",SORT_ACTION+"&sort_index=9",true,true,100,String.class, new int [] {9}),
					new HTMLTableColumn ("AA 1",SORT_ACTION+"&sort_index=10",true,true,100,String.class, new int [] {10}),
					new HTMLTableColumn ("AA 2",SORT_ACTION+"&sort_index=11",true,true,100,String.class, new int [] {11}),
					new HTMLTableColumn ("Wild Type Allele",SORT_ACTION+"&sort_index=12",true,true,100,String.class, new int [] {12}),
					new HTMLTableColumn ("Wild Type AA",SORT_ACTION+"&sort_index=13",true,true,100,String.class, new int [] {13}),
					new HTMLTableColumn ("Quality Score",SORT_ACTION+"&sort_index=14",true,true,100,String.class, new int [] {15})
	      			};
      				table.setColumns(columns,"Available Consensus");

				// now create all our row objects
	
				for (int i=0;consensus!=null&&i<consensus.length;i++)
				{

					String action = ""+application_name+"/consensus/index.jsp?section=consensus&sub_section=edit_consensus&command=modify&sub_command=modify&consensus_wid="+consensus[i].getConsensus_wid()+"&sample_id="+sample_id+"&gene_wid="+consensus[i].getGene().getGene_wid();

					
					table.addRow (new HTMLTableRow ( new Object [] {
						consensus[i].getGene().getGene_name(),
						consensus[i].getApproved(),
						new Integer (consensus[i].getLocation ()),
						new Integer (consensus[i].getOffset ()),
						consensus[i].getVariantType1().getType(),
						consensus[i].getVariantLength1(),
						consensus[i].getVariantType2().getType(),
						consensus[i].getVariantLength2(),
						consensus[i].getAllele1(),
						consensus[i].getAllele2(),
						HTMLOutput.HTMLFormatAminoAcid(consensus[i].getAa1()),
						HTMLOutput.HTMLFormatAminoAcid(consensus[i].getAa2()),
						consensus[i].getWildTypeAllele(),
						HTMLOutput.HTMLFormatAminoAcid(consensus[i].getWildTypeAa()),
						consensus[i].getQualityScore()
					},action));
				}



				request.getSession().setAttribute ("CONSENSUS_HTML_TABLE",table);
				((GenotypeDataAccess)DATA_ACCESS_LAYER).setConsensusDataDirty (false);
			}
			HTMLTable table = (HTMLTable)request.getSession().getAttribute ("CONSENSUS_HTML_TABLE");

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
		else if (sub_command.equals ("modify"))
		{
			String consensus_wid = request.getParameter ("consensus_wid");
			String gene_wid = request.getParameter ("gene_wid");
			String sample_id = request.getParameter ("sample_id");
			Consensus consensus = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getConsensusByID (consensus_wid);
			Genotype [] genotypes = consensus.getGenotypes ();
			VariantType [] variant_types = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantTypes ();

			out.print ("<FORM NAME=consensus ACTION='"+application_name+"/consensus/index.jsp'>");

			%>
			<script language=javascript src="../common/util.js"></script>
			<script language=javascript>
			function validateForm ()
			{
				error = false
				error_string = ""

					variant_type1 = trimAll(document.consensus.consensus_variant_type1_wid.options[document.consensus.consensus_variant_type1_wid.selectedIndex].text.toUpperCase())
					variant_type2 = trimAll(document.consensus.consensus_variant_type2_wid.options[document.consensus.consensus_variant_type2_wid.selectedIndex].text.toUpperCase())
					approved = trimAll(document.consensus.approved.options[document.consensus.approved.selectedIndex].text.toUpperCase())

					if (approved == "YES")
					{
						error_string = validateVariant (variant_type1, 
							document.consensus.consensus_variant1_length.value, 
							document.consensus.consensus_wild_type_allele.value, 
							document.consensus.consensus_allele1.value,
							document.consensus.consensus_wild_type_aa.value,
							document.consensus.consensus_aa1.value);

						error_string = error_string + validateVariant (variant_type2, 
							document.consensus.consensus_variant2_length.value, 
							document.consensus.consensus_wild_type_allele.value, 
							document.consensus.consensus_allele2.value,
							document.consensus.consensus_wild_type_aa.value,
							document.consensus.consensus_aa2.value);

						if (error_string.length > 0)
							error = true
					}

					if (error)
					{
						alert (error_string)
						return false
					}

				if (confirm ('Is the information you have entered correct?  Press OK to continue'))
				{
					document.consensus.submit()
					return true
				}
				else
					return false
			}
			</script>
			<%
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=consensus>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=edit_consensus>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=update>");
			out.print ("<INPUT TYPE=HIDDEN NAME=consensus_wid VALUE="+consensus_wid+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=gene_wid VALUE="+gene_wid+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=sample_id VALUE="+sample_id+">");
			out.println ("<TABLE>");
			out.println ("<TR><TD><B>Sample ID:</B></TD><TD>"+consensus.getSample_id()+"</TD></TR>");
			out.println ("<TR><TD><B>Gene Name:</B></TD><TD>"+consensus.getGene().getGene_name()+"</TD></TR>");
			out.println ("<TR><TD><B>Location:</B></TD><TD>"+consensus.getLocation ()+"</TD></TR>");
			out.println ("<TR><TD><B>Offset:</B></TD><TD>"+consensus.getOffset ()+"</TD></TR>");
			out.println ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.println ("</TABLE>");
			out.println ("<TABLE BORDER=1>");

			out.println ("<TR><TD>&nbsp;</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				out.println ("<TD><B>User " + (i+1) + "</B></TD>");
			}

			if (genotypes.length == 1)
				out.println ("<TD><B>User 2</B></TD>");

			out.println ("<TD><B>Consensus</B></TD></TR>");

			out.println ("<TR><TD>Username:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				String user_wid = genotypes[i].getUser_wid();
				String username = "";
				User u = DATA_ACCESS_LAYER.getUser (user_wid);

				if (u != null)
					username = u.getUsername();

				out.println ("<TD>"+username+"</TD>");
			}
			if (genotypes.length==1)
				out.println ("<TD>&nbsp;N/A&nbsp;</TD>");

			String consensus_username = "N/A";

			// display the username of the consensus object UNLESS its -1, which means
			// the user is set to NOBODY Eg. record hasn't been updated yet.
			if (consensus.getUser() != null && !consensus.getUser().getUserwid().equals("-1"))
				consensus_username = consensus.getUser().getUsername();

			out.println ("<TD>"+consensus_username+"</TD></TR>");




			/*--------------- Display our wild type allele values ----------*/
			boolean consensusValid = true;
			out.println ("<TR><TD>Wild Type Allele:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getWild_type_allele().equals (genotypes[i].getWild_type_allele())))
					consensusValid = false;
					
				out.println ("<TD>&nbsp;" + genotypes[i].getWild_type_allele() + "</TD>");
			}

			if (genotypes.length < 2)
				consensusValid = false;

			String consensus_value = consensus.getWildTypeAllele();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getWild_type_allele();
				else
					consensus_value = consensus.getWildTypeAllele();
			}
			
			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=consensus_wild_type_allele VALUE='"+consensus_value+"'></TD></TR>");

			/*-----------------------------------------------------*/





			/*-------------- Display our AA values ---------------*/
			boolean consensusValud = true;
			out.println ("<TR><TD>Wild Type AA:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getWild_type_aa().equals (genotypes[i].getWild_type_aa())))
					consensusValid = false;

				out.println ("<TD>&nbsp;" + genotypes[i].getWild_type_aa() + "</TD>");
			}

			if (genotypes.length < 2)
				consensusValid = false;
			consensus_value = consensus.getWildTypeAa();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getWild_type_aa();
				else
					consensus_value = consensus.getWildTypeAa();
			}
			
			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=consensus_wild_type_aa VALUE='"+consensus_value+"'></TD></TR>");

			/*------------------------------------------------------------*/



			/*------------------ Display our Variant Type1 Values ------------------*/
			consensusValid = true;
			out.println("<TR><TD>Variant Type 1:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getVariant_type1().getType().equals (genotypes[i].getVariant_type1().getType())))
					consensusValid = false;
				out.println ("<TD>" + genotypes[i].getVariant_type1().getType() + "</TD>");
			}

			if (genotypes.length < 2)
				consensusValid = false;
			VariantType vt = consensus.getVariantType1();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					vt = genotypes[0].getVariant_type1();
			}
			
			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD>"+HTMLOutput.HTMLFormatVariantTypes (variant_types, vt, null, "consensus_variant_type1_wid",true) +"</TD></TR>");

			/*--------------------------------------------------------------*/




			/*------------------------- Display our Variant Length1 Values --------------*/
			consensusValid = true;
			out.println ("<TR><TD>Variant Length 1:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getVariant_length1().equals (genotypes[i].getVariant_length1())))
					consensusValid = false;

				out.println ("<TD>&nbsp;" + genotypes[i].getVariant_length1() + "</TD>");
			}

			if (genotypes.length < 2)
				consensusValid = false;
			consensus_value = consensus.getVariantLength1();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getVariant_length1();
				else
					consensus_value = consensus.getVariantLength1();
			}

			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=consensus_variant1_length VALUE='"+consensus_value+"'></TD></TR>");

			/*---------------------------------------------------------------------------*/


			/*--------------------------- Display our Allele 1 Values --------------------*/
			consensusValid = true;
			out.println ("<TR><TD>Allele 1:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getAllele1().equals (genotypes[i].getAllele1())))
					consensusValid = false;

				out.println ("<TD>&nbsp;" + genotypes[i].getAllele1() + "</TD>");
			}

			if (genotypes.length < 2)
				consensusValid = false;
			consensus_value = consensus.getAllele1();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getAllele1();
				else
					consensus_value = consensus.getAllele1();
			}

			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=consensus_allele1 VALUE='"+consensus_value+"'></TD></TR>");

			/*-----------------------------------------------------------------------------*/


			/* ------------------------------ Display our AA1 Values ---------------------*/

			consensusValid = true;
			out.println ("<TR><TD>AA1:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getAa1().equals (genotypes[i].getAa1())))
					consensusValid = false;

				out.println ("<TD>&nbsp;" + genotypes[i].getAa1() + "</TD>");
			}
			if (genotypes.length < 2)
				consensusValid = false;
			consensus_value = consensus.getAa1();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getAa1();
				else
					consensus_value = consensus.getAa1();
			}
			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=consensus_aa1 VALUE='"+consensus_value+"'></TD></TR>");
		
			/*---------------------------------------------------------------------*/



			/*------------------ Display our Variant Type2 Values ------------------*/
			consensusValid = true;
			out.println("<TR><TD>Variant Type 2:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getVariant_type2().getType().equals (genotypes[i].getVariant_type2().getType())))
					consensusValid = false;
				out.println ("<TD>" + genotypes[i].getVariant_type2().getType() + "</TD>");
			}

			if (genotypes.length < 2)
				consensusValid = false;
			vt = consensus.getVariantType2();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					vt = genotypes[0].getVariant_type2();
			}
			
			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD>"+HTMLOutput.HTMLFormatVariantTypes (variant_types, vt, null, "consensus_variant_type2_wid",true) +"</TD></TR>");

			/*--------------------------------------------------------------*/


			/*------------------------- Display our Variant Length2 Values --------------*/
			consensusValid = true;
			out.println ("<TR><TD>Variant Length 2:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getVariant_length2().equals (genotypes[i].getVariant_length2())))
					consensusValid = false;

				out.println ("<TD>&nbsp;" + genotypes[i].getVariant_length2() + "</TD>");
			}

			if (genotypes.length < 2)
				consensusValid = false;
			consensus_value = consensus.getVariantLength2();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getVariant_length2();
				else
					consensus_value = consensus.getVariantLength2();
			}

			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=consensus_variant2_length VALUE='"+consensus_value+"'></TD></TR>");

			/*---------------------------------------------------------------------------*/


			/*--------------------------- Display our Allele 2 Values --------------------*/
			consensusValid = true;
			out.println ("<TR><TD>Allele 2:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getAllele2().equals (genotypes[i].getAllele2())))
					consensusValid = false;

				out.println ("<TD>&nbsp;" + genotypes[i].getAllele2() + "</TD>");
			}

			if (genotypes.length < 2)
				consensusValid = false;
			consensus_value = consensus.getAllele2();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getAllele2();
				else
					consensus_value = consensus.getAllele2();
			}

			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=consensus_allele2 VALUE='"+consensus_value+"'></TD></TR>");

			/*-----------------------------------------------------------------------------*/


			/* ------------------------------ Display our AA2 Values ---------------------*/

			consensusValid = true;
			out.println ("<TR><TD>AA2:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getAa2().equals (genotypes[i].getAa2())))
					consensusValid = false;

				out.println ("<TD>&nbsp;" + genotypes[i].getAa2() + "</TD>");
			}
			if (genotypes.length < 2)
				consensusValid = false;
			consensus_value = consensus.getAa2();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getAa2();
				else
					consensus_value = consensus.getAa2();
			}
			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=consensus_aa2 VALUE='"+consensus_value+"'></TD></TR>");
		
			/*---------------------------------------------------------------------*/

		
			/*-------------------- Display our Quality Score Values -----------------------*/

			consensusValid = true;
			out.println ("<TR><TD>Quality Score:</TD>");
			for (int i=0;genotypes!=null && i<genotypes.length;i++)
			{
				if (i> 0 && !(genotypes[i-1].getQuality_score().equals (genotypes[i].getQuality_score())))
					consensusValid = false;

				out.println ("<TD>&nbsp;" + (genotypes[i].getQuality_score().trim().length()==0?"&nbsp;":genotypes[i].getQuality_score()) + "</TD>");
			}
			if (genotypes.length < 2)
				consensusValid = false;
			consensus_value = consensus.getQualityScore();
			if (consensus.getUser_wid().equals("-1"))
			{
				if (consensusValid)
					consensus_value = genotypes[0].getQuality_score();
				else
					consensus_value = consensus.getQualityScore();
			}

			if (genotypes.length==1)
				out.println ("<TD>&nbsp;</TD>");
			out.println ("<TD><INPUT TYPE=TEXT SIZE=3 MAXLENGTH=3 NAME=consensus_quality_score VALUE='"+consensus_value+"'></TD></TR>");

			/*----------------------------------------------------------------------*/


			out.println ("</TABLE>");

			out.println ("<PRE>\n\n</PRE>");
			out.println ("<TABLE>");

			out.println ("<TR><TD><B>Approved</B></TD><TD>"+HTMLOutput.HTMLFormatApproved(consensus.getApproved()) + "</TD></TR>");
			out.println ("<TR><TD SPAN=2>&nbsp;</TD></TR>");
			out.println ("<TR><TD SPAN=2>&nbsp;</TD></TR>");
			out.println ("<TR><TD SPAN=2><INPUT TYPE=BUTTON onClick=\"validateForm()\" VALUE='Update Consensus'></TD></TR>");
			out.println ("</TABLE>");
			out.println ("</FORM>");
		}
		else if (sub_command.equals ("update"))
		{
			String consensus_wid = request.getParameter ("consensus_wid").trim();
			String gene_wid = request.getParameter ("gene_wid").trim();
			String sample_id = request.getParameter ("sample_id").trim();
			String consensus_variant_type1_wid = request.getParameter ("consensus_variant_type1_wid");
			String consensus_variant_type2_wid = request.getParameter ("consensus_variant_type2_wid");

			String consensus_variant1_length = request.getParameter ("consensus_variant1_length").trim().toUpperCase();
			String consensus_variant2_length = request.getParameter ("consensus_variant2_length").trim().toUpperCase();
			String consensus_allele1 = request.getParameter ("consensus_allele1").trim().toUpperCase();
			String consensus_allele2 = request.getParameter ("consensus_allele2").trim().toUpperCase();
			String consensus_aa1 = request.getParameter ("consensus_aa1").trim().toUpperCase();
			String consensus_aa2 = request.getParameter ("consensus_aa2").trim().toUpperCase();
			String consensus_wild_type_allele = request.getParameter ("consensus_wild_type_allele").trim().toUpperCase();
			String consensus_wild_type_aa = request.getParameter ("consensus_wild_type_aa").trim().toUpperCase();
			String consensus_quality_score = request.getParameter ("consensus_quality_score").trim();
			String approved = request.getParameter ("approved");


			VariantType [] variant_types = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantTypes ();
			Consensus c = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getConsensusByID (consensus_wid);

			c.setVariantLength1 (consensus_variant1_length);
			c.setVariantLength2 (consensus_variant2_length);
			c.setWildTypeAllele (consensus_wild_type_allele);
			c.setWildTypeAa (consensus_wild_type_aa);
			c.setAllele1 (consensus_allele1);
			c.setAllele2 (consensus_allele2);
			c.setAa1 (consensus_aa1);
			c.setAa2 (consensus_aa2);
			c.setQualityScore (consensus_quality_score);
			c.setApproved (approved);

			for (int i=0;variant_types != null && i < variant_types.length;i++)
			{
				if (variant_types[i].getVariant_type_wid().equals (consensus_variant_type1_wid))
					c.setVariantType1 (variant_types[i]);

				if (variant_types[i].getVariant_type_wid().equals (consensus_variant_type2_wid))
					c.setVariantType2 (variant_types[i]);
			}
			((GenotypeDataAccess)DATA_ACCESS_LAYER).updateConsensus (c,USER);
			

			out.print ("<FORM NAME=consensus ACTION='"+application_name+"/consensus/index.jsp' METHOD='POST'>");

			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=consensus>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=edit_consensus>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=getinfo>");
			out.print ("<INPUT TYPE=HIDDEN NAME=gene_wid VALUE="+gene_wid+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=sample_id VALUE="+sample_id+">");
			out.print ("<TABLE valign=center align=center >");
			out.print("<TR><TD>Consensus Successfully Updated!</TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("<TR><TD><INPUT NAME=continue TYPE=SUBMIT VALUE='Continue'></TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");

		}

	}
%>

<%@ include file="../common/footer.jsp" %>
