import java.io.*;
import com.orb.sys.Server;


public class WriteObj {
	public static void main(String args[]) {
	Server object = new Server(Server.ORACLE, "8.1.x", "orb", "1521", "system", "oracle00", "ORA817");
			try {
				// Serialize to a file
				ObjectOutput out = new ObjectOutputStream(new FileOutputStream("filename.ser"));
				out.writeObject(object);
				out.close();

				// Serialize to a byte array
//				ByteArrayOutputStream bos = new ByteArrayOutputStream() ;
//				out = new ObjectOutputStream(bos) ;
//				out.writeObject(object);
//				out.close();

				// Get the bytes of the serialized object
				byte[] buf = bos.toByteArray();
			} catch (IOException e) {
			}
	}
}