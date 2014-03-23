<%@ page import = "java.util.Vector" %>
<%@ page import = "Database" %>

<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>

<form name="schemaObject" target="schemaObject" action="/orb/jsp/oracle/schema/SchemaObject.jsp">
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Select an owner:</td>
    <td>

	<select id=type name=type onchange=test()>
		<option value=table>Table
		<option value=index>Index
		<option value=view>View
		<option value=procedure>Procedure
		<option value=trigger>Trigger
		<option value=sequence>Sequence
		<option value=synonym>Synonym
		<option value=constraint>Constraint
		<option value=dblink>DB Link
		<option value=java>Java
	</select>
	</td>	
	<td><input type="submit" value="Get Objects" /></td>
</tr>	
</table>

<SCRIPT LANGUAGE="JavaScript">

function test() {
	var oSelect = document.getElementById("ColNameSelect");

//	alert(type.options[type.selectedIndex].text);
	
	// remove the old one
/*	
	if (oSelect != null) {
		alert(oSelect.length);
		var i=0;
		for (i=0;i<oSelect.length;i++)
			oSelect.remove(i);
	}
*/	
		if (oSelect != null)
			document.remove(oSelect);

		oSelect = document.createElement("select");
		oSelect.id = "ColNameSelect";
		oSelect.name = "colName";
		oSelect.onchange = test;

<%
		Database o = new Database(machine, port, username, password, sid);	
		o.setSql("select username from dba_users order by username");
		o.executeSQL("DUMMY");
		Vector resultVect = o.getResultVect();
	
		out.println("	var oSelect = document.createElement('select');\n");
		out.println("oSelect.id = 'ColNameSelect';\n");
		out.println("oSelect.name = 'colName';\n");

	
		for (int i=0;i<resultVect.size();i++) {
			String data = (String) resultVect.elementAt(i);
			out.println("var oOption = document.createElement('option');\n");
			out.println("oOption.value = '" + data + "';\n");
			out.println("oOption.innerText = '" + data + "';\n");
			out.println("oOption.selected = 'True';\n");
			out.println("oSelect.appendChild(oOption);\n");
		}
%>
		document.body.appendChild(oSelect);


}
</script>

<A target=basefrm href="/orb/jsp/oracle/space/Space.jsp?">Back</A>

</body>
</html>
