package com.orb.sys;

import java.util.*;
import java.io.Serializable;


public class Server  implements Serializable {
	public final static int ALL 		= 0;
	public final static int ROOT 		= 1;
	public final static int NETWORK 	= 2;
	public final static int SOLARIS 	= 3;
	public final static int LINUX 	= 4;
	public final static int ORACLE 	= 5;
	public final static int SYBASE 	= 6;

	private String DELIMITER = Environment.DELIMITER;

	private String pSid;		// parent Sid
	private String version;
	private int type;
	private String machine;
	private String port = "1521";
	private String username;
	private String password;
	private String sid;

	public Hashtable tab = new Hashtable();


	public Server(int type,
					String version,
						String machine,
						String port,
						String username, // Oracle username
						String password, // Oracle password
						String sid) {
		this(type, version, machine, port, username, password, sid, null);

	}

	public void test() {
		tab.put("123", "123");
		tab.put("aa", "aa");
	}

	public Server(int type,
					String version,
						String machine,
						String port,
						String username, // Oracle username
						String password, // Oracle password
						String sid,
						String pSid) {
		this.type = type;
		this.version = version;
		this.machine = machine;
		if (type == Server.SOLARIS || type == Server.LINUX)
			if (port == null)
				this.port = "23";
			else
				this.port = port;

		if (type == Server.ORACLE)
			if (port == null)
				port = "1521";
			else
				port = port;

		this.username = username;
		this.password = password;
		this.sid = sid;
		this.pSid = pSid;
	}


	public Server(String machine,
						String port,
						String username, // Oracle username
						String password, // Oracle password
						String sid) {
		this.machine = machine;
		if (port != null)
			this.port = port;

		this.username = username;
		this.password = password;
		this.sid = sid;
	}

	public String toString() {
		return type + DELIMITER
				+ version + DELIMITER
				+ machine + DELIMITER
				+ port + DELIMITER
				+ username + DELIMITER
				+ password + DELIMITER
				+ sid + DELIMITER
				+ pSid;
	}

	public int getType() { return type; }
	public String getMachine() { return machine; }
	public String getPort() { return port; }
	public String getUsername() { return username; }
	public String getPassword() { return password; }
	public String getSid() { return sid; }
	public String getParentSid() { return pSid; }



	public static void main(String args[]) {

		Server orb = new Server(Server.SOLARIS, "2.7.x", "orb", "23", "oracle", "oracle00", "orb");
			Server ora817 = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA817");
			Server ora901 = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA901");

	}



}