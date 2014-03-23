

import java.io.*;
import java.util.*;




public class SerializeObj {

	private String fileName = Environment.SERVER_FILE;
	private ServerInfo si;

	public SerializeObj() {

	}


	public void test() {

		si = new ServerInfo();
		si.init();

		try {
			FileOutputStream ostream = new FileOutputStream(fileName);
			ObjectOutputStream out = new ObjectOutputStream(ostream);
			out.writeObject(si);
			out.close();

			FileInputStream istream = new FileInputStream(fileName);
			ObjectInputStream in = new ObjectInputStream(istream);

			si = (ServerInfo) in.readObject();

			Server s = si.getServerBySid("REPOS");
			System.out.println(s.getMachine());
			System.out.println(s.getPort());
			System.out.println(s.getSid());

			s = si.getServerBySid("PGTL");
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