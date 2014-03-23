<%@ include file="../common/header.jsp" %>
<%@ page import="java.util.*, com.dnas.lqt.data.genotype.*, com.dnas.lqt.html.* "%>

<script language=javascript src="../common/util.js"></script>
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

			out.print ("<FORM NAME=variant_info ACTION='"+application_name+"/variantinfo/index.jsp' METHOD='POST'>");
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

			function setFocus ()
			{
				document.variant_info.location.focus()
			}


			function validateForm ()
			{
				error = false
				error_string = ""

				if (trimAll(document.variant_info.location.value).length==0)
				{
					error_string = error_string + 'Location is required\n'
					error = true
				}
				if (trimAll(document.variant_info.offset.value).length==0)
				{
					error_string = error_string + 'Offset is required\n'
					error = true
				}
  
				if (isNaN(document.variant_info.location.value) || !validateInteger (document.variant_info.location.value))
				{
					error_string = error_string + 'Location must be numeric and integer\n'
					error = true
				}
  
				if (document.variant_info.location.value <= 0)
				{
					error_string = error_string + 'Location must be greater than 0 and an integer\n'
					error = true
				}


				gene_wid = trimAll(document.variant_info.gene_wid.options[document.variant_info.gene_wid.selectedIndex].value)
				coding_sequence_length = genes[gene_wid]

				if (parseInt (document.variant_info.location.value) > parseInt (coding_sequence_length))
				{
					error_string = error_string + 'Location can not be greater than length of the coding sequence (' + coding_sequence_length + ') for this gene\n'
					error = true

				}
				if (isNaN(document.variant_info.offset.value) || !validateInteger(document.variant_info.offset.value))
				{
					error_string = error_string + 'Offset must be numeric and integer\n'
					error = true
				}


				if (error)
				{
					alert (error_string)
					return false
				}

				document.variant_info.submit()
				return true

			}
			</script>

			<%
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=variantinfo>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=add_variantinfo>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=new>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=getrestinfo>");
			out.print ("<TABLE valign=center align=center>");
			out.print ("<TR><TD><B>Gene:</B></TD><TD>"+HTMLOutput.HTMLFormatGenes (genes,null,null,false,false) + "</TD></TR>");
			out.print ("<TR><TD><B>Variant Type:</B></TD><TD>"+HTMLOutput.HTMLFormatVariantTypes (variant_types,null,null,false)+"</TD></TR>");
			out.print ("<TR><TD><B>Location:</B></TD><TD><INPUT VALUE='0' TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=location></TD></TR>");
			out.print ("<TR><TD><B>Offset:</B></TD><TD><INPUT VALUE='0' TYPE=TEXT SIZE=3 MAXLENGTH=3 NAME=offset></TD></TR>");
			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=2><INPUT TYPE=BUTTON onClick='validateForm()' VALUE='Continue'></TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");

		}

		else if (sub_command.equals ("getrestinfo"))
		{

			%>
			<script language=javascript>
			function setFocus ()
			{
				document.variant_info.phenotype.focus()
			}

 
			function validateForm ()
			{
				error = false
				error_string = ""
		

				if (trimAll(document.variant_info.variant_length.value).length == 0)
				{
					error_string = error_string + 'Variant Length is a required field\n'
					error = true
				}
				if (trimAll(document.variant_info.location.value).length == 0)
				{
					error_string = error_string + 'Location is a required field\n'
					error = true
				}

				if (trimAll(document.variant_info.offset.value).length == 0)
				{
					error_string = error_string + 'Offset is a required field\n'
					error = true
				}
 
				if (trimAll(document.variant_info.phenotype.value).length == 0)
				{
					error_string = error_string + 'Phenotype is a required field\n'
					error = true
				}
				if (trimAll(document.variant_info.reference.value).length == 0)
				{
					error_string = error_string + 'Reference is a required field\n'
					error = true
				}

				
				if (isNaN(document.variant_info.location.value) || !validateInteger (document.variant_info.location.value))
				{
					error_string = error_string + 'Location must be numeric and integer\n'
					error = true
				}
				if (isNaN(document.variant_info.offset.value) || !validateInteger (document.variant_info.offset.value))
				{
					error_string = error_string + 'Offset must be numeric and integer\n'
					error = true
				}
				if (trimAll(document.variant_info.allele_frequency.value).length >0)
				{
					if (isNaN(document.variant_info.allele_frequency.value))
					{
						error_string = error_string + 'Allele Frequency must be numeric\n'
						error = true
					}

					value = parseFloat (document.variant_info.allele_frequency.value)
					if ( value <= 0.0 || value > 1.0)
					{
						error_string = error_string + 'Allele Frequency must be within the range [ 0 < frequency <= 1.0 ]\n'
						error = true
					}
				}

				if (trimAll(document.variant_info.lod_score.value).length >0)
				{
					if (isNaN(document.variant_info.lod_score.value))
					{
						error_string = error_string + 'LOD Score must be numeric\n'
						error = true
					}

					value = parseFloat (document.variant_info.lod_score.value)
					if ( value < -999.99 || value > 999.99)
					{
						error_string = error_string + 'LOD Score must be within the range [ -999.99 <= LOD Score <= 999.99 ]\n'
						error = true
					}
				}
	
				if (document.variant_info.location.value <= 0)
				{
					error_string = error_string + 'Location must be greater than 0\n'
					error = true
				}

	
				error_string = error_string + validateVariant (
					document.variant_info.variant_type.value, 
					document.variant_info.variant_length.value, 
					document.variant_info.wild_type_allele.value, 
					document.variant_info.mutant_allele.value,
					document.variant_info.wild_type_aa.value, 
					document.variant_info.mutant_aa.value )

				if (error_string.length > 0)
					error = true
	

				if (error)
				{
					alert (error_string)
					return false
				}
				if (confirm ('Is the information you have entered correct?  Press OK to continue'))
				{

					document.variant_info.wild_type_allele.disabled = false
					document.variant_info.wild_type_aa.disabled = false
					document.variant_info.mutant_allele.disabled = false
					document.variant_info.mutant_aa.disabled = false
					document.variant_info.variant_length.disabled = false

					document.variant_info.submit()
					return true
				}
				return false
	
			}



			</script>
			<%
 
			
			VariantType [] variant_types = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantTypes ();
			Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes();

			out.print ("<FORM NAME=variant_info ACTION='"+application_name+"/variantinfo/index.jsp' METHOD='POST'>");
			String gene_wid = request.getParameter ("gene_wid");
			String variant_type_wid = request.getParameter ("variant_type_wid");
			String location = request.getParameter ("location");
			String offset = request.getParameter ("offset");

			Gene g = null;
			VariantType vt = null;

			for (int i=0;i<genes.length;i++)
			{
				if (genes[i].getGene_wid().equals(gene_wid))
					g = genes[i];
			}

			for (int i=0;i<variant_types.length;i++)
			{
				if (variant_types[i].getVariant_type_wid().equals(variant_type_wid))
					vt = variant_types[i];
			}

			out.print ("<INPUT TYPE=HIDDEN NAME=variant_type VALUE='"+vt.getType().toUpperCase()+"'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=gene_wid VALUE="+gene_wid+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=variant_type_wid VALUE="+variant_type_wid+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=location VALUE="+location+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=offset VALUE="+offset+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=variant_info>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=add_variant_info>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=new>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=add>");

			out.print ("<TABLE valign=center align=center>");
			out.print ("<TR><TD><B>Gene:</B></TD><TD>"+ g.getGene_name()+ "</TD></TR>");
			out.print ("<TR><TD><B>Variant Type:</B></TD><TD>"+vt.getType()+"</TD></TR>");
			out.print ("<TR><TD><B>Location:</B></TD><TD>"+location+"</TD></TR>");
			out.print ("<TR><TD><B>Offset:</B></TD><TD>"+offset+"</TD></TR>");

			out.print ("<TR><TD><B>Phenotype:</B></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=phenotype></TD></TR>");
			if (vt.getType().toUpperCase().equals ("MUTATION"))
			{
				out.print ("<TR><TD><B>Variant Length:</B></TD><TD>1</TD></TR>");
				out.print ("<INPUT TYPE=HIDDEN VALUE=1 NAME=variant_length>");


				if (Integer.parseInt (offset) == 0)
				{
					String wild_type_allele = String.valueOf(g.getWild_type(Integer.parseInt (location)));
					String wild_type_aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),wild_type_allele.charAt(0)));
					out.print ("<TR><TD><B>Wild Type Allele</B></TD><TD>"+wild_type_allele+"</TD></TR>");
					out.print ("<TR><TD><B>Wild Type AA</B></TD><TD>"+wild_type_aa+"</TD></TR>");
					out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_allele VALUE="+wild_type_allele+">");
					out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_aa VALUE="+wild_type_aa+">");

					// generate our javascript arrays
					// One for our amino acids bases corresponding to A,C,T,G at the specified location for this gene
					out.print ("<PRE><script language = \"javascript\">");
					%>
					function setFocus ()
					{
						document.variant_info.phenotype.focus()
						document.variant_info.mutant_aa.disabled = true
						mutant_allele_changed ()
					}


					function mutant_allele_changed ()
					{

						document.variant_info.mutant_aa.disabled = false
						mutant_allele = trimAll(document.variant_info.mutant_allele.options[document.variant_info.mutant_allele.selectedIndex].value.toUpperCase())
						document.variant_info.mutant_aa.value = amino_acids[mutant_allele]
						document.variant_info.mutant_aa.disabled = true

					}

					amino_acids = new Array()
			
					<%

					String aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),'A'));
					out.println ("amino_acids[\"A\"]=\""+aa+"\"");
					aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),'C'));
					out.println ("amino_acids[\"C\"]=\""+aa+"\"");
					aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),'T'));
					out.println ("amino_acids[\"T\"]=\""+aa+"\"");
					aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),'G'));
					out.println ("amino_acids[\"G\"]=\""+aa+"\"");
					out.println ("</script></PRE>");

				}
				else
				{
					out.print ("<TR><TD><B>Wild Type Allele:</B></TD><TD>"+ HTMLOutput.HTMLFormatNucleotideChange (new String [] {"A","C","T","G"}, null,"wild_type_allele",null)+"</TD></TR>");
					out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_aa VALUE=''>");
				}
				
				if (Integer.parseInt (offset) == 0)
				{
					out.print ("<TR><TD><B>Mutant Allele:</B></TD><TD>"+ HTMLOutput.HTMLFormatNucleotideChange (new String [] {"A","C","T","G"}, null,"mutant_allele","mutant_allele_changed()")+"</TD></TR>");
					out.print ("<TR><TD><B>Mutant AA</B></TD><TD><INPUT TYPE=TEXT NAME=mutant_aa SIZE=1 MAXLENGTH=1></TD></TR>");
				}
				else
				{
					out.print ("<TR><TD><B>Mutant Allele:</B></TD><TD>"+ HTMLOutput.HTMLFormatNucleotideChange (new String [] {"A","C","T","G"}, null,"mutant_allele",null)+"</TD></TR>");
					out.print ("<INPUT TYPE=HIDDEN NAME=mutant_aa VALUE=''>");
				}


			}
			else
			{
				out.print ("<TR><TD><B>Variant Length</B></TD><TD><INPUT TYPE=TEXT NAME=variant_length SIZE=10 MAXLENGTH=10></TD></TR>");

				if (vt.getType().toUpperCase().equals ("DELETION"))
				{
					if (Integer.parseInt (offset) == 0)
					{
						String wild_type_allele = String.valueOf(g.getWild_type(Integer.parseInt (location)));
						String wild_type_aa = String.valueOf(g.getAmino_acid (Integer.parseInt(location),wild_type_allele.charAt(0)));
						out.print ("<TR><TD><B>Wild Type Allele</B></TD><TD>"+wild_type_allele+"</TD></TR>");

						out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_allele VALUE="+wild_type_allele+">");
						out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_aa VALUE="+wild_type_aa+">");
						out.print ("<INPUT TYPE=HIDDEN NAME=mutant_allele VALUE=''>");
						out.print ("<INPUT TYPE=HIDDEN NAME=mutant_aa VALUE=''>");

						out.print ("<TR><TD><B>Wild Type AA</B></TD><TD>"+wild_type_aa+"</TD></TR>");
					}
					else
					{
						out.print ("<INPUT TYPE=HIDDEN NAME=mutant_allele VALUE=''>");
						out.print ("<INPUT TYPE=HIDDEN NAME=mutant_aa VALUE=''>");
						out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_aa VALUE=''>");

						out.print ("<TR><TD><B>Wild Type Allele:</B></TD><TD><INPUT TYPE=TEXT NAME=wild_type_allele SIZE=10 MAXLENGTH=10></TD></TR>");
					}
				}
				if (vt.getType().toUpperCase().equals ("INSERTION"))
				{
					if (Integer.parseInt (offset) == 0)
					{
						out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_allele VALUE=''>");
						out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_aa VALUE=''>");
						out.print ("<TR><TD><B>Mutant Allele:</B></TD><TD><INPUT TYPE=TEXT NAME=mutant_allele SIZE=10 MAXLENGTH=10></TD></TR>");
						out.print ("<TR><TD><B>Mutant AA:</B></TD><TD><INPUT TYPE=TEXT NAME=mutant_aa SIZE=10 MAXLENGTH=10></TD></TR>");
					}
					else
					{
						out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_allele VALUE=''>");
						out.print ("<INPUT TYPE=HIDDEN NAME=wild_type_aa VALUE=''>");
						out.print ("<INPUT TYPE=HIDDEN NAME=mutant_aa VALUE=''>");

						out.print ("<TR><TD><B>Mutant Allele:</B></TD><TD><INPUT TYPE=TEXT NAME=mutant_allele SIZE=10 MAXLENGTH=10></TD></TR>");
					}
				}
			}
			out.print ("<TR><TD><B>Allele Frequency:</B></TD><TD><INPUT TYPE=TEXT SIZE=3 MAXLENGTH=3 NAME=allele_frequency></TD></TR>");
			out.print ("<TR><TD><B>LOD Score:</B></TD><TD><INPUT TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=lod_score></TD></TR>");
			out.print ("<TR><TD><B>Reference:</B></TD><TD><TEXTAREA COLS=64 ROWS=4 NAME=reference></TEXTAREA></TD></TR>");
			out.print ("<TR><TD><B>Verify:</B></TD><TD>"+ HTMLOutput.HTMLFormatVerify ("N")+"</TD></TR>");
			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=2><INPUT TYPE=BUTTON onClick='validateForm()' VALUE='Add Variant Info'></TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}


		else if (sub_command.equals ("add"))
		{
			String gene_wid = request.getParameter ("gene_wid");
			String variant_type_wid = request.getParameter ("variant_type_wid");
			String variant_length = request.getParameter ("variant_length").toUpperCase();
			String location = request.getParameter ("location").trim();
			String offset = request.getParameter ("offset").trim();
			String phenotype = request.getParameter ("phenotype").trim();
			String verify = request.getParameter ("verify");

			String wild_type_allele = "";
			String mutant_allele = "";
			String wild_type_aa = "";
			String mutant_aa = "";
			
			String allele_frequency = request.getParameter ("allele_frequency").trim();
			String lod_score = request.getParameter ("lod_score").trim();
			String reference = request.getParameter ("reference").trim();

			Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes();
			VariantType [] variant_types = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantTypes ();


			Gene g = null;
			VariantType vt = null;

			for (int i=0;i<genes.length;i++)
			{
				if (genes[i].getGene_wid().equals(gene_wid))
					g = genes[i];
			}

			for (int i=0;i<variant_types.length;i++)
			{
				if (variant_types[i].getVariant_type_wid().equals(variant_type_wid))
					vt = variant_types[i];
			}


			if (request.getParameter ("wild_type_allele") != null)
				wild_type_allele = request.getParameter ("wild_type_allele").trim().toUpperCase();

			if (request.getParameter ("mutant_allele") != null)
				mutant_allele = request.getParameter ("mutant_allele").trim().toUpperCase();

			if (request.getParameter ("wild_type_aa") != null)
				wild_type_aa = request.getParameter ("wild_type_aa").trim().toUpperCase();

			if (request.getParameter ("mutant_aa") != null)
				mutant_aa = request.getParameter ("mutant_aa").trim().toUpperCase();


			VariantInfo vi = new VariantInfo ();

			vi.setGene (g);
			vi.setVariant_type (vt);

      			vi.setVariant_length(variant_length);
     			vi.setUser_wid(USER.getUserwid());
      			vi.setLocation(location);
      			vi.setOffset(offset);
      			vi.setPhenotype(phenotype);
      			vi.setWild_type_allele(wild_type_allele);
      			vi.setMutant_allele(mutant_allele);
     			vi.setWild_type_aa(wild_type_aa);
      			vi.setMutant_aa(mutant_aa);
    			vi.setVerify(verify);
      			vi.setAllele_frequency(allele_frequency);
      			vi.setLod_score(lod_score);
      			vi.setReference(reference);


			((GenotypeDataAccess)DATA_ACCESS_LAYER).addVariantInfo (vi);			


			out.print ("<FORM ACTION='"+application_name+"/variantinfo/index.jsp?section=variantinfo&sub_section=add_variantinfo&command=new&sub_command=getinfo' METHOD='POST'>");
			out.print ("<TABLE valign=center align=center >");
			out.print("<TR><TD>Variant Info Successfully Added!</TD></TR>");
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

		if (sub_command.equals ("getvariantinfoid"))
		{

		String gene_wid = "";

		if (request.getParameter ("gene_wid") != null)
			gene_wid = request.getParameter ("gene_wid");

		Gene g = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGene (gene_wid);

		// get a list of our genes
		Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes ();

		out.println ("<FORM NAME=view_variants ACTION="+application_name+"/variantinfo/index.jsp ACTION=POST>");
		out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=variantinfo>");
		out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=edit_variantinfo>");
		out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
		out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=getvariantinfoid>");

		out.print ("<TABLE><TR>");
		out.print ("<TD><B>Please select a gene: </B></TD>");
		out.print ("<TD>"+HTMLOutput.HTMLFormatGenes (genes,g,"onChange=\"document.view_variants.submit()\" ",true,false)+"</TD>");
		out.print ("</TR>");
		out.print ("</FORM>");

		boolean newQuerySelected = false;

		if (request.getSession().getAttribute("CURRENT_VARIANTINFO_GENE_WID")!=null)
		{
			String current_gene_wid = (String)request.getSession().getAttribute ("CURRENT_VARIANTINFO_GENE_WID");
			if (!current_gene_wid.equals (gene_wid))
			{
				newQuerySelected = true;
				request.getSession().setAttribute ("CURRENT_VARIANTINFO_GENE_WID",gene_wid);
			}
		}
		else
		{
			newQuerySelected = true;
			request.getSession().setAttribute ("CURRENT_VARIANTINFO_GENE_WID",gene_wid);
		}


			if (newQuerySelected || request.getSession().getAttribute("VARIANT_INFO_HTML_TABLE") == null || ((GenotypeDataAccess)DATA_ACCESS_LAYER).isVariantInfoDataDirty())
			{


				// get a list of our variantinfo objects
				VariantInfo [] variantinfo = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantInfoByGeneWid (gene_wid);

 
				String SORT_ACTION = ""+application_name+"/variantinfo/index.jsp?section=variantinfo&sub_section=edit_variantinfo&command=modify&sub_command=getvariantinfoid&gene_wid="+gene_wid;
				// create an html table with all column descipriptors
      				HTMLTable table = new HTMLTable ();
      				HTMLTableColumn [] columns = {
					new HTMLTableColumn ("Verify",SORT_ACTION+"&sort_index=0",true,true,100,String.class, new int [] {0}),
					new HTMLTableColumn ("Variant Type",SORT_ACTION+"&sort_index=1",true,true,100,String.class, new int [] {1}),
					new HTMLTableColumn ("Variant Length",SORT_ACTION+"&sort_index=2",true,true,100,String.class, new int [] {2}),
					new HTMLTableColumn ("Location",SORT_ACTION+"&sort_index=3",true,true,100,Integer.class, new int [] {3}),
					new HTMLTableColumn ("Offset",SORT_ACTION+"&sort_index=4",true,true,100,Integer.class, new int [] {3,4}),
					new HTMLTableColumn ("Phenotype",SORT_ACTION+"&sort_index=5",true,true,100,String.class, new int [] {5}),
					new HTMLTableColumn ("Wild Type Allele",SORT_ACTION+"&sort_index=6",true,true,100,String.class, new int [] {6}),
					new HTMLTableColumn ("Wild Type AA",SORT_ACTION+"&sort_index=7",true,true,100,String.class, new int [] {7}),
					new HTMLTableColumn ("Mutant Allele",SORT_ACTION+"&sort_index=8",true,true,100,String.class, new int [] {8}),
					new HTMLTableColumn ("Mutant AA",SORT_ACTION+"&sort_index=9",true,true,100,String.class, new int [] {9}),
					new HTMLTableColumn ("Allele Freq.",SORT_ACTION+"&sort_index=10",true,true,100,String.class, new int [] {10}),
					new HTMLTableColumn ("LOD Score",SORT_ACTION+"&sort_index=11",true,true,100,String.class, new int [] {11}),
      				};
      				table.setColumns(columns,"Current Variant Info");


				// now create all our row objects

				for (int i=0;variantinfo!=null&&i<variantinfo.length;i++)
				{

					VariantInfo vi = variantinfo[i];

					String action = ""+application_name+"/variantinfo/index.jsp?section=variantinfo&sub_section=edit_variantinfo&command=modify&sub_command=getinfo&variant_info_wid="+variantinfo[i].getVariant_info_wid () + "&coding_sequence_length="+g.getCoding_sequence_length();
					table.addRow (new HTMLTableRow ( new Object [] {
						vi.getVerify(),
						vi.getVariant_type().getType(),
						vi.getVariant_length(),
						new Integer (vi.getLocation()),
						new Integer (vi.getOffset()),
						vi.getPhenotype(),
						vi.getWild_type_allele(),
						HTMLOutput.HTMLFormatAminoAcid(vi.getWild_type_aa()),
						vi.getMutant_allele(),
						HTMLOutput.HTMLFormatAminoAcid(vi.getMutant_aa()),
						vi.getAllele_frequency(),
						vi.getLod_score(),
					},action));
				}
				request.getSession().setAttribute ("VARIANT_INFO_HTML_TABLE",table);
				((GenotypeDataAccess)DATA_ACCESS_LAYER).setVariantInfoDataDirty (false);

			}

			HTMLTable table = (HTMLTable)request.getSession().getAttribute ("VARIANT_INFO_HTML_TABLE");

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
			<script language=javascript>

			function setFocus ()
			{
				document.variant_info.location.focus()
				enableFields ()
			}

			function validateForm ()
			{
				error = false
				error_string = ""
		

				if (trimAll(document.variant_info.variant_length.value).length == 0)
				{
					error_string = error_string + 'Variant Length is a required field\n'
					error = true
				}
				if (trimAll(document.variant_info.location.value).length == 0)
				{
					error_string = error_string + 'Location is a required field\n'
					error = true
				}

				if (trimAll(document.variant_info.offset.value).length == 0)
				{
					error_string = error_string + 'Offset is a required field\n'
					error = true
				}
 
				if (trimAll(document.variant_info.phenotype.value).length == 0)
				{
					error_string = error_string + 'Phenotype is a required field\n'
					error = true
				}
				if (trimAll(document.variant_info.reference.value).length == 0)
				{
					error_string = error_string + 'Reference is a required field\n'
					error = true
				}

				
				if (isNaN(document.variant_info.location.value) || !validateInteger (document.variant_info.location.value))
				{
					error_string = error_string + 'Location must be numeric and integer\n'
					error = true
				}

				if (parseInt(document.variant_info.location.value) > parseInt (document.variant_info.coding_sequence_length.value))
				{
					error_string = error_string + 'Location can not be greater than length of the coding sequence (' + document.variant_info.coding_sequence_length.value + ') for this gene\n'
					error = true
				}
				if (isNaN(document.variant_info.offset.value) || !validateInteger (document.variant_info.offset.value))
				{
					error_string = error_string + 'Offset must be numeric and integer\n'
					error = true
				}
				if (trimAll(document.variant_info.allele_frequency.value).length >0)
				{
					if (isNaN(document.variant_info.allele_frequency.value))
					{
						error_string = error_string + 'Allele Frequency must be numeric\n'
						error = true
					}
					value = parseFloat (document.variant_info.allele_frequency.value)
					if ( value <= 0.0 || value > 1.0)
					{
						error_string = error_string + 'Allele Frequency must be within the range [ 0 < frequency <= 1.0 ]\n'
						error = true
					}
				}

				if (trimAll(document.variant_info.lod_score.value).length >0)
				{
					if (isNaN(document.variant_info.lod_score.value))
					{
						error_string = error_string + 'LOD Score must be numeric\n'
						error = true
					}

					value = parseFloat (document.variant_info.lod_score.value)
					if ( value < -999.99 || value > 999.99)
					{
						error_string = error_string + 'LOD Score must be within the range [ -999.99 <= LOD Score <= 999.99 ]\n'
						error = true
					}
				}

				if (document.variant_info.location.value <= 0)
				{
					error_string = error_string + 'Location must be greater than 0\n'
					error = true
				}

	
				variant_type = trimAll(document.variant_info.variant_type_wid.options[document.variant_info.variant_type_wid.selectedIndex].text.toUpperCase())
	
				error_string = error_string + validateVariant (
					variant_type, 
					document.variant_info.variant_length.value, 
					document.variant_info.wild_type_allele.value, 
					document.variant_info.mutant_allele.value,
					document.variant_info.wild_type_aa.value, 
					document.variant_info.mutant_aa.value )

				if (error_string.length > 0)
					error = true
	

				if (error)
				{
					alert (error_string)
					return false
				}
				if (confirm ('Is the information you have entered correct?  Press OK to continue'))
				{

					document.variant_info.wild_type_allele.disabled = false
					document.variant_info.wild_type_aa.disabled = false
					document.variant_info.mutant_allele.disabled = false
					document.variant_info.mutant_aa.disabled = false
					document.variant_info.variant_length.disabled = false

					document.variant_info.submit()
					return true
				}
				return false
	
			}

			function variant_type_changed()
			{
				variant_type = trimAll(document.variant_info.variant_type_wid.options[document.variant_info.variant_type_wid.selectedIndex].text.toUpperCase())
				clearAllFields ()
				enableFields ()

				if (variant_type == "MUTATION")
				{
					document.variant_info.variant_length.disabled=false						
					document.variant_info.variant_length.value='1'
					document.variant_info.variant_length.disabled=true
				}
				else
				{
					document.variant_info.variant_length.disabled=false						
					document.variant_info.variant_length.value=''
				}


			}

			function clearAllFields ()
			{
				document.variant_info.wild_type_allele.disabled = false
				document.variant_info.wild_type_aa.disabled = false
				document.variant_info.mutant_allele.disabled = false
				document.variant_info.mutant_aa.disabled = false

				document.variant_info.wild_type_allele.value=''
				document.variant_info.wild_type_aa.value=''
				document.variant_info.mutant_allele.value=''
				document.variant_info.mutant_aa.value=''

				document.variant_info.wild_type_allele.disabled = true
				document.variant_info.wild_type_aa.disabled = true
				document.variant_info.mutant_allele.disabled = true
				document.variant_info.mutant_aa.disabled = true
			}

			function enableFields ()
			{
				variant_type = trimAll(document.variant_info.variant_type_wid.options[document.variant_info.variant_type_wid.selectedIndex].text.toUpperCase())
				offset = trimAll (document.variant_info.offset.value)

				if (variant_type == "MUTATION")
				{
					document.variant_info.variant_length.disabled = true
					if (offset == "0")
					{
						document.variant_info.wild_type_allele.disabled = false
						document.variant_info.wild_type_aa.disabled = false
						document.variant_info.mutant_allele.disabled = false
						document.variant_info.mutant_aa.disabled = false
					}
					else
					{
						document.variant_info.wild_type_allele.disabled = false
						document.variant_info.wild_type_aa.disabled = true
						document.variant_info.mutant_allele.disabled = false
						document.variant_info.mutant_aa.disabled = true
					}
				}
				else if (variant_type == "INSERTION")
				{
					document.variant_info.variant_length.disabled = false
					if (offset == "0")
					{
						document.variant_info.wild_type_allele.disabled = true
						document.variant_info.wild_type_aa.disabled = true
						document.variant_info.mutant_allele.disabled = false
						document.variant_info.mutant_aa.disabled = false
					}
					else
					{
						document.variant_info.wild_type_allele.disabled = true
						document.variant_info.wild_type_aa.disabled = true
						document.variant_info.mutant_allele.disabled = false
						document.variant_info.mutant_aa.disabled = true
					}
				}
					
				else if (variant_type == "DELETION")
				{
					document.variant_info.variant_length.disabled = false
					if (offset == "0")
					{
						document.variant_info.wild_type_allele.disabled = false
						document.variant_info.wild_type_aa.disabled = false
						document.variant_info.mutant_allele.disabled = true
						document.variant_info.mutant_aa.disabled = true
					}
					else
					{
						document.variant_info.wild_type_allele.disabled = false
						document.variant_info.wild_type_aa.disabled = true
						document.variant_info.mutant_allele.disabled = true
						document.variant_info.mutant_aa.disabled = true
					}
				}
			}



			</script>
			<%

			String variant_info_wid = request.getParameter ("variant_info_wid");
			String coding_sequence_length = request.getParameter ("coding_sequence_length");

			VariantInfo vi = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantInfoByWid (variant_info_wid);

			Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes();
			VariantType [] variant_types = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantTypes ();

			
			out.print ("<FORM NAME=variant_info ACTION='"+application_name+"/variantinfo/index.jsp' METHOD='POST'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=variant_type VALUE='"+vi.getVariant_type().getType().toUpperCase()+"'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=variant_info_wid VALUE='"+variant_info_wid+"'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=variantinfo>");
			out.print ("<INPUT TYPE=HIDDEN NAME=coding_sequence_length VALUE="+coding_sequence_length+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=edit_variantinfo>");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=update>");
			out.print ("<INPUT TYPE=HIDDEN NAME=version_nbr VALUE='"+vi.getVersion_nbr()+"'>");
			out.print ("<TABLE valign=center align=center>");

			out.print ("<TR><TD><B>Gene:</B></TD><TD>"+HTMLOutput.HTMLFormatGenes (genes,vi.getGene(),null,false,false) + "</TD></TR>");
			out.print ("<TR><TD><B>Variant Type:</B></TD><TD>"+HTMLOutput.HTMLFormatVariantTypes (variant_types,vi.getVariant_type(),"variant_type_changed()","variant_type_wid",false)+"</TD></TR>");
			out.print ("<TR><TD><B>Variant Length:</B></TD><TD><INPUT VALUE='"+vi.getVariant_length() +"' TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=variant_length></TD></TR>");
			out.print ("<TR><TD><B>Location:</B></TD><TD><INPUT VALUE='" + vi.getLocation() + "' TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=location></TD></TR>");
			out.print ("<TR><TD><B>Offset:</B></TD><TD><INPUT VALUE='" + vi.getOffset() + "' TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=offset onChange=\"variant_type_changed()\"></TD></TR>");
			out.print ("<TR><TD><B>Phenotype:</B></TD><TD><INPUT VALUE='" + vi.getPhenotype() + "' TYPE=TEXT SIZE=32 MAXLENGTH=32 NAME=phenotype></TD></TR>");
			out.print ("<TR><TD><B>Wild Type Allele:</B></TD><TD><INPUT VALUE='" + vi.getWild_type_allele() + "' TYPE=TEXT VALUE='-'SIZE=10 MAXLENGTH=10 NAME=wild_type_allele></TD></TR>");
			out.print ("<TR><TD><B>Mutant Allele:</B></TD><TD><INPUT VALUE='" + vi.getMutant_allele() + "' TYPE=TEXT SIZE=10 MAXLENGTH=10 NAME=mutant_allele></TD></TR>");
			out.print ("<TR><TD><B>Wild Type AA:</B></TD><TD><INPUT TYPE=TEXT VALUE='" + vi.getWild_type_aa() + "'SIZE=10 MAXLENGTH=10 NAME=wild_type_aa></TD></TR>");
			out.print ("<TR><TD><B>Mutant AA:</B></TD><TD><INPUT TYPE=TEXT VALUE='" + vi.getMutant_aa() + "' SIZE=10 MAXLENGTH=10 NAME=mutant_aa></TD></TR>");
			out.print ("<TR><TD><B>Allele Frequency:</B></TD><TD><INPUT VALUE='" + vi.getAllele_frequency() + "' TYPE=TEXT SIZE=3 MAXLENGTH=3 NAME=allele_frequency></TD></TR>");
			out.print ("<TR><TD><B>Verify:</B></TD><TD>"+ HTMLOutput.HTMLFormatVerify (vi.getVerify())+"</TD></TR>");
			out.print ("<TR><TD><B>LOD Score:</B></TD><TD><INPUT TYPE=TEXT VALUE='" + vi.getLod_score() + "' SIZE=32 MAXLENGTH=32 NAME=lod_score></TD></TR>");
			out.print ("<TR><TD><B>Reference:</B></TD><TD><TEXTAREA COLS=64 ROWS=4 NAME=reference>" + vi.getReference() + "</TEXTAREA></TD></TR>");
			out.print ("<TR><TD span=2>&nbsp;</TD></TR>");
			out.print ("<TR><TD span=2><INPUT TYPE=BUTTON onClick='validateForm()' VALUE='Update Variant Info'></TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");

		}

		else if (sub_command.equals ("update"))
		{
			String variant_info_wid = request.getParameter ("variant_info_wid");
			String gene_wid = request.getParameter ("gene_wid");
			String variant_type_wid = request.getParameter ("variant_type_wid");
			String variant_length = request.getParameter ("variant_length").toUpperCase();
			String location = request.getParameter ("location");
			String offset = request.getParameter ("offset");
			String phenotype = request.getParameter ("phenotype");
			String verify = request.getParameter ("verify");

			String wild_type_allele = "";
			String mutant_allele = "";
			String wild_type_aa = "";
			String mutant_aa = "";

			if (request.getParameter ("wild_type_allele") != null)
				wild_type_allele = request.getParameter ("wild_type_allele").trim().toUpperCase();

			if (request.getParameter ("mutant_allele") != null)
				mutant_allele = request.getParameter ("mutant_allele").trim().toUpperCase();

			if (request.getParameter ("wild_type_aa") != null)
				wild_type_aa = request.getParameter ("wild_type_aa").trim().toUpperCase();

			if (request.getParameter ("mutant_aa") != null)
				mutant_aa = request.getParameter ("mutant_aa").trim().toUpperCase();

			String allele_frequency = request.getParameter ("allele_frequency");
			String lod_score = request.getParameter ("lod_score");
			String reference = request.getParameter ("reference");

			VariantInfo vi = new VariantInfo ();

			Gene g = new Gene ();
			g.setGene_wid (gene_wid);
			vi.setGene (g);

			VariantType vt = new VariantType ();
			vt.setVariant_type_wid (variant_type_wid);
			vi.setVariant_type (vt);

			vi.setVariant_info_wid (variant_info_wid);
      			vi.setVariant_length(variant_length);
     			vi.setUser_wid(USER.getUserwid());
      			vi.setLocation(location);
      			vi.setOffset(offset);
      			vi.setPhenotype(phenotype);
      			vi.setWild_type_allele(wild_type_allele);
      			vi.setMutant_allele(mutant_allele);
     			vi.setWild_type_aa(wild_type_aa);
      			vi.setMutant_aa(mutant_aa);
    			vi.setVerify(verify);
      			vi.setAllele_frequency(allele_frequency);
      			vi.setLod_score(lod_score);
      			vi.setReference(reference);


			((GenotypeDataAccess)DATA_ACCESS_LAYER).updateVariantInfo (vi);			


			out.print ("<FORM ACTION='"+application_name+"/variantinfo/index.jsp' METHOD='POST'>");
			out.print ("<INPUT TYPE=HIDDEN NAME=gene_wid VALUE="+gene_wid+">");
			out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=modify>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=getvariantinfoid>");
			out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=variantinfo>");
			out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=edit_variantinfo>");
			out.print ("<TABLE valign=center align=center >");
			out.print("<TR><TD>Variant Info Successfully Updated!</TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("<TR><TD><INPUT TYPE=SUBMIT VALUE='Continue'></TD></TR>");
			out.print ("<TR><TD>&nbsp;</TD></TR>");
			out.print ("</TABLE>");
			out.print ("</FORM>");
		}


	}
	else if (command.equals("view"))
	{
		String sub_command = "";
		if (request.getParameter ("sub_command") != null)
			sub_command = request.getParameter ("sub_command");

		if (sub_command.equals ("getvariantinfoid"))
		{

		String gene_wid = "";

		if (request.getParameter ("gene_wid") != null)
			gene_wid = request.getParameter ("gene_wid");

		Gene g = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGene (gene_wid);

		// get a list of our genes
		Gene [] genes = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getGenes ();

		out.println ("<FORM NAME=view_variants ACTION="+application_name+"/variantinfo/index.jsp ACTION=POST>");
		out.print ("<INPUT TYPE=HIDDEN NAME=section VALUE=variantinfo>");
		out.print ("<INPUT TYPE=HIDDEN NAME=sub_section VALUE=view_variantinfo>");
		out.print ("<INPUT TYPE=HIDDEN NAME=command VALUE=view>");
		out.print ("<INPUT TYPE=HIDDEN NAME=sub_command VALUE=getvariantinfoid>");

		out.print ("<TABLE><TR>");
		out.print ("<TD><B>Please select a gene: </B></TD>");
		out.print ("<TD>"+HTMLOutput.HTMLFormatGenes (genes,g,"onChange=\"document.view_variants.submit()\" ",true,false)+"</TD>");
		out.print ("</TR></TABLE>");
		out.print ("</FORM>");

		boolean newQuerySelected = false;

		if (request.getSession().getAttribute("CURRENT_VARIANTINFO_GENE_WID")!=null)
		{
			String current_gene_wid = (String)request.getSession().getAttribute ("CURRENT_VARIANTINFO_GENE_WID");
			if (!current_gene_wid.equals (gene_wid))
			{
				newQuerySelected = true;
				request.getSession().setAttribute ("CURRENT_VARIANTINFO_GENE_WID",gene_wid);
			}
		}
		else
		{
			newQuerySelected = true;
			request.getSession().setAttribute ("CURRENT_VARIANTINFO_GENE_WID",gene_wid);
		}


			if (newQuerySelected || request.getSession().getAttribute("VARIANT_INFO_HTML_TABLE") == null || ((GenotypeDataAccess)DATA_ACCESS_LAYER).isVariantInfoDataDirty())
			{


				// get a list of our variantinfo objects
				VariantInfo [] variantinfo = ((GenotypeDataAccess)DATA_ACCESS_LAYER).getVariantInfoByGeneWid (gene_wid);

 
				String SORT_ACTION = ""+application_name+"/variantinfo/index.jsp?section=variantinfo&sub_section=view_variantinfo&command=view&sub_command=getvariantinfoid&gene_wid="+gene_wid;
				// create an html table with all column descipriptors
      				HTMLTable table = new HTMLTable ();
      				HTMLTableColumn [] columns = {
					new HTMLTableColumn ("Verify",SORT_ACTION+"&sort_index=0",true,true,100,String.class, new int [] {0}),
					new HTMLTableColumn ("Variant Type",SORT_ACTION+"&sort_index=1",true,true,100,String.class, new int [] {1}),
					new HTMLTableColumn ("Variant Length",SORT_ACTION+"&sort_index=2",true,true,100,String.class, new int [] {2}),
					new HTMLTableColumn ("Location",SORT_ACTION+"&sort_index=3",true,true,100,Integer.class, new int [] {3}),
					new HTMLTableColumn ("Offset",SORT_ACTION+"&sort_index=4",true,true,100,Integer.class, new int [] {3,4}),
					new HTMLTableColumn ("Phenotype",SORT_ACTION+"&sort_index=5",true,true,100,String.class, new int [] {5}),
					new HTMLTableColumn ("Wild Type Allele",SORT_ACTION+"&sort_index=6",true,true,100,String.class, new int [] {6}),
					new HTMLTableColumn ("Wild Type AA",SORT_ACTION+"&sort_index=7",true,true,100,String.class, new int [] {7}),
					new HTMLTableColumn ("Mutant Allele",SORT_ACTION+"&sort_index=8",true,true,100,String.class, new int [] {8}),
					new HTMLTableColumn ("Mutant AA",SORT_ACTION+"&sort_index=9",true,true,100,String.class, new int [] {9}),
					new HTMLTableColumn ("Allele Freq.",SORT_ACTION+"&sort_index=10",true,true,100,String.class, new int [] {10}),
					new HTMLTableColumn ("LOD Score",SORT_ACTION+"&sort_index=11",true,true,100,String.class, new int [] {11}),
      				};
      				table.setColumns(columns,"Current Variant Info");


				// now create all our row objects

				for (int i=0;variantinfo!=null&&i<variantinfo.length;i++)
				{

					VariantInfo vi = variantinfo[i];

					table.addRow (new HTMLTableRow ( new Object [] {
						vi.getVerify(),
						vi.getVariant_type().getType(),
						vi.getVariant_length(),
						new Integer (vi.getLocation()),
						new Integer (vi.getOffset()),
						vi.getPhenotype(),
						vi.getWild_type_allele(),
						HTMLOutput.HTMLFormatAminoAcid(vi.getWild_type_aa()),
						vi.getMutant_allele(),
						HTMLOutput.HTMLFormatAminoAcid(vi.getMutant_aa()),
						vi.getAllele_frequency(),
						vi.getLod_score(),
					},null));
				}
				request.getSession().setAttribute ("VARIANT_INFO_HTML_TABLE",table);
				((GenotypeDataAccess)DATA_ACCESS_LAYER).setVariantInfoDataDirty (false);

			}

			HTMLTable table = (HTMLTable)request.getSession().getAttribute ("VARIANT_INFO_HTML_TABLE");

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
	}


%>
<%@ include file="../common/footer.jsp" %>