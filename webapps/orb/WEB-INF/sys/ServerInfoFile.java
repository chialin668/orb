package com.orb.sys;


import java.io.*;
import java.util.*;

public class ServerInfoFile {
	FileOutputStream ostream;
	ObjectOutputStream out;

	FileInputStream istream;
	ObjectInputStream in;

	public boolean open() {
		try {
//			ostream = new FileOutputStream("t.tmp");
//			out = new ObjectOutputStream(ostream);

			istream = new FileInputStream("t.tmp");
			in = new ObjectInputStream(istream);
		} catch (Exception e) {e.printStackTrace();}

		return true;

	}

	public boolean close() {
		try {
//			ostream.close();
			istream.close();
		} catch (Exception e) {e.printStackTrace();}

		return true;

	}

	public boolean write(Server si) {
		try {
			out.writeObject(si);
			out.flush();
		} catch (Exception e) {e.printStackTrace();}

		return true;
	}

	public Server read() {
		Server si = null;
		try {
			si = (Server) in.readObject();
		} catch (Exception e) {e.printStackTrace();}

		return si;
	}

	public static void main(String args[]) {

		ServerInfoFile sif = new ServerInfoFile();
		sif.open();
/*
		Server chialin = new Server(Server.ORACLE, "8.1.x", "Chialin", "1521", "system", "oracle00", "CHIALIN");
		Server orb = new Server(Server.SOLARIS, "2.7.x", "orb", "23", "oracle", "oracle00", "orb");
		Server devdcx = new Server(Server.SOLARIS, "2.7.x", "devdcx", "23", "oracle", "oracle00", "devdcx");

		sif.write(chialin);
		sif.write(orb);
		sif.write(devdcx);
*/
		for (int i=0;i<4;i++) {
			Server s = sif.read();
				System.out.println(s.getMachine());
				System.out.println(s.getPort());
				System.out.println(s.getSid());
		}

		sif.close();

	}


}