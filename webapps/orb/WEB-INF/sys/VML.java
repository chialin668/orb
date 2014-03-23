package com.orb.sys;

import java.util.*;

public class VML {

	public String line () {

		String retStr = "";

		for (int i=20;i<50;i=i+2)
			retStr = retStr + "<v:line from=\"" + i + "pt," + 20 + "pt\""
						+ " to=\"" + i + "pt," + 100 + "pt\""
						+ " strokecolor=\"red\" \n"
						+ " strokeweight=\"1pt\">"
						+ " </v:line>" + "\n";



		return retStr;
	}

	public String polyline(String color) {
		String retStr = "<v:polyline points = \"";
		java.util.Date date = new java.util.Date();
		Random r = new Random(date.getTime());


		//id = l.toString();


		for (int i=0;i<360;i++) {
			Long l = new Long(r.nextLong());
			long sl = (l.longValue() % 100);
			if (sl<0)
				sl = sl *-1;

			retStr = retStr + i + "," + sl + ",";
		}

		retStr = retStr.substring(0, retStr.length()-1);
		retStr = retStr + "\" strokecolor = \"" + color +
					"\" strokeweight = \"1pt\"></v:polyline>";

		return retStr;
	}


	public static void main(String args[]) {

		System.out.println("<html xmlns:v=\"urn:schemas-microsoft-com:vml\">");
		System.out.println("<head>");
		System.out.println("<style>");
		System.out.println("v\\:* { behavior: url(#default#VML); }");
		System.out.println("</style>");
		System.out.println("</head>");
		System.out.println("<body>");
				VML v = new VML();
				System.out.println(v.polyline("blue"));
				System.out.println("\n");
				//System.out.println(v.polyline("red"));
		System.out.println("</body>");
		System.out.println("</html>");



	}

}