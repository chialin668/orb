<%@ page import = "SQLReader" %>
<%@ page import = "Oracle" %>
<%@ page import = "DataBindingServlet" %>


<%@ include file="Session.jsp"%>

<%
	// Table Title & SQL
	String title = request.getParameter("title");
	String sqlTag = request.getParameter("sqltag");
%>

<HTML>

<HEAD>
	<TITLE><%= title %></TITLE>
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

<p>&nbsp;<p>&nbsp

<%
out.println("Machine = " + machine);
//out.println(port);
out.println(", SID = " + sid);
///out.println(username);
//out.println(password);
%>

<% 
	// run the sql
	SQLReader sr = new SQLReader();
	String sqlStr = sr.getSQL(sqlTag);
	Oracle o = new Oracle(machine, port, username, password, sid);
	o.executeSQL(sqlStr);	
	
	// init the binding html
	DataBindingServlet dbs = new DataBindingServlet();
	dbs.init(o);
	
	// generate the binding data
	String url = "/orb/servlet/DataBindingServlet";
	String param = dbs.getId();
	out.println(dbs.getDataBindingObj(url, param)); 
	out.println(dbs.getDataBindingTable(title)); 
%>

</BODY>
</HTML>

