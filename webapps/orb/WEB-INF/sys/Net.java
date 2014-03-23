package com.orb.sys;

import java.util.*;

public class Net extends NCObject {
	private Hashtable machineTab = new Hashtable();
	protected String netAddress;

	public Net(String netAddress) {
		this.netAddress = netAddress;
	}

	public void addMachine(String name, Machine machine) {
		machineTab.put(name, machine);
	}

	public Hashtable getMachineTab() {
		return machineTab;
	}

	public Machine getMachineByName(String name) {
		return (Machine) machineTab.get(name);
	}

}