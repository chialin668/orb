package com.orb.oracle;

import java.io.*;

// just a wrapper!!
public class ObjReader {
	private FileOutputStream ostream;
	private ObjectOutputStream out;

	private FileInputStream istream;
	private ObjectInputStream in;

	private String fileName = "test.out";

	public ObjReader(String fileName) {
		this.fileName = fileName;
	}

	public Object read() {
		Object obj = null;

		try {
			istream = new FileInputStream(fileName);
			in = new ObjectInputStream(istream);

			obj = in.readObject();

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

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

/*
	public static void main(String args[]) {
		ObjReader or = new ObjReader();
		or.write();
		or.read();

	}
*/

}