import java.io.*;
import java.net.*;

public final class Probe extends Thread {

 	String machine;
	int port;

	public Probe(String machine, int port) {
		this.machine = machine;
		this.port = port;
	}

        public void run() {
		this.probeServer();
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

		for (int i=0;i<1000000000;i++) {

                	userInput = "top";
                	byte b[] = userInput.getBytes();
                	for (int j=0;j<b.length;j++)
                		System.out.print(b[j] + " ");
                	out.println(userInput);

                	System.out.println("echo: " + in.readLine());
                	System.out.println("Done");

                        try {
                                sleep(3000);
                        } catch (java.lang.InterruptedException e) {
                        }

		}

                out.close();
                in.close();
                stdIn.close();
                echoSocket.close();
	   } catch (IOException e) {
		e.printStackTrace();
	   }
        }
}

