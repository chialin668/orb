
import java.io.*;

public class ObjReader {
	private FileOutputStream ostream;
	private ObjectOutputStream out;

	private FileInputStream istream;
	private ObjectInputStream in;

	private String fileName = "test.out";

	public void read() {
		try {
			istream = new FileInputStream(fileName);
			in = new ObjectInputStream(istream);

//			ABC o = (ABC) in.readObject();
//			System.out.println(o.name);

			Test1 t = (Test1) in.readObject();
			System.out.println(t.get("DDNA20", "cpu"));

		} catch (Exception e) {
			e.printStackTrace();

		}
	}


	public void write() {

		try {

			ostream = new FileOutputStream(fileName);
			out = new ObjectOutputStream(ostream);

//			ABC o = new ABC();
//			o.id = 123;
//			o.name = "test";
//			out.writeObject(o);

			Test1 t = new Test1();
			t.put("DDNA20", "cpu", "2");
			t.put("DDNA20", "cpu", "3");
			t.put("DDNA20", "cpu", "2");
			t.put("DDNA20", "cpu", "2");
			t.put("DDNA20", "cpu", "6");
			t.put("DDNA20", "cpu", "5");
			t.put("DDNA20", "cpu", "4");
			out.writeObject(t);


		} catch (IOException e) {
			e.printStackTrace();
		}

	}




	public static void main(String args[]) {
		ObjReader or = new ObjReader();
		or.write();
		or.read();

	}







}