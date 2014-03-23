
<%@ page import = "com.orb.oracle.XmlSchemaIO" %>


<%

	String projectName = request.getParameter("projectName");

	//String xmlStr = request.getParameter("xml");

	XmlSchemaIO sw = new XmlSchemaIO();
	String xmlStr = sw.read(projectName);
	
	System.out.println(xmlStr);
%>


<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>

	<style>	v\:* { behavior: url(#default#VML); }</style>
	<style type="text/css">	@import url(./JS/ERD-Style.css); </style>
	<style> @import url("./JS/ERD-Style.css"); </style>

	<script src="./JS/ERD-protable.js" type="text/javascript"></script>
	<script src="./JS/ERD-global.js" type="text/javascript"></script>
	<script src="./JS/ERD-sys.js" type="text/javascript"></script>
	<script src="./JS/ERD-util.js" type="text/javascript"></script>
	<script src="./JS/ERD-Netscape.js" type="text/javascript"></script>
	<script src="./JS/ERD-xmlschema.js" type="text/javascript"></script>
	<script src="./JS/ERD-datatype.js" type="text/javascript"></script>
	<script src="./JS/ERD-validate.js" type="text/javascript"></script>
	<script src="./JS/ERD-default.js" type="text/javascript"></script>
	<script src="./JS/ERD-table.js" type="text/javascript"></script>
	<script src="./JS/ERD-index.js" type="text/javascript"></script>
	<script src="./JS/ERD-column.js" type="text/javascript"></script>
	<script src="./JS/ERD-relationship.js" type="text/javascript"></script>
	<script src="./JS/ERD-mouseEvent.js" type="text/javascript"></script>

	<script type="text/javascript" src="/js/xml4script-20/jsXMLParser/xmldom.js"></script>
</head>


<body onload="sy_Init()">

<FORM>
	<INPUT TYPE="hidden" ID="projectName" NAME="projectName" VALUE="<%=projectName%>">

	
	<INPUT TYPE="button" class="modeCtl" VALUE="Select" onClick="sy_SetSysMode(MOD_SELECT)">
	<INPUT TYPE="button" class="modeCtl" VALUE="New Table" onClick="sy_SetSysMode(MOD_TABLE)">
	
	<INPUT TYPE="button" class="modeCtl" VALUE="1:1" onClick="sy_SetSysMode(MOD_ONE2ONE)">
	<INPUT TYPE="button" class="modeCtl" VALUE="1:N" onClick="sy_SetSysMode(MOD_ONE2MANY)">
	<INPUT TYPE="button" class="modeCtl" VALUE="M:N" onClick="sy_SetSysMode(MOD_MANY2MANY)">
	<INPUT TYPE="button" class="modeCtl" VALUE="SQL" onClick="xm_SaveSchema()">
	
	
	<INPUT TYPE="text" NAME="sysModeField" VALUE="">
	<table cellspacing="2" cellpadding="2" border="0">
	<tr>
		<td>View:</td>
		<td>
		<select id=viewType name=viewType onChange="tb_ChangeView()">
			<option value='' selected>
			<option value='Compact'>Compact
			<option value='Short'>Short
			<option value='Full'>Full
		</select>
	</table>	
	
	<textarea name='xml' rows='10' cols='100'><%=xmlStr%></textarea>

</FORM>



<SCRIPT LANGUAGE=JavaScript>



xm_ReadSchema();
/*
// DB_USER
var User_WID 	= new Array(PRIMARY_EKY_MARK, "User_WID", "number", "-", "-", "-", "-");
var User_Name 	= new Array("-", "User_Name", "varchar2", "16", "-", "-", "-");
var First_Name 	= new Array("-", "First_Name", "varchar2", "32", "-", "-", "-");
var Last_Name 	= new Array("-", "Last_Name", "varchar2", "32", NULLABLE_MARK, "sex", "male");
var MD5_Hex_Password = new Array("-", "MD5_Hex_Password", "varchar2", "64", "-", "-", "-");
var Status 		= new Array("-", "Status", "char", "1", "-", "-", "-");
var Version_Nbr = new Array("-", "Version_Nbr", "number", "3", "-", "-", "-");
var columnArray = new Array(User_WID, User_Name, First_Name,
				Last_Name, MD5_Hex_Password, Status, Version_Nbr);
tb_AddTable("DB_User", 100, 100, columnArray);

//ROLE
var Role_WID 	= new Array(PRIMARY_EKY_MARK, "Role_WID", "number", "-", "-", "-", "-");
var Role_Name 	= new Array("-", "Role_Name", "varchar2", "32", "-", "-", "-");
var Version_Nbr = new Array("-", "Version_Nbr", "number", "3", "-", "-", "-");
var columnArray1 = new Array(Role_WID, Role_Name, Version_Nbr);
tb_AddTable("Role", 150, 450, columnArray1);

//DB_User_Role
var User_WID 	= new Array(PRIMARY_EKY_MARK, "ABC", "number", "-", "-", "-", "-");
var Role_WID 	= new Array("-", "XYZ", "number", "-", "-", "-", "-");
var Version_Nbr = new Array("-", "Version_Nbr", "number", "3", "-", "-", "-");
var columnArray1 = new Array(User_WID, Role_WID, Version_Nbr);
tb_AddTable("DB_User_Role", 400, 200, columnArray1);

//addRelationship("DB_User", "DB_User_Role");
//addRelationship("Role", "DB_User_Role");
*/
</script>

</body>

</html>