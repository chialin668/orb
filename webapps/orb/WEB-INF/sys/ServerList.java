package com.orb.sys;

import java.io.Serializable;
import java.util.*;


import java.util.Hashtable;

public class ServerList implements Serializable {

	private static Hashtable serverTab = new Hashtable();


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

