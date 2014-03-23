package com.orb.sys;

import java.io.*;
import java.util.*;

public class Config {
	private String CLASSNAME = this.getClass().getName();

	protected FileOutputStream ostream;
	protected ObjectOutputStream out;

	protected FileInputStream istream;
	protected ObjectInputStream in;

	protected String fileName;
	protected final static int READ = 0;
	protected final static int WRITE = 1;

	//
	//
	//
	public Config(String fileName) {
		this.fileName = fileName;
	}

	public boolean open(int type) {
		String METHODNAME = "open";

		switch (type) {
			case Config.READ:
				try {
					istream = new FileInputStream(fileName);
					in = new ObjectInputStream(istream);

				} catch (IOException e) {
					String message = "Error opening file for read!  File name: " + fileName;
					SysLog log = new SysLog();
					log.write(CLASSNAME, METHODNAME,
										SysLog.ML_SEVERE,
										e,
										message);
					return false;
				}
				break;

			case Config.WRITE:
				try {
					ostream = new FileOutputStream(fileName);
					out = new ObjectOutputStream(ostream);
				} catch (IOException e) {
					String message = "Error opening file for write!  File name: " + fileName;
					SysLog log = new SysLog();
					log.write(CLASSNAME, METHODNAME,
										SysLog.ML_SEVERE,
										e,
										message);
					return false;
				}
				break;

			default:
				String message = "Wrong opening type!! Type: " + type;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									null,
									message);
				return false;
		}

		return true;
	}

	public boolean close() {
		String METHODNAME = "close";

		if (istream != null) {

			try {
				istream.close();

			} catch (IOException e) {
				String message = "Error closing input (read) file!  File name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return false;
			}

		} else if (ostream != null) {

			try {
				ostream.close();

			} catch (IOException e) {
				String message = "Error closing output (write) file!  File name: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return false;
			}
		}

		return true;
	}

	// read the configuration file
	public Vector read() {
		String METHODNAME = "read";

		Vector retVect = new Vector();

		if (in == null) {
			String message = "Object input stream should not be null!!";
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								null,
								message);
			return null;
		}

		//
		// read the data
		//
		while (true) {

			try {
				retVect.add(in.readObject());

			} catch (java.io.EOFException e) {
				return retVect;

			} catch (IOException e) {
				String message = "Error reading the data from file: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return null;

			} catch (java.lang.ClassNotFoundException e) {
				String message = "Class not found from the input stream!! ";
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
									SysLog.ML_SEVERE,
									e,
									message);
				return null;
			}
		}
	}

	// write the data to the configuration file
	public boolean write(String inStr) {
		String METHODNAME = "write";

		try {

			out.writeObject(inStr);

		} catch (IOException e) {
			String message = "Error writing string to the file"
								+ "\ndata: " + inStr;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								e,
								message);
			return false;
		}

		return true;
	}




	public static void main(String args[]) {
		Config cf = new Config("test.cfg");
		cf.open(Config.WRITE);
		cf.write("test1");
		cf.write("test2");
		cf.write("test3");
		cf.close();

		cf.open(Config.READ);
		Vector vect = cf.read();
		for (int i=0;i<vect.size();i++)
			System.out.println(vect.elementAt(i));

		cf.close();

//		or.read();

	}







}