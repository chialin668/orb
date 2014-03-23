import java.io.*;
import java.net.*;

public class Top {

	public static void main(String[] args) {

System.out.println("==========");
		Probe machine1 = new Probe("orb", 3341);
//		Probe machine2 = new Probe("mylinux", 3350);

		machine1.start();
//		machine2.start();
	}


}

