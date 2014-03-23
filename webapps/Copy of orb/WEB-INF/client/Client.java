import java.io.*;
import java.net.*;

public class Client {
	private String CLASSNAME = this.getClass().getName();

	private String machine;
	private int port;
	private Socket socket;
	private PrintWriter out;
	private BufferedReader in;

	public Client(String machine, int port) {
		this.machine = machine;
		this.port = port;
	}


	public boolean connect() {
		String METHODNAME = "connect";

		try {

			socket = new Socket(machine, port);
			out = new PrintWriter(socket.getOutputStream(), true);
			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));

		} catch (UnknownHostException e) {
			String message = "Host unknown: " + machine;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			return false;

		} catch (IOException e) {
			String message = "Error opening the socket connection!! "
								+ "\nmachine: " + machine
								+ "\nport: " + port;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			return false;
		}

		return true;
	}


	public boolean close() {
		String METHODNAME = "close";

		try {
			out.close();
			in.close();
			socket.close();

		} catch (IOException e) {
			String message = "Error closing the socket connection!! "
								+ "\nmachine: " + machine
								+ "\nport: " + port;

			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				e,
                                message);
			return false;
		}
		return true;
	}


	public boolean sendCmd() {

		try {
			String userInput = "top";
			byte b[] = userInput.getBytes();
			for (int j=0;j<b.length;j++)
				System.out.print(b[j] + " ");
			out.println(userInput);

			//System.out.println("echo: " + in.readLine());
			//System.out.println("Done");

			Parser parser = new Parser();
			parser.process(in.readLine());

		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}



	public static void main(String[] args) {

		Client c = new Client("orb", 3341);
		c.connect();
		c.sendCmd();
		c.close();
	}


}

