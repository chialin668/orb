package com.orb.oracle;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.orb.sys.*;


/**
*
* just a (servlet) wrapper
*
**/
public class DBDataBindingServlet extends HttpServlet {
	private String CLASSNAME = this.getClass().getName();

	private DBDataBinding dBinding;
	private String dbString;
	private String id;
	private static Hashtable dataTab = new Hashtable();


	public boolean executeSQL(String machine, String port,
					String username, String password, String sid,
					String sqlTag) {
		String METHODNAME = "executeSQL";

		dBinding = new DBDataBinding(machine, port, username, password, sid);

		if (!dBinding.executeSQL(sqlTag)) {
			String message = "Error executing SQL: " + sqlTag;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return false;
		}

		dbString = dBinding.getDBString();

		// save the data for furture use
		java.util.Date date = new java.util.Date();
		Random r = new Random(date.getTime());

		Long l = new Long(r.nextLong());
		if (l.longValue() < 0)
			l = new Long(l.longValue() * -1);

		id = l.toString();

		dataTab.put(id, dbString);

		return true;
	}

	public String getId() {	return id; }
	public String getHTMLCol() { return dBinding.getHTMLCol(); }
	public String getHTMLDataFld() { return dBinding.getHTMLDataFld(); }
	public String getDataBindingObj(String url, String param) { return dBinding.getDataBindingObj(url, param); }
	public String getDataBindingTable(String title) { return dBinding.getDataBindingTable(title); }
	public String getSelectDataBindingTable(String title, String colName) { return dBinding.getSelectDataBindingTable(title, colName); }
	public String getDBString() { return dbString; }


   /**
	*
	* servlet
	*
	**/
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws IOException, ServletException
    {
        PrintWriter out = response.getWriter();

		String id = request.getParameter("id");
		out.println((String) dataTab.get(id));

		// remove the data from the hashtable
		dataTab.remove(id);
    }

	public static void main(String args[]) {

		DBDataBindingServlet db = new DBDataBindingServlet();
		db.executeSQL("Chialin", "1521", "system", "oracle00", "CHIALIN", "OV_INIT_PARAM");
		System.out.println("----------------");
		System.out.println(db.getHTMLCol());
		System.out.println(db.getHTMLDataFld());
		System.out.println(db.getId());
		System.out.println(db.getDBString());
		System.out.println("----------------");

	}


}