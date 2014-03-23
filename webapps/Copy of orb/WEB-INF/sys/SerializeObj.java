package com.orb.sys;

import java.io.*;
import java.util.*;




public class SerializeObj {
	private String CLASSNAME = this.getClass().getName();


	private String fileName = Environment.SERVER_FILE;

	public SerializeObj() {

	}

	public ServerInfo read() {
		String METHODNAME = "read";
System.out.println("----------->" + fileName);
		ServerInfo si = null;
		try {
			FileInputStream istream = new FileInputStream(fileName);
			ObjectInputStream in = new ObjectInputStream(istream);

			si = (ServerInfo) in.readObject();
			in.close();

		} catch (Exception e) {
			String message = "Error reading servr iformation!!\n"
								+ "File Name: " + fileName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);

			e.printStackTrace();
			return null;
		}

		return si;
	}

	public boolean write(ServerInfo si) {
		String METHODNAME = "write";
		try {
			FileOutputStream ostream = new FileOutputStream(fileName);
			ObjectOutputStream out = new ObjectOutputStream(ostream);
			out.writeObject(si);
			out.flush();
			out.close();

		} catch (Exception e) {
			String message = "Error reading servr iformation!!\n"
								+ "File Name: " + fileName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			return false;
		}

		return true;

	}


	public boolean add() {

		return true;
	}

	public boolean delete() {
		return true;
	}

	public void test() {

		try {

			ServerInfo si = new ServerInfo();
			si.init();
			this.write(si);
			//si = null;

			si = this.read();

			Server s = si.getServerBySid("REPOS");
			System.out.println(s.getMachine());
			System.out.println(s.getPort());
			System.out.println(s.getSid());

			Server abc = new Server(Server.ORACLE, "8.1.x", "10.10.10.1", "1521", "system", "manager", "ABC");
			si.add("ABC", abc);
			this.write(si);

			si = this.read();
			s = si.getServerBySid("ABC");
			System.out.println(s.getMachine());
			System.out.println(s.getPort());
			System.out.println(s.getSid());


		} catch (Exception e) {
			e.printStackTrace();
		}

//		try { Thread.sleep(10*1000); } catch (java.lang.InterruptedException e) {}

	}



	public static void main(String args[]) {
		SerializeObj so = new SerializeObj();
		so.test();

	}
}