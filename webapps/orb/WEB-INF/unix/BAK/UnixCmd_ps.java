import java.util.*;

public class UnixCmd_ps extends UnixCommand {
	private String CLASSNAME = this.getClass().getName();

	public UnixCmd_ps (String host, String username, String password) {
		super(host, username, password);
	}

	public String getHtmlTable() {
		return this.getHtmlTable("ps -ef");
	}

	public String getHtmlTable(String command) {
		String METHODNAME = "getHtmlTable";

		String retStr = "";
		retStr = retStr + "<SCRIPT LANGUAGE=\"JScript\">\n"
//						+ "tblUpdate.outerHTML=\"<TABLE ID='tblUpdate' BORDER='1' STYLE='border-collapse:collapse'></TABLE>\";\n"
						+ "tblUpdate.outerHTML=\"<table id='tblUpdate' border='1' cellpadding='5' ellspacing='0'></TABLE>\";\n"
						+ " var row;\n"
						+ " var cell;\n"
						+ " var tbody = tblUpdate.childNodes[0];\n"
						+ " tblUpdate.appendChild( tbody );\n";

		if (!telClient.execute(command)) {
			String message = "Error executing command: " + command
							+ " on server: " + host
							+ " login: " + username
							+ " password: " + password;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return null;
		}

		if (!telClient.execute("echo status=$?")) {
			String message = "Error retrieve status for: " + command
							+ " on server: " + host
							+ " login: " + username
							+ " password: " + password;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						null,
						message);
			return null;
		}

		boolean loop = true;
		while(loop) {
			String outStr = usd.get();
			byte[] buff = {10, 13};
			String eof = new String(buff);

			retStr = retStr + "  row = document.createElement( \"TR\" );\n"
							+ "  tbody.appendChild( row );\n";

			StringTokenizer st = new StringTokenizer(outStr, eof);
			while (st.hasMoreTokens()) {
				String tmpStr = st.nextToken();

				if ((tmpStr.indexOf(command) != -1)
							|| (tmpStr.indexOf("echo status=$?") != -1))
					continue;

				retStr = retStr + "  row = document.createElement( \"TR\" );\n"
								+ "  tbody.appendChild( row );\n";

				StringTokenizer st1 = new StringTokenizer(tmpStr);
//				while (st1.hasMoreTokens()) {
					// fileSystem
				try {
					Vector resultVect = new Vector();
					for (int i=0;i<8;i++)
						resultVect.add(st1.nextToken());


					for (int i=0;i<8;i++)
						retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
										+ "		row.appendChild( cell );\n"
										+ "		cell.innerText = \""
										+ (String) resultVect.elementAt(i)
										+ "\";\n";


				} catch (java.util.NoSuchElementException e) {
					//System.out.println("===========> " + tmpStr);
					// login, prompt, & status
				}
//				}

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					status = tmpStr.substring(7);
					//System.out.println("*****status = " + status);
					//telClient.close();
					loop = false;
					break;
				}
			}
		}

		retStr = retStr + "</SCRIPT>\n";

		return retStr;

	}


	public static void main(String args[]) {
		ServerInfo si = new ServerInfo();
		si.init();
		Server s = si.getServerBySid("devdcx");

		UnixCmd_ps tt = new UnixCmd_ps(s.getMachine(),
											s.getUsername(),
											s.getPassword());
		tt.connect();
//		tt.run("ps -ef");
//		if (tt.getStatus().equals("0"))
			System.out.println(tt.getHtmlTable("ps -ef"));

		tt.close();

	}
}