

import java.io.*;
import com.orb.sys.Server;

public class ReadObj {
	public static void main(String args[]) {

    try {
        // Deserialize from a file
        File file = new File("filename.ser");
        ObjectInputStream in = new ObjectInputStream(new FileInputStream(file));
        // Deserialize the object
        Server object = (Server) in.readObject();
        in.close();

		System.out.println(object.getMachine());


        // Get some byte array data
//        byte[] bytes = getBytesFromFile(file);
        // see e36 Reading a File into a Byte Array for the implementation of this method

        // Deserialize from a byte array
//        in = new ObjectInputStream(new ByteArrayInputStream(bytes));
//        button = (javax.swing.JButton) in.readObject();
//        in.close();


    } catch (ClassNotFoundException e) {
    } catch (IOException e) {
    }

    }
}