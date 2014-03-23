package com.orb.sys;

import java.io.Serializable;
import java.util.*;


// read the server information

import java.util.Hashtable;

public class ServerInfo implements Serializable {

	private static Hashtable serverTab = new Hashtable();
	private static boolean hasRead = false;

	public boolean init() {

		if (hasRead) return true;


		/*????
		Properties properties = System.getProperties();
		Enumeration keys = properties.keys();
		while(keys.hasMoreElements()) {
			String key = (String) keys.nextElement();
			System.out.println(key + ":" + (String) properties.get(key));

		}
		*/

		String tomcatHome = System.getProperty("tomcat.home");
		System.out.println(tomcatHome);


		System.out.println("Reading server information...");


		System.out.println("Generate jsp file...");

		// DNA Connects
		Server orb = new Server(Server.SOLARIS, "2.7.x", "orb", "23", "oracle", "oracle00", "orb");
			Server ora817 = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA817");
			Server ora901 = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA901");

		serverTab.put("orb", orb);
			serverTab.put("ORA817", ora817);
			serverTab.put("ORA901", ora901);

		Server o9nt = new Server(Server.SOLARIS, "Win2K", "o9nt", "23", "oracle", "oracle00", "o9nt");
			Server orant = new Server(Server.ORACLE, "8.1.x", "192.168.4.19", "1521", "system", "oracle00", "ORANT");

		serverTab.put("o9nt", o9nt);
			serverTab.put("ORANT", orant);


		// DNA Connects
		Server devdcx = new Server(Server.SOLARIS, "2.7.x", "devdcx", "23", "oracle", "oracle00", "devdcx");
			Server ddw = new Server(Server.ORACLE, "8.1.x", "devdcx", "1521", "system", "oracle00", "DDW");
			Server dpfzr = new Server(Server.ORACLE, "8.1.x", "devdcx", "1521", "system", "systempass", "DPFZR");
			Server tpfzr = new Server(Server.ORACLE, "8.1.x", "devdcx", "1521", "system", "systempass", "TPFZR");
			Server prodlims0 = new Server(Server.ORACLE, "8.1.x", "devdcx", "1521", "system", "oracle00", "PRODLIMS");

		serverTab.put("devdcx", devdcx);
			serverTab.put("DDW", ddw);
			serverTab.put("DPFZR", dpfzr);
			serverTab.put("TPFZR", tpfzr);
			serverTab.put("PRODLIMS", prodlims0);

		// LIMS
		Server collection_qa = new Server(Server.SOLARIS, "Win2K", "collection-qa", "23", "oracle", "oracle00", "collection-qa");
			Server dvlms = new Server(Server.ORACLE, "8.1.x", "collection-qa", "1521", "system", "oracle00", "DVLMS");
			Server qalms = new Server(Server.ORACLE, "8.1.x", "collection-qa", "1521", "system", "oracle00", "QALMS");
		serverTab.put("collection-qa", collection_qa);
			serverTab.put("DVLMS", dvlms);
			serverTab.put("QALMS", qalms);

		Server prodlims = new Server(Server.SOLARIS, "Win2K", "gino", "23", "oracle", "oracle00", "gino");
			Server prodlimsDB = new Server(Server.ORACLE, "8.1.x", "gino", "1521", "system", "oracle00", "PDLMS");
		serverTab.put("gino", prodlims);
			serverTab.put("PDLMS", prodlimsDB);

		// dna.com
		Server devsql = new Server(Server.SOLARIS, "2.7.x", "devsql", "23", "oracle", "oracle00", "devsql");
			Server ddna20 = new Server(Server.ORACLE, "8.1.x", "devsql", "1521", "system", "oracle00", "DDNA20");
			Server qdna20 = new Server(Server.ORACLE, "8.1.x", "devsql", "1521", "system", "oracle00", "QDNA20");
			serverTab.put("devsql", devsql);
			serverTab.put("DDNA20", ddna20);
			serverTab.put("QDNA20", qdna20);

		// GT
			Server dgt20 = new Server(Server.ORACLE, "8.1.x", "devsql", "1521", "system", "oracle00", "DGT20");
			Server qgt20 = new Server(Server.ORACLE, "8.1.x", "devsql", "1521", "system", "oracle00", "QGT20");
			serverTab.put("DGT20", qdna20);
			serverTab.put("QGT20", qdna20);


		// La Jolla
			Server dgtl = new Server(Server.ORACLE, "7.3.x", "172.16.1.20", "1521", "system", "systempass", "DGTL");
			Server dtwo = new Server(Server.ORACLE, "7.3.x", "172.16.1.20", "1521", "system", "systempass", "DTWO");
			Server dthr = new Server(Server.ORACLE, "7.3.x", "172.16.1.20", "1521", "system", "systempass", "DTHR");
			Server tgtl = new Server(Server.ORACLE, "7.3.x", "172.16.1.20", "1521", "system", "systempass", "TGTL");
			Server dlrq = new Server(Server.ORACLE, "7.3.x", "172.16.1.20", "1521", "system", "systempass", "DLRQ");
			Server clrq = new Server(Server.ORACLE, "7.3.x", "172.16.1.20", "1521", "system", "systempast", "CLRQ");
			serverTab.put("DGTL", dgtl);
			serverTab.put("DTWO", dtwo);
			serverTab.put("DTHR", dthr);
			serverTab.put("TGTL", tgtl);
			serverTab.put("DLRQ", dlrq);
			serverTab.put("CLRQ", clrq);

		// RTP
			Server pgtl = new Server(Server.ORACLE, "7.3.x", "bioserv-gc", "1521", "system", "systempast", "PGTL");
			Server vgtl = new Server(Server.ORACLE, "7.3.x", "bioserv-gc", "1521", "system", "systempass", "VGTL");
			serverTab.put("PGTL", pgtl);
			serverTab.put("VGTL", vgtl);

		// Boston
			Server pgtw = new Server(Server.ORACLE, "8.1.x", "172.10.1.18", "1521", "system", "manager", "PGTW");
			Server tgtw = new Server(Server.ORACLE, "8.1.x", "172.10.1.18", "1521", "system", "manager", "TGTW");
			Server lgtw = new Server(Server.ORACLE, "8.1.x", "172.10.1.18", "1521", "system", "manager", "LGTW");
			serverTab.put("PGTW", pgtw);
			serverTab.put("TGTW", tgtw);
			serverTab.put("LGTW", lgtw);

		//
			Server cchouxp = new Server(Server.ORACLE, "8.1.x", "cchouxp", "1521", "system", "manager", "CCHOUXP");
			serverTab.put("CCHOUXP", cchouxp);


		//
			Server dnareports = new Server(Server.ORACLE, "8.1.x", "dnareports", "1521", "system", "manager", "ORCL");
			serverTab.put("ORCL", dnareports);

		return true;
	}

	public Server getServerBySid(String sid) {
		return (Server) serverTab.get(sid);
	}


	public void add(String sid, Server s) {
		serverTab.put(sid, s);
	}

	public Hashtable getTable() {
		return serverTab;
	}

}