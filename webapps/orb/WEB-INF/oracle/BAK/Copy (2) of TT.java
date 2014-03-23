import java.util.*;
import de.mud.telnet.TelnetWrapper;


public class TT {
	private TelnetWrapper telnet;
	private String retStr;
	private String status;

	public boolean connect(String host, String username, String password) {

		try {
			telnet = new TelnetWrapper();

			telnet.connect(host, 23);
			telnet.login(username, password);
			try { Thread.sleep(500); } catch (java.lang.InterruptedException e) {}
			telnet.send("\n");
			/*
			byte[] buf = new byte[8192];
			int n = telnet.read(buf);
			String outStr = new String(buf, 0, n);
			System.out.println("--> "  + outStr);
			System.out.println("---------------------");
			*/

		} catch(java.io.IOException e) {
			e.printStackTrace();
			return false;
		}

		return true;

	}


	public boolean run(String command) {
		byte[] buf = new byte[8192];
		int n = 0;
		String statusCmd = "echo status=$?";

		try {
			telnet.send(command);
			telnet.send(statusCmd);

			boolean done = false;
			int cmdCount = 0;
			retStr = "";
			while(n>=0) {
				n = telnet.read(buf);
				String outStr = new String(buf, 0, n);
				retStr = retStr + outStr;

				if (done && outStr.indexOf("status=") != -1)
					break;

				if (outStr.indexOf("status=") != -1)
					done = true;

			}


		} catch(java.io.IOException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	public String getResult() {
		return retStr;
	}

	public String process() {

		String after = "";
		boolean start = false;
		int count = 0;
		StringTokenizer st = new StringTokenizer(retStr, "\n");

		while (st.hasMoreTokens()) {
			String token = st.nextToken();
			//System.out.println(token);

			after = after + token + "\n";
		}

		//System.out.println(after);
		//System.out.println(status);
		return null;
	}

	public static void main(String args[]) throws Exception {
		TT t = new TT();
		t.connect("orb", "oracle", "oracle00");

		t.run("ls -al");
		System.out.println(t.getResult());

		t.run("df -k");
		System.out.println(t.getResult());

		//try { Thread.sleep(1000); } catch (java.lang.InterruptedException e) {}

	}



}