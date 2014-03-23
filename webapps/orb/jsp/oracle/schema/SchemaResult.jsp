<%@ page import = "java.util.Hashtable" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.Database" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Result:</h3>

<%
	String owner = request.getParameter("owner");
	String type = request.getParameter("type");
	String obj = request.getParameter("obj");
	String submit = request.getParameter("submit");

	if (owner != null && type != null) {
		SQLReader sqlReader = new SQLReader();
		sqlReader.refresh();

System.out.println("type = "  + type);
		String sqlTag = null;
		if (type.equals("table")) {

			if (submit.equals("Column"))
				sqlTag = "SCHEMA_TAB_COLUMN";
			else if (submit.equals("Index"))
				sqlTag = "SCHEMA_TAB_INDEX";
			else if (submit.equals("Constraint"))
				sqlTag = "SCHEMA_CONSTRAINT_TAB";
			else if (submit.equals("Trigger"))
				sqlTag = "SCHEMA_TAB_TRIGGER";

		} else if (type.equals("index")) {
			sqlTag = "SCHEMA_INDEX";
		} else if (type.equals("view")) {
			sqlTag = "SCHEMA_VIEW";
		} else if (type.equals("sequence")) {
			sqlTag = "SCHEMA_SEQUENCE";
		} else if (type.equals("synonym")) {
			sqlTag = "SCHEMA_SYNONYM";
		} else if (type.equals("constraint")) {
			sqlTag = "SCHEMA_CONSTRAINT";
		} else if (type.equals("dblink")) {
			sqlTag = "SCHEMA_DB_LINK";
		} else if (type.equals("trigger")) {
				sqlTag = "SCHEMA_TRIGGER";
		}

		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
		Hashtable criteriaTab = new Hashtable();
		criteriaTab.put("owner", owner);
		criteriaTab.put("obj", obj);
		dbhs.setCriteriaTable(criteriaTab);

		dbhs.executeSQL(sqlTag, "SchemaResult", null, null, out);
		out.println("Total records: " + dbhs.getRecordCount());

System.out.println("------->" + type);

		//////////////////////
		// one more table
		//////////////////////
		if (type.equals("index") || type.equals("view")
					|| type.equals("synonym") || type.equals("trigger")) {
			out.println("<p>");

			if (type.equals("index")) {
				out.println("<h4>Column Information:</h4>");
				Database o = new Database(machine, port, username, password, sid);
				String sqlStr = "select distinct table_name "
							+ " from dba_ind_columns"
							+ " where index_owner = upper('" + owner + "')"
							+ " and index_name = upper('" + obj + "')";
				o.setSql(sqlStr);
				o.executeSQL("DUMMY");
				Vector resultVect = o.getResultVect();
				for (int i=0;i<resultVect.size();i++) {
					String data = (String) resultVect.elementAt(i);
					out.println("<h3>Table: " + data + "</h3>");
				}

				sqlTag = "SCHEMA_IND_COLUMN";
				criteriaTab = new Hashtable();
				criteriaTab.put("owner", owner);
				criteriaTab.put("obj", obj);
				dbhs.setCriteriaTable(criteriaTab);

				dbhs.executeSQL(sqlTag, "SchemaResult", null, null, out);
				out.println("Total records: " + dbhs.getRecordCount());

			} else if (type.equals("view")) {
				out.println("<h4>View creation script:</h4>");
				Database db = new Database(machine, port, username, password, sid);
				criteriaTab = new Hashtable();
				criteriaTab.put("owner", owner);
				criteriaTab.put("obj", obj);
				db.setCriteriaTable(criteriaTab);
				db.executeSQL("SCHEMA_VIEW_TEXT");
				//String viewSqlStr = db.getDataStr();

				//out.println("<TEXTAREA cols=100 id=test name=test rows=30>");
				out.println("<pre>");
				//StringTokenizer st = new StringTokenizer(viewSqlStr, "\n");
				//while (st.hasMoreTokens()) {
				//	 out.println(st.nextToken());
				//}
				out.println(db.getDataStr());
				out.println("</pre>");
				//out.println("</TEXTAREA>");
			} else if (type.equals("synonym")) {
				sqlTag = "SCHEMA_SYNONYM_COLUMN";

				criteriaTab = new Hashtable();
				criteriaTab.put("owner", owner);
				criteriaTab.put("obj", obj);
				dbhs.setCriteriaTable(criteriaTab);

				dbhs.executeSQL(sqlTag, "SchemaResult", null, null, out);
				out.println("Total records: " + dbhs.getRecordCount());

			} else if (type.equals("trigger")) {
				out.println("<h4>View creation script:</h4>");
				Database db = new Database(machine, port, username, password, sid);
				criteriaTab = new Hashtable();
				criteriaTab.put("owner", owner);
				criteriaTab.put("obj", obj);
				db.setCriteriaTable(criteriaTab);
				db.executeSQL("SCHEMA_TRIGGER_TEXT");
				String viewSqlStr = db.getDataStr();

				out.println("<TEXTAREA cols=100 id=test name=test rows=30>");
				StringTokenizer st = new StringTokenizer(viewSqlStr, "\n");
				while (st.hasMoreTokens()) {
					 out.println(st.nextToken());
				}
				out.println("</TEXTAREA>");
			}
		}
	}
%>



</body>
</html>
