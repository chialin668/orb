package com.orb.sys;

import java.util.*;

public class Machine extends NCObject {
	private Hashtable serverTab = new Hashtable();
	protected String machineName;
	protected String ipAddress;

	public Machine() {
		//@@@ remove this!!
	}

	public Machine(String machineName, String ipAddress) {
		this.machineName = machineName;
		this.ipAddress = ipAddress;
	}


	public void addServer(String name, Server server) {
		serverTab.put(name, server);
	}

	public Hashtable getServerTab() {
		return serverTab;
	}

	public Server getServerByName(String name) {
		return (Server) serverTab.get(name);
	}


	public String getMachineName() { return machineName; }
}