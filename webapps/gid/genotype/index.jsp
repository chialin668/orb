<%@ include file="../common/header.jsp" %>
<%@ page import="java.util.*, com.dnas.lqt.html.*, com.dnas.lqt.data.genotype.*" %>

<%
	String command = "";

	if (request.getParameter ("command") != null)
		command = request.getParameter ("command");
%>


<%
	if (command.equals ("new"))
	{
		String sub_command = "";
		if (request.getParameter ("sub_command") != null)
			sub_command = request.getParameter ("sub_command");

		if (sub_command.equals ("getinfo"))
		{
			VariantType [] variant_types = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantTypes ();
			Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes();

			out.print ("<FORM NAME=genotype ACTION='"+application_name+"/genotype/index.jsp' METHOD='POST'>");
			%>
			<script language=javascript src="../common/util.js"></script>
			<script language=javascript>

			genes = new Array ()

			<%
				for (int i=0;i<genes.length;i++)
				{
					out.println ("genes[\""+genes[i].getGene_wid() +"\"]=\""+genes[i].getCoding_sequence_length()+"\"");
				}
			%>



			function validateForm ()
			{
				error = false
				error_string = ""

				if (trimAll(document.genotype.sample_id.value).length==0)
				{
					error_string = error_string + 'Sample ID is required\n'
					error = true
				}
				if (!validateValue( trimAll(document.genotype.sample_id.value), "^[A-Za-z0-9]+$") )
				{
					error_string = error_string + 'Sample ID can only contain the following characters A-Z, a-z and 0-9\n'
					error = true
				}
				if (trimAll(document.genotype.location.value).length==0)
				{
					error_string = error_string + 'Location is required\n'
					error = true
				}
				if (trimAll(document.genotype.offset.value).length==0)
				{
					error_string = error_string + 'Offset is required\n'
					error = true
				}
  
				if (isNaN(document.genotype.location.value) || !validateInteger (document.genotype.location.value))
				{
					error_string = error_string + 'Location must be numeric and integer\n'
					error = true
				}
  
				if (document.genotype.location.value <= 0)
				{
					error_string = error_string + 'Location must be greater than 0 and an integer\n'
					error = true
				}


				gene_wid = trimAll(document.genotype.gene_wid.options[document.genotype.gene_wid.selectedIndex].value)
				coding_sequence_length = genes[gene_wid]

				if (parseInt (document.genotype.location.value) > parseInt (coding_sequence_length))
				{
					error_string = error_string + 'Location can not be greater than length of the coding sequence (' + coding_sequence_length + ') for this gene\n'
					error = true

				}
				if (isNaN(document.genotype.offset.value) || !validateInteger(document.genotype.offset.value))
				{
					error_string = error_string + 'Offset must be numeric and integer\n'
					error = true
				}


				if (error)
				{
					alert (error_string)
					return false
				}

				document.genotype.submit()
				return true

			}
			</script>

			<%
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=genotype>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=add_genotype>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=new>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=getrestinfo>");
			out.print ("<TABLE valign=center align=center>");
			out.print ("<TR><TD><B>Sample ID:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=sample_id></TD></TR>");
			out.print ("<TR><TD><B>Gene:</B></TD><TD>"+HTMLOutput.HTMLFormatGenes (genes,null,null,false,false) + "</TD></TR>");
			out.print ("<TR><TD><B>Location:</B></TD><TD><INPUT VALUE='0' TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=location></TD></TR>");
			out.print ("<TR><TD><B>Offset:</B></TD><TD><INPUT VALUE='0' TYPE=TEXT SIZE=3 MAXLENGTH=3 NAME=offset></TD></TR>");
			out.print ("<TR><TD><INPUT TYPE=radio NAME=entrytype VALUE=genotype CHECKED><B>Enter Genotype</B></TD>");
			out.print ("<TD><INPUT TYPE=radio NAME=entrytype VALUE=allele><B>Enter Individual alleles</B></TD></TR>");
			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=2><INPUT TYPE=BUTTON onClick='validateForm()' VALUE='Continue'></TD></TR>");
			out.print ("</TABLE>");

			out.print ("</FORM>");

		}

		else if (sub_command.equals ("getrestinfo"))
		{
 
			
			VariantType [] variant_types = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantTypes ();
			Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes();

			out.print ("<FORM NAME=genotype ACTION='"+application_name+"/genotype/index.jsp' METHOD='GET'>");
			%>
			<script language=javascript src="../common/util.js"></script>
			<script language=javascript>

			function setFocus ()
			{
			}





			function validateForm ()
			{
				error = false
				error_string = ""

				if (document.genotype.entrytype.value != "genotype")
				{
					variant_type1 = trimAll(document.genotype.variant_type1_wid.options[document.genotype.variant_type1_wid.selectedIndex].text.toUpperCase())
					variant_type2 = trimAll(document.genotype.variant_type2_wid.options[document.genotype.variant_type2_wid.selectedIndex].text.toUpperCase())

					aa1 = ""
					aa2 = ""
					wild_type_aa = ""
					if (trimAll (document.genotype.offset.value) == "0")
					{
						aa1 = trimAll(document.genotype.aa1.value)
						aa2 = trimAll(document.genotype.aa2.value)
						wild_type_aa = trimAll(document.genotype.wild_type_aa.value)
					}

					
					error_string1 = validateVariant (variant_type1, 
							document.genotype.variant_length1.value, 
							document.genotype.wild_type_allele.value, 
							document.genotype.allele1.value,
							wild_type_aa,
							aa1);

					error_string2 = error_string + 
							validateVariant (variant_type2, 
							document.genotype.variant_length2.value, 
							document.genotype.wild_type_allele.value, 
							document.genotype.allele2.value,
							wild_type_aa,
							aa2)

					if (error_string1.length > 0)
						error_string = error_string + 'Errors for Variant Type 1:\n' + error_string1 + '----------------------------\n'

					if (error_string2.length > 0)
						error_string = error_string + 'Errors for Variant Type 2:\n' + error_string2 + '----------------------------\n'

					if (trimAll (error_string).length > 0)
						error = true
				}


				if (trimAll (document.genotype.quality_score.value).length > 0 && (!validateInteger (document.genotype.quality_score.value) || parseInt (document.genotype.quality_score.value)<0))
				{
					error_string = error_string + 'Quality Score must be an integer between the range [0-999]\n'
					error = true
				}

				if (error)
				{
					alert (error_string)
					return false
				}

				if (confirm ('Is the information you have entered correct?  Press OK to continue'))
				{
					if (document.genotype.entrytype.value == "genotype")
					{
						document.genotype.allele1.disabled = false
						document.genotype.allele2.disabled = false
					
						if (trimAll (document.genotype.offset.value) == "0")
						{
							document.genotype.aa1.disabled = false
							document.genotype.aa2.disabled = false
						}
					}
					document.genotype.submit()
					return true
				}
				else
					return false
			}
			</script>

			<%
			String sample_id = request.getParameter ("sample_id");
			String entrytype = request.getParameter ("entrytype");
			String gene_wid = request.getParameter ("gene_wid");
			String location = request.getParameter ("location");
			String offset = request.getParameter ("offset");

			Gene g = null;

			for (int i=0;i<genes.length;i++)
			{
				if (genes[i].getGene_wid().equals(gene_wid))
					g = genes[i];
			}


			out.print ("<INPUT TYPE=HIDDEN NAME=sample_id VALUE="+sample_id+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=gene_wid VALUE="+gene_wid+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=location VALUE="+location+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=offset VALUE="+offset+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=genotype>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=add_genotype>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=new>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=add>");
			out.print ("<INPUT TYPE=HIDDEN NAME=entrytype VALUE="+entrytype+">");

			out.print ("<TABLE valign=center align=center>");
			out.print ("<TR><TD><B>Sample ID:</B></TD><TD>"+sample_id+"</TD></TR>");
			out.print ("<TR><TD><B>Gene:</B></TD><TD>"+ g.getGene_name()+ "</TD></TR>");
			out.print ("<TR><TD><B>Location:</B></TD><TD>"+location+"</TD></TR>");
			out.print ("<TR><TD><B>Offset:</B></TD><TD>"+offset+"</TD></TR>");

			if (entrytype.equals ("genotype"))
			{
				out.print ("<TR><TD><B>Variant Length:</B></TD><TD>1</TD></TR>");
				out.print ("<INPUT TYPE=HIDDEN VALUE=1 NAME=variant_length1>");
				out.print ("<INPUT TYPE=HIDDEN VALUE=1 NAME=variant_length2>");


				if (Integer.parseInt (offset) == 0)
				{
					String wild_type_allele = String.valueOf(g.getWild_type(Integer.parseInt (location)));
					String wild_type_aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),wild_type_allele.charAt(0)));
					out.print ("<TR><TD><B>Wild Type Allele</B></TD><TD>"+wild_type_allele+"</TD></TR>");
					out.print ("<TR><TD><B>Wild Type AA</B></TD><TD>"+wild_type_aa+"</TD></TR>");
					out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_allele VALUE="+wild_type_allele+">");
					out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_aa VALUE="+wild_type_aa+">");
				}
				else
				{
					out.print ("<TR><TD><B>Wild Type Allele:</B></TD><TD>"+ HTMLOutput.HTMLFormatNucleotideChange (new String [] {"A","C","T","G"}, null,"wild_type_allele","mutant_allele_changed()")+"</TD></TR>");
				}

				out.print ("<INPUT TYPE=HIDDEN NAME=variant_type1_wid>");
				out.print ("<INPUT TYPE=HIDDEN NAME=variant_type2_wid>");
				out.print ("<TR><TD><B>Mutant Allele:</B></TD><TD>"+HTMLOutput.HTMLFormatNucleotideChange (Gene.getNucleotideChanges (),null,"nucleotide_change","mutant_allele_changed()")+"</TD></TR>");
				out.print ("<TR><TD><B>Variant Type 1:</B></TD><TD><INPUT SIZE=10 MAXLENGTH=10 TYPE=TEXT NAME=varianttype1></TD>");
				out.print ("<TD><B>Variant Type 2:</B></TD><TD><INPUT SIZE=10 MAXLENGTH=10 TYPE=TEXT NAME=varianttype2></TD></TR>");
				out.print ("<TR><TD><B>Allele 1:</B></TD><TD><INPUT SIZE=1 MAXLENGTH=1 TYPE=TEXT NAME=allele1></TD>");
				out.print ("<TD><B>Allele 2:</B></TD><TD><INPUT  SIZE=1 MAXLENGTH=1 TYPE=TEXT NAME=allele2></TD></TR>");

				if (Integer.parseInt (offset) == 0)
				{
					out.print ("<TR><TD><B>AA 1:</B></TD><TD><INPUT  SIZE=1 MAXLENGTH=1 TYPE=TEXT NAME=aa1></TD>");
					out.print ("<TD><B>AA 2:</B></TD><TD><INPUT  SIZE=1 MAXLENGTH=1 TYPE=TEXT NAME=aa2></TD></TR>");
				}

				// generate our javascript arrays
				// One for our amino acids bases corresponding to A,C,T,G at the specified location for this gene
				out.print ("<PRE><script language = \"javascript\">");
				%>
				function setFocus ()
				{
					document.genotype.allele1.disabled = true
					document.genotype.allele2.disabled = true
					
					if (trimAll (document.genotype.offset.value) == "0")
					{
						document.genotype.aa1.disabled = true
						document.genotype.aa2.disabled = true
					}
					document.genotype.varianttype1.disabled = true
					document.genotype.varianttype2.disabled = true

					mutant_allele_changed ()
				}

				function allele_mapping (allele1, allele2)
				{
					this.allele1 = allele1
					this.allele2 = allele2
				}

				function mutant_allele_changed ()
				{
					document.genotype.allele1.disabled = false
					document.genotype.allele2.disabled = false

					if (trimAll (document.genotype.offset.value) == "0")
					{
						document.genotype.aa1.disabled = false
						document.genotype.aa2.disabled = false
					}

					document.genotype.varianttype1.disabled = false
					document.genotype.varianttype2.disabled = false
					mutant_allele = trimAll(document.genotype.nucleotide_change.options[document.genotype.nucleotide_change.selectedIndex].value.toUpperCase())
					am = nucleotide_changes[mutant_allele]

					if (trimAll (document.genotype.wild_type_allele.value) == am.allele1)
					{
						variant_type1_wid = variant_types["WILD TYPE"]
						document.genotype.varianttype1.value = "Wild Type"
						document.genotype.variant_type1_wid.value = variant_type1_wid
					}
					else
					{
						variant_type1_wid = variant_types["MUTATION"]
						document.genotype.varianttype1.value = "Mutation"
						document.genotype.variant_type1_wid.value = variant_type1_wid
					}

					if (trimAll (document.genotype.wild_type_allele.value) == am.allele2)
					{
						variant_type2_wid = variant_types["WILD TYPE"]
						document.genotype.varianttype2.value = "Wild Type"
						document.genotype.variant_type2_wid.value = variant_type2_wid
					}
					else
					{
						variant_type2_wid = variant_types["MUTATION"]
						document.genotype.varianttype2.value = "Mutation"
						document.genotype.variant_type2_wid.value = variant_type2_wid
					}
					document.genotype.allele1.value = am.allele1
					document.genotype.allele2.value = am.allele2
													
					if (trimAll (document.genotype.offset.value) == "0")
					{
						document.genotype.aa1.value = amino_acids[am.allele1]
						document.genotype.aa2.value = amino_acids[am.allele2]
						document.genotype.aa1.disabled = true
						document.genotype.aa2.disabled = true
					}
					document.genotype.allele1.disabled = true
					document.genotype.allele2.disabled = true
					document.genotype.varianttype1.disabled = true
					document.genotype.varianttype2.disabled = true

				}

				nucleotide_changes = new Array()
				amino_acids = new Array()
				variant_types = new Array()
			
				<%
				String [] nucleotide_changes = Gene.getNucleotideChanges();

				for (int i=0;i<variant_types.length;i++)
				{
					out.println ("variant_types[\""+variant_types[i].getType().toUpperCase()+"\"]=\""+variant_types[i].getVariant_type_wid()+"\"");
				}

				for (int i=0;i<nucleotide_changes.length;i++)
				{
					String nucleotide_change = nucleotide_changes[i];
					String allele1 = Gene.getAllele1 (nucleotide_change);
					String allele2 = Gene.getAllele2 (nucleotide_change);
					out.println ("nucleotide_changes[\""+nucleotide_change+"\"]=new allele_mapping(\""+allele1+"\",\""+allele2+"\")");
				}

				if (Integer.parseInt (offset) == 0)
				{
					String aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),'A'));
					out.println ("amino_acids[\"A\"]=\""+aa+"\"");
					aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),'C'));
					out.println ("amino_acids[\"C\"]=\""+aa+"\"");
					aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),'T'));
					out.println ("amino_acids[\"T\"]=\""+aa+"\"");
					aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),'G'));
					out.println ("amino_acids[\"G\"]=\""+aa+"\"");
				}
				out.println ("</script></PRE>");
			}
			else
			{
				if (Integer.parseInt (offset) == 0)
				{
					String wild_type_allele = String.valueOf(g.getWild_type(Integer.parseInt (location)));
					String wild_type_aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),wild_type_allele.charAt(0)));
					out.print ("<TR><TD><B>Wild Type Allele</B></TD><TD>"+wild_type_allele+"</TD></TR>");
					out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_allele VALUE="+wild_type_allele+">");
					out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_aa VALUE="+wild_type_aa+">");
					out.print ("<TR><TD><B>Wild Type AA</B></TD><TD>"+wild_type_aa+"</TD></TR>");
				}
				else
					out.print ("<TR><TD><B>Wild Type Allele:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=wild_type_allele></TD></TR>");

				// generate our javascript arrays
				// One for our amino acids bases corresponding to A,C,T,G at the specified location for this gene
				%>
				<PRE><script language = "javascript">
				function variantType1Changed ()
				{
					variant_type = document.genotype.variant_type1_wid.options[document.genotype.variant_type1_wid.selectedIndex].text.toUpperCase()

					if (variant_type == "DELETION")
					{
						document.genotype.allele1.value = ''
						document.genotype.allele1.disabled = true
						if (trimAll (document.genotype.offset.value) == "0")
						{
							document.genotype.aa1.value = ''
							document.genotype.aa1.disabled = true
						}
					}
					else
					{
						document.genotype.allele1.disabled = false
						if (trimAll (document.genotype.offset.value) == "0")
						{
							document.genotype.aa1.disabled = false
						}
			
					}
				}

				function variantType2Changed ()
				{
					variant_type = document.genotype.variant_type2_wid.options[document.genotype.variant_type2_wid.selectedIndex].text.toUpperCase()

					if (variant_type == "DELETION")
					{
						document.genotype.allele2.value = ''
						document.genotype.allele2.disabled = true
						if (trimAll (document.genotype.offset.value) == "0")
						{
							document.genotype.aa2.value = ''
							document.genotype.aa2.disabled = true
						}
					}
					else
					{
						document.genotype.allele2.disabled = false
						if (trimAll (document.genotype.offset.value) == "0")
						{
							document.genotype.aa2.disabled = false
						}
			
					}
				}
				</script>
				<%

				out.print ("<TR><TD><B>Variant Length 1:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=variant_length1></TD>");				
				out.print ("<TD><B>Variant Length 2:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=variant_length2></TD></TR>");				
				out.print ("<TR><TD><B>Variant Type 1:</B></TD><TD>"+HTMLOutput.HTMLFormatVariantTypes (variant_types,null,"variantType1Changed()","variant_type1_wid",true)+"</TD>");
				out.print ("<TD><B>Variant Type 2:</B></TD><TD>"+HTMLOutput.HTMLFormatVariantTypes (variant_types,null,"variantType2Changed()","variant_type2_wid",true)+"</TD></TR>");
				out.print ("<TR><TD><B>Allele 1:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=allele1></TD>");
				out.print ("<TD><B>Allele 2:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=allele2></TD></TR>");

				if (Integer.parseInt (offset) == 0)
				{
					out.print ("<TR><TD><B>AA 1:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=aa1></TD>");
					out.print ("<TD><B>AA 2:</B></TD><TD><INPUT TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=aa2></TD></TR>");
				}
			}
			out.print ("<TR><TD><B>Quality Score:</B></TD><TD><INPUT TYPE=TEXT SIZE=3 MAXLENGTH=3 NAME=quality_score></TD></TR>");
			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=2><INPUT TYPE=BUTTON onClick='validateForm()' VALUE='Add Genotype'></TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}
		else if (sub_command.equals ("add"))
		{

			VariantType [] variant_types = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantTypes ();
			Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes();


			String sample_id = request.getParameter ("sample_id");
			String gene_wid = request.getParameter ("gene_wid");
			String variant_type1_wid = request.getParameter ("variant_type1_wid");
			String variant_type2_wid = request.getParameter ("variant_type2_wid");
			String variant_length1 = request.getParameter ("variant_length1").toUpperCase();
			String variant_length2 = request.getParameter ("variant_length2").toUpperCase();
			String location = request.getParameter ("location");
			String offset = request.getParameter ("offset");
			String nucleotide_change = request.getParameter ("nucleotide_change");
			String quality_score = request.getParameter ("quality_score");

			if (quality_score != null)
				quality_score = quality_score.trim();

			String wild_type_allele = "";
			String allele1 = "";
			String allele2 = "";
			String aa1 = "";
			String aa2 = "";
			String wild_type_aa = "";



			Genotype gt = new Genotype ();


 			gt.setUser_wid(USER.getUserwid());
 			gt.setSample_id(sample_id);
 			gt.setLocation(location);
 			gt.setOffset(offset);
 			gt.setQuality_score(quality_score);
			gt.setVariant_length1 (variant_length1);
			gt.setVariant_length2 (variant_length2);


			for (int i=0;i<genes.length;i++)
			{
				if (genes[i].getGene_wid().equals (gene_wid))
					gt.setGene (genes[i]);
			}

			if (request.getParameter ("wild_type_allele") != null)
				wild_type_allele = request.getParameter ("wild_type_allele").toUpperCase();

			if (request.getParameter ("allele1") != null)
				allele1 = request.getParameter ("allele1").toUpperCase();

			if (request.getParameter ("allele2") != null)
				allele2 = request.getParameter ("allele2").toUpperCase();

			if (request.getParameter ("aa1") != null)
				aa1 = request.getParameter ("aa1").toUpperCase();

			if (request.getParameter ("aa2") != null)
				aa2 = request.getParameter ("aa2").toUpperCase();

			if (request.getParameter ("wild_type_aa") != null)
				wild_type_aa = request.getParameter ("wild_type_aa").toUpperCase();

			for (int i=0;variant_types!=null&&i<variant_types.length;i++)
			{
				if (variant_types[i].getVariant_type_wid().equals (variant_type1_wid))
					gt.setVariant_type1 (variant_types[i]);
				if (variant_types[i].getVariant_type_wid().equals (variant_type2_wid))
					gt.setVariant_type2 (variant_types[i]);
			}



			gt.setWild_type_allele (wild_type_allele);
			gt.setAllele1 (allele1);
			gt.setAllele2 (allele2);

			gt.setWild_type_aa (wild_type_aa);
			gt.setAa1 (aa1);
			gt.setAa2 (aa2);

			((GenotypeDataAccess)DATA_ACCESS_LAYER).addGenotype(gt);
 
			out.print ("<FORM ACTION='"+application_name+"/genotype/index.jsp?section=genotype&sub_section=add_genotype&command=new&sub_command=getinfo' METHOD='POST'>");
			out.print ("<TABLE valign=center align=center >");
			out.print("<TR><TD>Genotype Successfully Added!</TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("<TR><TD><INPUT TYPE=SUBMIT VALUE='Continue'></TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}

	}	
	else if (command.equals ("view_genotypes") || command.equals ("view_all_genotypes"))
	{
		String sample_id = "";

		if (request.getParameter ("selected_sample_id") != null)
			sample_id = request.getParameter ("selected_sample_id");

		// get a list of our sample ids
		String [] sample_ids = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getSample_ids ();

		out.println ("<FORM NAME=view_genotypes ACTION="+application_name+"/genotype/index.jsp ACTION=POST>");
		out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=genotype>");

		if (command.equals ("view_genotypes"))
		{
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=view_genotypes>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=view_genotypes>");
		}
		else if (command.equals ("view_all_genotypes"))
		{
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=view_all_genotypes>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=view_all_genotypes>");
		}
		out.print ("<TABLE><TR>");
		out.print ("<TD><B>Please input a sample id: </B></TD>");
		out.print ("<TD><INPUT TYPE=TEXT NAME=selected_sample_id VALUE='"+sample_id+"' SIZE=10 MAXLENGTH=10></TD>");
		out.print ("<TD><B>or choose</B> --></TD>");
		out.print ("<TD>"+HTMLOutput.HTMLFormatSample_ids (sample_ids,sample_id,"onChange=\"document.view_genotypes.selected_sample_id.value=document.view_genotypes.sample_id.options[document.view_genotypes.sample_id.selectedIndex].value\" ",false,true)+"</TD>");
		out.print ("<TD><INPUT TYPE=SUBMIT VALUE='View Genotypes'></TD>");
		out.print ("</TR></TABLE>");
		out.print ("</FORM>");

		boolean newQuerySelected = false;

		if (request.getSession().getAttribute("CURRENT_GENOTYPE_SAMPLE_ID")!=null)
		{
			String current_sample_id = (String)request.getSession().getAttribute ("CURRENT_GENOTYPE_SAMPLE_ID");
			if (!current_sample_id.equals (sample_id))
			{
				newQuerySelected = true;
				request.getSession().setAttribute ("CURRENT_GENOTYPE_SAMPLE_ID",sample_id);
			}
		}
		else
		{
			newQuerySelected = true;
			request.getSession().setAttribute ("CURRENT_GENOTYPE_SAMPLE_ID",sample_id);
		}

		if (newQuerySelected || request.getSession().getAttribute("GENOTYPE_HTML_TABLE") == null || ((GenotypeDataAccess)DATA_ACCESS_LAYER).isGenotypeDataDirty())
		{


			// get a list of our samples by userID UNLESS we are supervisor
			// in which case we get ALL genotypes
			Genotype [] genotypes = null;

			if (command.equals ("view_genotypes"))
				genotypes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenotypes (USER.getUserwid(),sample_id);
			else if (command.equals ("view_all_genotypes"))
				genotypes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenotypes (sample_id);
 
			// create an html table with all column descipriptors
      			HTMLTable table = new HTMLTable ();

			if (command.equals ("view_genotypes"))
			{
				String SORT_ACTION = application_name+"/genotype/index.jsp?section=genotype&sub_section=view_genotypes&command=view_genotypes&selected_sample_id="+sample_id;
      				HTMLTableColumn [] columns = {
					new HTMLTableColumn ("Gene",SORT_ACTION+"&sort_index=0",true,true,100,String.class, new int [] {0} ),
					new HTMLTableColumn ("Location",SORT_ACTION+"&sort_index=1",true,true,100,Integer.class, new int [] {0,1}),
					new HTMLTableColumn ("Offset",""+SORT_ACTION+"&sort_index=2",true,true,100,Integer.class, new int [] {0,1,2}),
					new HTMLTableColumn ("Quality Score",SORT_ACTION+"&sort_index=3",true,true,100,String.class, new int [] {0,3}),
					new HTMLTableColumn ("Variant Type 1",SORT_ACTION+"&sort_index=4",true,true,100,String.class, new int [] {0,4}),
					new HTMLTableColumn ("Variant Length 1",SORT_ACTION+"&sort_index=5",true,true,100,String.class, new int [] {0,5}),
					new HTMLTableColumn ("Variant Type 2",SORT_ACTION+"&sort_index=6",true,true,100,String.class, new int [] {0,6}),
					new HTMLTableColumn ("Variant Length 2",SORT_ACTION+"&sort_index=7",true,true,100,String.class, new int [] {0,7}),
					new HTMLTableColumn ("Wild Type Allele",SORT_ACTION+"&sort_index=8",true,true,100,String.class, new int [] {0,8}),
					new HTMLTableColumn ("Allele 1",SORT_ACTION+"&sort_index=9",true,true,100,String.class,new int [] {0,9}),
					new HTMLTableColumn ("Allele 2",SORT_ACTION+"&sort_index=10",true,true,100,String.class, new int [] {0,10}),
					new HTMLTableColumn ("Wild Type AA",SORT_ACTION+"&sort_index=11",true,true,100,String.class, new int [] {0,11}),
					new HTMLTableColumn ("AA1",SORT_ACTION+"&sort_index=12",true,true,100,String.class, new int [] {0,12}),
					new HTMLTableColumn ("AA2",SORT_ACTION+"&sort_index=13",true,true,100,String.class, new int [] {0,13})

	      			};
      				table.setColumns(columns,"Current Genotypes");
			}
			else if (command.equals ("view_all_genotypes"))
			{
				String SORT_ACTION= application_name+"/genotype/index.jsp?section=genotype&sub_section=view_all_genotypes&command=view_all_genotypes&selected_sample_id="+sample_id;
      				HTMLTableColumn [] columns = {
					new HTMLTableColumn ("Gene",SORT_ACTION+"&sort_index=0",true,true,100,String.class, new int [] {0} ),
					new HTMLTableColumn ("Location",SORT_ACTION+"&sort_index=1",true,true,100,Integer.class, new int [] {0,1}),
					new HTMLTableColumn ("Offset",""+SORT_ACTION+"&sort_index=2",true,true,100,Integer.class, new int [] {0,1,2}),
					new HTMLTableColumn ("User Name",SORT_ACTION+"&sort_index=3",true,true,100,String.class,new int [] {0,3}),
					new HTMLTableColumn ("Quality Score",SORT_ACTION+"&sort_index=4",true,true,100,String.class, new int [] {0,4}),
					new HTMLTableColumn ("Variant Type 1",SORT_ACTION+"&sort_index=5",true,true,100,String.class, new int [] {0,5}),
					new HTMLTableColumn ("Variant Length 1",SORT_ACTION+"&sort_index=6",true,true,100,String.class, new int [] {0,6}),
					new HTMLTableColumn ("Variant Type 2",SORT_ACTION+"&sort_index=7",true,true,100,String.class, new int [] {0,7}),
					new HTMLTableColumn ("Variant Length 2",SORT_ACTION+"&sort_index=8",true,true,100,String.class, new int [] {0,8}),
					new HTMLTableColumn ("Wild Type Allele",SORT_ACTION+"&sort_index=9",true,true,100,String.class, new int [] {0,9}),
					new HTMLTableColumn ("Allele 1",SORT_ACTION+"&sort_index=10",true,true,100,String.class,new int [] {0,10}),
					new HTMLTableColumn ("Allele 2",SORT_ACTION+"&sort_index=11",true,true,100,String.class, new int [] {0,11}),
					new HTMLTableColumn ("Wild Type AA",SORT_ACTION+"&sort_index=12",true,true,100,String.class, new int [] {0,12}),
					new HTMLTableColumn ("AA1",SORT_ACTION+"&sort_index=13",true,true,100,String.class, new int [] {0,13}),
					new HTMLTableColumn ("AA2",SORT_ACTION+"&sort_index=14",true,true,100,String.class, new int [] {0,14})

	      			};
      				table.setColumns(columns,"Current Genotypes");
			}
			

			// now create all our row objects

			for (int i=0;genotypes!=null&&i<genotypes.length;i++)
			{


				if (command.equals ("view_genotypes"))
				{
					table.addRow (new HTMLTableRow ( new Object [] {
						genotypes[i].getGene().getGene_name(),
						new Integer (genotypes[i].getLocation ()),
						new Integer (genotypes[i].getOffset ()),
						genotypes[i].getQuality_score (),
						genotypes[i].getVariant_type1().getType (),
						genotypes[i].getVariant_length1(),
						genotypes[i].getVariant_type2().getType (),
						genotypes[i].getVariant_length2(),
						genotypes[i].getWild_type_allele (),
						genotypes[i].getAllele1(),
						genotypes[i].getAllele2(),
						HTMLOutput.HTMLFormatAminoAcid(genotypes[i].getWild_type_aa()),
						HTMLOutput.HTMLFormatAminoAcid(genotypes[i].getAa1()),
						HTMLOutput.HTMLFormatAminoAcid(genotypes[i].getAa2())
					
					},null));
				}
				else if (command.equals ("view_all_genotypes"))
				{
					String user_wid = genotypes[i].getUser_wid();
					User u = DATA_ACCESS_LAYER.getUser (user_wid);

					String username = "";

					if (u != null)
						username = u.getUsername();
					else
						username = "N/A";

					table.addRow (new HTMLTableRow ( new Object [] {
						genotypes[i].getGene().getGene_name(),
						new Integer (genotypes[i].getLocation ()),
						new Integer (genotypes[i].getOffset ()),
						username,
						genotypes[i].getQuality_score (),
						genotypes[i].getVariant_type1().getType (),
						genotypes[i].getVariant_length1(),
						genotypes[i].getVariant_type2().getType (),
						genotypes[i].getVariant_length2(),
						genotypes[i].getWild_type_allele (),
						genotypes[i].getAllele1(),
						genotypes[i].getAllele2(),
						HTMLOutput.HTMLFormatAminoAcid(genotypes[i].getWild_type_aa()),
						HTMLOutput.HTMLFormatAminoAcid(genotypes[i].getAa1()),
						HTMLOutput.HTMLFormatAminoAcid(genotypes[i].getAa2())
					
					},null));
				}
			}



			request.getSession().setAttribute ("GENOTYPE_HTML_TABLE",table);
			((GenotypeDataAccess)DATA_ACCESS_LAYER).setGenotypeDataDirty (false);
		}
		HTMLTable table = (HTMLTable)request.getSession().getAttribute ("GENOTYPE_HTML_TABLE");

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

%>
<%@ include file="../common/footer.jsp" %>