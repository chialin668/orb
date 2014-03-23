import java.io.*;
import java.net.*;

public class Telnet {
	public static void main(String[] args) throws IOException {
		Socket echoSocket = null;
		PrintWriter out = null;
		BufferedReader in = null;

		try {
			echoSocket = new Socket("orb", 23);
			out = new PrintWriter(echoSocket.getOutputStream(), 
						true);
			in = new BufferedReader(new InputStreamReader(
						echoSocket.getInputStream()));
		} catch (UnknownHostException e) {
			System.err.println("Don't know about host: orb.");
			System.exit(1);
		} catch (IOException e) {
			System.err.println("Couldn't get I/O for "
				+ "the connection to: orb.");
			System.exit(1);
		}

		//BufferedReader stdIn = new BufferedReader(
//					new InputStreamReader(System.in));

		//String userInput;
		System.out.println("server: " + in.readLine());

		out.close();
		in.close();
		//stdIn.close();
		echoSocket.close();
	}
}
