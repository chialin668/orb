import java.io.*;
import java.util.*;

public class ABC {
	private String CLASSNAME = this.getClass().getName();
	private String fileName = Environment.SERVER_FILE;

	FileOutputStream ostream;
	ObjectOutputStream out;

	FileInputStream istream;
	ObjectInputStream in;


	public Vector read() {
		String METHODNAME = "read";

		Vector vect = new Vector();

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
				return vect;

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
			return vect;

		} catch (java.io.IOException e) {
			///@@@@@???????
			//e.printStackTrace();
			return vect;
		}


		//////////////////////////////
		//  read the data
		//////////////////////////////
		while (true) {
			try {
				Server s = (Server) in.readObject();
				vect.add(s);

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
				return vect;

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

	public boolean add(Server s) {
		String METHODNAME = "add";
		boolean isThere = false;
		Vector vect = this.read();

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
		for (int i=0;i<vect.size();i++) {
			try {
				Server sout = (Server) vect.elementAt(i);
				out.writeObject(sout);

				if (sout.getSid().equals(s.getSid()))
					isThere = true;

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
System.out.println("-------------" + fileName);
System.out.println(s.getMachine());
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
		}

		return true;
	}


	public static void main(String args[]) {

		ABC abc = new ABC();

		Vector vect;

		Server devdcx = new Server(Server.SOLARIS, "2.7.x", "devdcx", "23", "oracle", "oracle00", "devdcx");
			Server dnac = new Server(Server.ORACLE, "8.1.x", "devdcx", "1521", "system", "oracle00", "DNAC");
			Server dpfzr = new Server(Server.ORACLE, "8.1.x", "devdcx", "1521", "system", "systempass", "DPFZR");
		Server qadcdb = new Server(Server.SOLARIS, "2.7.x", "qadcdb", "23", "oracle", "oracle00", "qadcdb");
			Server qadnac = new Server(Server.ORACLE, "8.1.x", "qadcdb", "1521", "system", "oracle00", "QADNAC");
		Server dcdb = new Server(Server.SOLARIS, "2.7.x", "dcdb", "23", "oracle", "oracle00", "dcdb");
			Server dcprod = new Server(Server.ORACLE, "8.1.x", "dcdb", "1521", "system", "oracle00", "DCPROD");

		abc.add(devdcx);
		abc.add(dnac);
		abc.add(dpfzr);
		abc.add(qadcdb);
		abc.add(qadnac);
		abc.add(dcdb);
		abc.add(dcprod);

		vect = abc.read();
		for (int i=0;i<vect.size();i++) {
			Server s = (Server) vect.elementAt(i);
			System.out.println(s.getSid());
		}

	}
}

