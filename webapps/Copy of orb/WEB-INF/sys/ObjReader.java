package com.orb.sys;

import java.io.*;
import java.util.*;

public class ObjReader {
	private FileOutputStream ostream;
	private ObjectOutputStream out;

	private FileInputStream istream;
	private ObjectInputStream in;

	private String fileName = "test.out";

	public Object read() {
		Object obj = null;
		try {
			istream = new FileInputStream(fileName);
			in = new ObjectInputStream(istream);
			obj = in.readObject();

			in.close();
		} catch (Exception e) {
			e.printStackTrace();

		}
		return obj;
	}


	public void write(Object obj) {

		try {
			ostream = new FileOutputStream(fileName);
			out = new ObjectOutputStream(ostream);
			out.writeObject(obj);

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}


//////////////////////////////////////////////////////////////////////////////////////////////////////

	public static void main(String args[]) {
		ObjReader or = new ObjReader();

		Server ora817 = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA817");
		Server ora901 = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA901");
		Machine m = new Machine("orb", "192.168.1.123");
			m.addServer("ORA817", ora817);
			m.addServer("ORA901", ora901);
		Net n = new Net("192.168.1");
			n.addMachine("orb", m);
		or.write(n);



		Net out = (Net) or.read();
		Hashtable machineTab = out.getMachineTab();
		Enumeration machineNames = machineTab.keys();

		while(machineNames.hasMoreElements()) {
			String machineName = (String) machineNames.nextElement();
			Machine machine = (Machine) machineTab.get(machineName);

			System.out.println(machine.getMachineName());

			Hashtable serverTab = machine.getServerTab();
			Enumeration servers = serverTab.keys();

			while(servers.hasMoreElements()) {
				String serverName = (String) servers.nextElement();
				Server s = (Server) serverTab.get(serverName);
				System.out.println("\t" + s.getSid());
			}
		}

	}







}