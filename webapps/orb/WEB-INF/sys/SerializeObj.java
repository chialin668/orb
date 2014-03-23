package com.orb.sys;

import java.io.*;
import java.util.*;




public class SerializeObj {
	private String CLASSNAME = this.getClass().getName();


//	private String fileName = Environment.SERVER_FILE;
	private String fileName = "test.obj";

   /**
	*
	* Read Searialized Object
	*
	***************************************************************************/
	public ServerInfo read() {
		String METHODNAME = "read";
		System.out.println("Reading Server Information File... " + fileName);


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

   /**
	*
	* Write Searialized Object
	*
	***************************************************************************/
	public boolean write(ServerInfo si) {
		String METHODNAME = "write";
		try {
			FileOutputStream ostream = new FileOutputStream(fileName);
			ObjectOutputStream out = new ObjectOutputStream(ostream);
			out.writeObject(si);
			out.flush();
			out.close();

		} catch (Exception e) {
			String message = "Error writing servr iformation!!\n"
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
//			si.init();
//			this.write(si);
			//si = null;

//			si = this.read();

//			Server s = si.getServerBySid("REPOS");
//			System.out.println(s.getMachine());
//			System.out.println(s.getPort());
//			System.out.println(s.getSid());

			Server server;
//			Server server = new Server(Server.ORACLE, "8.1.x", "11.10.10.1", "1521", "system", "manager", "ABC");
//			si.add("ABC", server);
//			this.write(si);

			si = this.read();
			server = si.getServerBySid("ABC");
			System.out.println(server.getMachine());
			System.out.println(server.getPort());
			System.out.println(server.getSid());


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