package com.orb.oracle;

import java.util.Hashtable;

public class OraMonitor {
	private String CLASSNAME = this.getClass().getName();
	private static Hashtable monTab = new Hashtable();

	private String machine;
	private String port;
	private String username;
	private String password;
	private String sid;

	public OraMonitor(String machine, String port, String username, String password, String sid) {
		this.machine = machine;
		this.username = username;
		this.password = password;
		this.sid = sid;
	}

	public boolean start(String sqlTag) {
		String key = sid + sqlTag;
		String value = (String) monTab.get(key);

		if (value == null) {
			// not monitor before

			System.out.println("OraMonitor: monitoring " + key);

			OraStat1 o = new OraStat1(machine, port, username, password, sid);
			o.setSQL(sqlTag);
			Thread tr = new Thread(o);
			tr.start();

			// record that this key has monitored already!!
			monTab.put(key, key);

			return true;
		}

		return false;
	}

}