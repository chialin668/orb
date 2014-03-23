import java.util.*;
import de.mud.telnet.TelnetWrapper;

//
// Telnet Test
// Can be used only for 'df -k', 'ls -l', etc.
// Can't be used for command like 'iostat 5'
//
public class TT {

	private final String statusCmd = "echo status=$?";
	private final String statusStr = "status=";
	private final int statusStrLen = statusStr.length();
	private final String prompt = "$ ";

	private static Hashtable telnetTab = new Hashtable();

	private TelnetWrapper telnet;
	private String host;
	private String loginMsg;
	private String htmlTabStr;
	private String retStr;
	private String status;



	public boolean connect(String host, String username, String password) {

		this.host = host;
		try {

			telnet = (TelnetWrapper) telnetTab.get(host);
			if (telnet == null) {
				telnet = new TelnetWrapper();
				telnet.connect(host, 23);
				telnet.login(username, password);
				telnetTab.put(host, telnet);
			} else
				return true;

			// make sure we'll get the server information message
			//
			// eg. on Sun:
			//
			// Last login: Wed Jun 13 04:47:31 from 192.168.4.26
			//Sun Microsystems Inc.   SunOS 5.7       Generic October 1998
			//You have new mail.
			//$ $
			//
			try { Thread.sleep(500); } catch (java.lang.InterruptedException e) {}
			telnet.send("\n");

			byte[] buf = new byte[8192];
			int n = telnet.read(buf);
			String outStr = new String(buf, 0, n);
			loginMsg = outStr;
			//System.out.println("--> "  + outStr);
			//System.out.println("---------------------");


		} catch(java.io.IOException e) {
			e.printStackTrace();
			return false;
		}

		return true;

	}


	public boolean run(String command){
		return this.run(command, false);
	}

	public boolean run(String command, boolean wantHtml) {
		byte[] buf = new byte[8192];

		byte[] EOLByteArray = {10, 13};
		String eol = new String(EOLByteArray);

		try {
			telnet.send(command);
			telnet.send(statusCmd);

			int n = 0;
			boolean done = false;
			int cmdCount = 0;
			retStr = "";
			if (wantHtml)
				htmlTabStr = "<table "
							+ "id=\"" + host + "\" "
							+ "border=\"1\" cellpadding=\"5\" cellspacing=\"0\">\n";

			while(n >= 0) {
				n = telnet.read(buf);
				String outStr = new String(buf, 0, n);

				StringTokenizer st = new StringTokenizer(outStr, eol);

				while (st.hasMoreTokens()) {
					String token = st.nextToken();
					//System.out.println("--> " + token);

					if (token.indexOf(command) == -1
							&& token.indexOf(statusCmd) == -1
							&& token.indexOf(statusStr) == -1
							&& !token.equals(prompt)) {
						//retStr = retStr + "|" + token + "|" + "\n";
						retStr = retStr + token + "\n";

						if (wantHtml) {
							htmlTabStr = htmlTabStr + "<tr>\n";
							StringTokenizer st1 = new StringTokenizer(token);
							while (st1.hasMoreTokens()) {
								String tdStr = st1.nextToken();
								htmlTabStr = htmlTabStr + "\t<td>" + tdStr + "</td>\n";
							}
							htmlTabStr = htmlTabStr + "</tr>\n";
						}
					}

					// second one
					if (done && token.indexOf(statusStr) != -1) {

						// get the status
						token = st.nextToken();
						status = token.substring(statusStrLen);

						if (wantHtml)
							htmlTabStr = htmlTabStr + "</table>";

						return true;
					}

					// fisrt one
					if (token.indexOf(statusStr) != -1)
						done = true;
				}
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

	public String getHtmlTable() {
		return htmlTabStr;
	}

	public String getStatus() {
		return status;
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

		t.run("df -k");
		System.out.println(t.getResult());
		System.out.println(t.getHtmlTable());
		System.out.println(t.getStatus());

		t.run("ls -al", true);
		System.out.println(t.getResult());
		System.out.println(t.getHtmlTable());
		System.out.println(t.getStatus());

	/////////////////////////////////////////////
/*
		TT t1 = new TT();
		t1.connect("orb", "oracle", "oracle00");

		t1.run("df -k");
		System.out.println(t1.getResult());
		System.out.println(t1.getStatus());

		t1.run("ls -al");
		System.out.println(t1.getResult());
		System.out.println(t1.getStatus());
*/


	}



}