import java.util.StringTokenizer;

public class UnixCommand {

	private UnixSharedData usd;
	private String resultStr = "";
	private String host;
	private int port;
	private String username;
	private String password;
	private String crString = "\n";

	public UnixCommand(String host, int port, String username, String password) {
		this.host = host;
		this.port = port;
		this.username = username;
		this.password = password;
	}

	public void setCRString(String crString) {
		this.crString = crString;
	}


	public boolean run(String command) {
		usd = new UnixSharedData();
		TelnetClient tc1 = new TelnetClient(System.in, usd);
		tc1.connect(host, port);
		tc1.login(username, password);
		tc1.execute(command);
		tc1.execute("echo status=$?");

		boolean loop = true;
		boolean start = false;
		while(loop) {
			String outStr = usd.get();
			byte[] buff = {10, 13};
			String eof = new String(buff);

			StringTokenizer st = new StringTokenizer(outStr, eof);
			while (st.hasMoreTokens()) {
				String tmpStr = st.nextToken();
//				System.out.println(tmpStr);

				resultStr = resultStr + tmpStr + crString;

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					String status = tmpStr.substring(7);
					//System.out.println("*****status = " + status);
					if (!status.equals("0")) {
						tc1.close();
						return false;
					}

					tc1.close();
					loop = false;
					break;
				}
			}
		}
		return true;
	}

	public String getResult() {
		return resultStr;
	}


	public static void main(String args[]) {
		UnixCommand uc = new UnixCommand("devdcx", 23, "oracle", "oracle00");
		uc.setCRString("<br>\n");
//		if (!uc.run("df -k"))
		if (!uc.run("more /tmp/export.log"))
			System.out.println("Error executing the command");
		else
			System.out.println(uc.getResult());


	}

}