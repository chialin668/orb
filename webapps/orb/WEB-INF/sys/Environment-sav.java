package com.orb.sys;

import java.io.File;

public class Environment {

	public static String TOMCAT_ROOT = System.getProperty("tomcat.home");
	public static String DOC_ROOT = "C:\\Chialin\\tomcat-321\\webapps\\orb\\WEB-INF\\classes\\";
	//public static String SQL_FILE = Environment.DOC_ROOT + "test.sql";
//	public static String SQL_FILE = Environment.TOMCAT_ROOT
	public static String SQL_FILE = "C:\\Chialin\\tomcat-321"
										+ File.separator
										+ "conf"
										+ File.separator
										+ "database.sql";
	public static String SERVER_FILE = Environment.DOC_ROOT + "server.info";

	public static String JSP_ROOT = TOMCAT_ROOT
									+ File.separator
									+ "webapps"
									+ File.separator
									+ "ROOT"
									+ File.separator
									+ "js";

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

}