package com.orb.sys;

import java.io.*;
import java.util.*;

public class ServerReader {
	private String CLASSNAME = this.getClass().getName();
	private String fileName = Environment.SERVER_FILE;

	private FileOutputStream ostream;
	private ObjectOutputStream out;

	private FileInputStream istream;
	private ObjectInputStream in;

	private static int count = 0;

	private boolean debug = false;

   /**
	*
	*
	*
	**/
	public Hashtable read() {
		return this.read(Server.ALL);

	}

   /**
	*
	*
	*
	**/
	public Hashtable read(int type) {
		String METHODNAME = "read";

		Hashtable tmpTab = new Hashtable();

		if (debug) System.out.println("fileName = " + fileName);

		//////////////////////////////
		// open the file for read
		//////////////////////////////
		try {
			istream = new FileInputStream(fileName);

		} catch (java.io.FileNotFoundException e) {

			// is not there. create a new one
			try {
				ostream = new FileOutputStream(fileName);
				ostream.close();
				return tmpTab;

			} catch (java.io.IOException e1) {
				String message = "Error creating a new file!!\n"
									+ "File Name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e1,
									message);
				return null;
			}

		}

		try {
			in = new ObjectInputStream(istream);

		} catch (java.io.EOFException e) {
			// empty file (first time)
			// IS NOT CALLED????
			return tmpTab;

		} catch (java.io.IOException e) {
			///@@@@@???????
			//e.printStackTrace();
			return tmpTab;
		}


		//////////////////////////////
		//  read the data
		//////////////////////////////
		while (true) {
			try {
				Server s = (Server) in.readObject();

				int sType = s.getType();
				if (sType == type || type == Server.ALL) {
					String sid = s.getSid();
					tmpTab.put(sid, s);
					if (debug) System.out.println("sid = " + sid);
				}
			} catch (java.io.EOFException e) {


				//////////////////////////////
				//  close the file
				//////////////////////////////
				try {
					istream.close();

				} catch (java.io.IOException e1) {
					String message = "Error closing the file!!\n"
										+ "File Name: " + fileName;
					SysLog log = new SysLog();
					log.write(CLASSNAME, METHODNAME,
										SysLog.ML_SEVERE,
										e,
										message);
					return null;
				}


				// always go back from here!!!!!
				return tmpTab;

			} catch (java.lang.ClassNotFoundException e) {
				String message = "Error finding the class in the file!!\n"
									+ "File Name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return null;

			} catch (java.io.OptionalDataException e) {
				String message = "Error!!\n"
									+ "File Name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return null;

			} catch (java.io.IOException e) {
				String message = "IO Error reading the file!!\n"
									+ "File Name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return null;
			}
		}

	}


   /**
	*
	*
	*
	**/
	public boolean add(Server s) {
		String METHODNAME = "add";
		boolean isThere = false;

		// read the data first!!
		Hashtable tmpTab = this.read();

		//////////////////////////////
		//  open the data for write
		//////////////////////////////
		try {
			ostream = new FileOutputStream(fileName);

		} catch (java.io.FileNotFoundException e) {

			String message = "Error finding the file!!\n"
								+ "File Name: " + fileName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								e,
								message);
			return false;
		}

		try {
			out = new ObjectOutputStream(ostream);

		} catch (java.io.IOException e) {

			String message = "IO Error setting up the output stream the file!!\n"
								+ "File Name: " + fileName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								e,
								message);
			return false;

		}

		//////////////////////////////
		//  write the data
		//////////////////////////////
		Enumeration keys = tmpTab.keys();

		while (keys.hasMoreElements()) {
			String nextKey = (String) keys.nextElement();

			// exists!!
			if (s.getSid().equals(nextKey))
				isThere = true;

			try {
				Server sout = (Server) tmpTab.get(nextKey);
				out.writeObject(sout);

			} catch (java.io.IOException e) {
				String message = "IO Error writing the file!!\n"
									+ "File Name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return false;
			}
		}

		if (!isThere) {

			// add the new one
			try {
				out.writeObject(s);

			} catch (java.io.IOException e) {

				String message = "IO Error writing the file!!\n"
									+ "File Name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return false;

			}

		}

		//////////////////////////////
		//  close the file
		//////////////////////////////
		try {
			out.flush();
			ostream.close();

		} catch (java.io.IOException e) {

			String message = "IO Error closing the file!!\n"
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

   /**
	*
	*
	*
	**/
	public boolean delete(String sid) {
		String METHODNAME = "delete";

		// read the data first!!
		Hashtable tmpTab = this.read();

		//////////////////////////////
		//  open the data for write
		//////////////////////////////
		try {
			ostream = new FileOutputStream(fileName);

		} catch (java.io.FileNotFoundException e) {

			String message = "Error finding the file!!\n"
								+ "File Name: " + fileName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								e,
								message);
			return false;
		}

		try {
			out = new ObjectOutputStream(ostream);

		} catch (java.io.IOException e) {

			String message = "IO Error setting up the output stream the file!!\n"
								+ "File Name: " + fileName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								e,
								message);
			return false;

		}

		//////////////////////////////
		//  write the data
		//////////////////////////////
		Enumeration keys = tmpTab.keys();

		while (keys.hasMoreElements()) {
			String nextKey = (String) keys.nextElement();

			// don't save it
			if (nextKey.equals(sid))
				continue;

			try {
				Server sout = (Server) tmpTab.get(nextKey);
				out.writeObject(sout);

			} catch (java.io.IOException e) {
				String message = "IO Error writing the file!!\n"
									+ "File Name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return false;
			}
		}

		//////////////////////////////
		//  close the file
		//////////////////////////////
		try {
			out.flush();
			ostream.close();

		} catch (java.io.IOException e) {

			String message = "IO Error closing the file!!\n"
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

   /**
	*
	*
	*
	**/
	public boolean hasServer(String sid) {

		Hashtable tmpTab = this.read();
		Server s = (Server) tmpTab.get(sid);
		if (s != null)
			return true;
		else
			return false;
	}


   /**
	*
	*	example of building a tree
	*
	**/
	public String buildTree(String parentSid) {
		count = 0;
		return this.build(parentSid);

	}
	public String build(String parentSid) {

		Hashtable tmpTab = this.read();
		count ++;
		String retStr = "";
//System.out.println(count);

		Enumeration keys = tmpTab.keys();
		while(keys.hasMoreElements()) {
			String nextKey = (String) keys.nextElement();

			Server s = (Server) tmpTab.get(nextKey);
			String pSid = s.getParentSid();
			if (pSid != null && pSid.equals(parentSid)) {
				//
				// generate the output
				//
				//System.out.println(pSid + "-> " + s.getSid());
				//System.out.println(s.getSid());
				String sid = s.getSid();
				String url = "";
				int type = s.getType();
				switch (type) {
					case Server.ALL:
						url = "";
						break;
					case Server.SOLARIS:
						url = "/orb/jsp/sys/UnixOverview1.jsp";
						break;
					case Server.ORACLE:
						url = "/orb/jsp/sys/Overview.jsp";
						break;
					default:
						break;
				}

				//System.out.println(count);

				switch (count) {
					case 1:
						retStr = retStr + "aux1=insFld(foldersTree, gFld('" + sid + "', '" + url + "'))\n";
						break;
					case 2:
						retStr = retStr + "\taux2 = insFld(aux1, gFld('" + sid + "', '" + url + "?machine=" + sid + "'))\n";
						break;
					case 3:
						retStr = retStr + "\t\tinsDoc(aux2, gLnk(2, '" + sid + "', '" + url + "?sid=" + sid + "'))\n";
						break;
					default:
						break;
				}

				retStr = retStr + this.build(sid);
				count --;
			}
		}

		// done!!
		return retStr;
	}


	public static void main(String args[]) {

		ServerReader ServerReader = new ServerReader();

		Hashtable tmpTab;

		Server root = new Server(Server.ROOT, "", "", "", "", "", "ROOT");
		Server abc = new Server(Server.NETWORK, "", "", "", "", "", "192.168.1", "ROOT");
		Server devdcx = new Server(Server.SOLARIS, "2.7.x", "devdcx", "23", "oracle", "oracle00", "devdcx", "192.168.1");
			Server dnac = new Server(Server.ORACLE, "8.1.x", "devdcx", "1521", "system", "oracle00", "DNAC", "devdcx");
			Server dpfzr = new Server(Server.ORACLE, "8.1.x", "devdcx", "1521", "system", "systempass", "DPFZR", "devdcx");

		Server qadcdb = new Server(Server.SOLARIS, "2.7.x", "qadcdb", "23", "oracle", "oracle00", "qadcdb", "192.168.1");
			Server qadnac = new Server(Server.ORACLE, "8.1.x", "qadcdb", "1521", "system", "oracle00", "QADNAC", "qadcdb");

		Server dcdb = new Server(Server.SOLARIS, "2.7.x", "dcdb", "23", "oracle", "oracle00", "dcdb", "192.168.1");
			Server dcprod = new Server(Server.ORACLE, "8.1.x", "dcdb", "1521", "system", "oracle00", "DCPROD", "dcdb");

		ServerReader.add(root);
		ServerReader.add(abc);
		ServerReader.add(devdcx);
		ServerReader.add(dnac);
		ServerReader.add(dpfzr);
		ServerReader.add(qadcdb);
		ServerReader.add(qadnac);
		ServerReader.add(dcdb);
		ServerReader.add(dcprod);

//		ServerReader.delete("devdcx");

		tmpTab = ServerReader.read();
		Enumeration keys = tmpTab.keys();
		while(keys.hasMoreElements()) {
			String nextKey = (String) keys.nextElement();

			Server s = (Server) tmpTab.get(nextKey);
			System.out.println(s.getSid());
		}

		System.out.println(ServerReader.hasServer("dcdb"));
		System.out.println(ServerReader.buildTree("ROOT"));
	}
}

