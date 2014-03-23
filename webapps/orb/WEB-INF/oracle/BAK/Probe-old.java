import java.io.*;
import java.net.*;

public final class Probe extends Thread {

 	private String machine;
	private int port;
	private String usrStr = 
			  "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "
                        + "0, 0, 0, 0, 0, 0, 0, 0, 0, 0";

	
	public Probe(String machine, int port) {
		this.machine = machine;
		this.port = port;
	}

        public void run() {
		this.probeServer();
	}

	public String getData() {
		return usrStr;
	}

	public void probeServer() {
	   try {

                Socket echoSocket = null;
                PrintWriter out = null;
                BufferedReader in = null;

                try {
                        echoSocket = new Socket(machine, port);
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

                BufferedReader stdIn = new BufferedReader(
                                        new InputStreamReader(System.in));

                String userInput;

		for (;;) {
                	userInput = "get";
                	out.println(userInput);
                	String retStr = in.readLine();

			String tmpStr = retStr.substring(
						retStr.indexOf("<usr>")
						+ "<usr>".length(),
						retStr.indexOf("</usr>"));	
		
			usrStr = usrStr.substring(
					usrStr.indexOf(",")+1)
				+ ", " 
				+ (int) (Float.parseFloat(tmpStr)*100); 

                        try {
                                sleep(5000);

                        } catch (java.lang.InterruptedException e) {
				e.printStackTrace();

                		out.close();
                		in.close();
                		stdIn.close();
                		echoSocket.close();
                        }

		}


	   } catch (IOException e) {
		e.printStackTrace();
	   }
        }
}

