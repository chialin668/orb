import java.io.*;
import java.util.*;

public class ObjReader {
	private FileOutputStream ostream;
	private ObjectOutputStream out;

	private FileInputStream istream;
	private ObjectInputStream in;

	private String fileName = "test.out";

	public Vector read() {
		Vector objVect = new Vector();
		try {
			istream = new FileInputStream(fileName);
			in = new ObjectInputStream(istream);

			while (true) {
				Object obj = in.readObject();
				objVect.add(obj);
			}


		} catch (java.io.EOFException e) {

			try {
				in.close();
			} catch (Exception e1) {
				e1.printStackTrace();
			}

			return objVect;

		} catch (Exception e) {
			e.printStackTrace();

		}

		// should never be here!!
		return null;
	}


	public void write(Vector objVect) {

		try {
			ostream = new FileOutputStream(fileName);
			out = new ObjectOutputStream(ostream);

			for(int i=0;i<objVect.size();i++) {
				out.writeObject(objVect.elementAt(i));
			}


			out.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

	}




	public static void main(String args[]) {
		ObjReader or = new ObjReader();
/*
		Server orb = new Server(Server.SOLARIS, "2.7.x", "orb", "23", "oracle", "oracle00", "orb");
		Server ora817 = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA817");
		Server ora901 = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA901");
		Vector objVect = new Vector();
		objVect.add(orb);
		objVect.add(ora817);
		objVect.add(ora901);

		or.write(objVect);
*/

		Vector outVect = or.read();

		for(int i=0;i<outVect.size();i++) {
			Server s = (Server) outVect.elementAt(i);
			System.out.println(s.getSid());
		}

	}







}