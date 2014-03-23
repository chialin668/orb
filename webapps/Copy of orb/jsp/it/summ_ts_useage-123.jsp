<%@ page import = "SQLTable" %>
<%@ page import = "Server" %>
<%@ page import = "ServerInfo" %>

<%
	String id = session.getId();
	String sid = (String) session.getValue(id);
	
	ServerInfo sInfo = new ServerInfo();
	// sInfo.init(); don't have to init here
	Server server = sInfo.getServerBySid(sid);
	String machine = server.getMachine();
	String port = server.getPort();
	String username = "sys";
	String password = server.getPassword();
	
%>

<HTML>

<HEAD>
	<TITLE>Datafile Information</TITLE>
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/sorttable.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Global.js"></SCRIPT>

	<STYLE>
		BODY {
		font-size: 9pt;
		font-family: verdana, tahoma, sans serif, helvetica;
	}
	TH A { color: white }
	TH A:Hover { color: yellow }
	</STYLE>

</HEAD>

<BODY>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="/js/HM_Loader.js"></SCRIPT>


<% 
	//SQLTable t = new SQLTable();
	SQLTable t = new SQLTable(machine, port, username, password, sid);
	String sqlStr = t.init("SUMM_TS_USEAGE");
	t.executeSQL(sqlStr);
%>

<OBJECT id=tdcStaff
	CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83"
		width="46"
		height="30">
	<param name="RowDelim" value="">
	<param name="FieldDelim" value=",">
	<param name="TextQualifier" value=",">
	<param name="EscapeChar" value>
	<param name="UseHeader" value="-1">
	<param name="SortAscending" value="-1">
	<param name="SortColumn" value>
	<param name="FilterValue" value>
	<param name="FilterCriterion" value="??">
	<param name="FilterColumn" value>
	<param name="CharSet" value>
	<param name="Language" value>
	<param name="CaseSensitive" value="-1">
	<param name="Sort" value>
	<param name="Filter" value>
	<param name="AppendData" value="0">
	<param name="DataURL" value="/examples/servlet/SQLTable?id=<%= t.getId() %>">
	<param name="ReadyState" value="4">
</OBJECT>


<p>&nbsp;


<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=2>
<TR BGCOLOR=#333366>
	<TD>
	<DIV ID='divDept'>
	<B><FONT COLOR=#FFFFFF>Index Information</FONT></B>
	</DIV>
	</TD>
<TR>
<TD>
<TABLE DATASRC="#tdcStaff">
	<THEAD>
		<TR>
		<% out.println(t.getHTMLCol()); %>
		</TR>
	</THEAD>
	<TBODY>
		<TR>
		<% out.println(t.getHTMLDataFld()); %>
		</TR>
	</TBODY>
</TABLE>
</TD>
</TR>
</TABLE>


</BODY>
</HTML>

