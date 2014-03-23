<%@ page import = "SQLReader" %>
<%@ page import = "ServerInfo" %>
<%@ page import = "Server" %>
<%@ page import = "Oracle" %>
<%@ page import = "DataBindingServlet" %>

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
	SQLReader sr = new SQLReader();
	// ???
	sr.read("C:\\Chialin\\tomcat-321\\webapps\\examples\\WEB-INF\\classes\\test.sql");
%>


<% 
	Oracle o = new Oracle(machine, port, username, password, sid);
	String sqlStr = sr.getSQL("IO_ROLLBACK");
	o.executeSQL(sqlStr);	
	
	DataBindingServlet dbs = new DataBindingServlet();
	dbs.run(o);
%>

<OBJECT classid=clsid:333C7BC4-460F-11D0-BC04-0080C7055A83 
		height=30 
		id=tdcStaff 
		width=46>
		<PARAM NAME="RowDelim" VALUE="&#10;">
		<PARAM NAME="FieldDelim" VALUE=",">
		<PARAM NAME="TextQualifier" VALUE=",">
		<PARAM NAME="EscapeChar" VALUE="">
		<PARAM NAME="UseHeader" VALUE="-1">
		<PARAM NAME="SortAscending" VALUE="-1">
		<PARAM NAME="SortColumn" VALUE="">
		<PARAM NAME="FilterValue" VALUE="">
		<PARAM NAME="FilterCriterion" VALUE="??">
		<PARAM NAME="FilterColumn" VALUE="">
		<PARAM NAME="CharSet" VALUE="">
		<PARAM NAME="Language" VALUE="">
		<PARAM NAME="CaseSensitive" VALUE="-1">
		<PARAM NAME="Sort" VALUE="">
		<PARAM NAME="Filter" VALUE="">
		<PARAM NAME="AppendData" VALUE="0">
		<PARAM NAME="DataURL" VALUE="/examples/servlet/DataBindingServlet?id=<%= dbs.getId() %>">
		<PARAM NAME="ReadyState" VALUE="4">
</OBJECT>


<p>&nbsp;


<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=2>
<TR BGCOLOR=#333366>
	<TD>
	<DIV ID='divDept'>
	<B><FONT COLOR=#FFFFFF><p align=center>Disk IO Report</p></FONT></B>
	</DIV>
	</TD>
<TR>
<TD>
<TABLE DATASRC="#tdcStaff" border=1>
	<THEAD>
		<TR>
		<% out.println(dbs.getHTMLCol()); %>
		</TR>
	</THEAD>
	<TBODY>
		<TR>
		<% out.println(dbs.getHTMLDataFld()); %>
		</TR>
	</TBODY>
</TABLE>
</TD>
</TR>
</TABLE>

</BODY>
</HTML>

