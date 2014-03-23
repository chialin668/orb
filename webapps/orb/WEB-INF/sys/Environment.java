package com.orb.sys;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import com.orb.oracle.SQLReader;

public class Environment extends HttpServlet {

	public static String TOMCAT_ROOT;
	public static String WEB_SERVER_NAME;
	public static String SQL_FILE;
	public static String SERVER_FILE;
	public static String JSP_ROOT;


	public static String DELIMITER = "^";
	public static String COL_DELIMITER = "^";
	public static String REC_DELIMITER = "\n";

	// for vml graph
	public static int GRAPH_WIDTH = 400;
	public static int GRAPH_HEIGHT = 120;

	public static double GRAPH_X_MIN = 400;
	public static double GRAPH_X_MAX = 4180;
	public static double GRAPH_Y_MIN = 530;
	public static double GRAPH_Y_MAX = 2500;


	public static double DOUBLE_MAX = 2147483647;
	public static double DOUBLE_MIN = -2147483647;


   /**
	*
	* Reading the environment variables from web.xml
	*
	*****************************************************************/
	public void init(ServletConfig config) throws ServletException {
		super.init(config);


		System.out.println ("initialized Init servlet for orb....");

		TOMCAT_ROOT = getServletContext().getInitParameter("TOMCAT_ROOT");
		WEB_SERVER_NAME  = getServletContext().getInitParameter("WEB_SERVER_NAME");
		SQL_FILE = TOMCAT_ROOT + File.separator + "webapps"
								+ File.separator + WEB_SERVER_NAME
								+ File.separator + "conf"
								+ File.separator +
								getServletContext().getInitParameter("SQL_FILE_NAME");

		SERVER_FILE = TOMCAT_ROOT + File.separator + "webapps"
								+ File.separator + WEB_SERVER_NAME
								+ File.separator + "conf"
								+ File.separator +
								getServletContext().getInitParameter("SERVER_FILE_NAME");

		System.out.println ("[ORB] Tomcat Root = " + TOMCAT_ROOT);
		System.out.println ("[ORB] Web Server = " + WEB_SERVER_NAME);

		System.out.println ("[ORB] Server File =" + SERVER_FILE);
			ServerInfo si = new ServerInfo();
			si.init();

		System.out.println ("[ORB] SQL File = " + SQL_FILE);
			SQLReader sr = new SQLReader();
			sr.read(SQL_FILE);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		// do nothing here
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		// do nothing here
	}

	public void destroy()
	{
		// do nothing here
	}
}

