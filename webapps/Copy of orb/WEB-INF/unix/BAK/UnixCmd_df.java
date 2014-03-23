import java.util.*;

public class UnixCmd_df extends UnixCommand {
	private String CLASSNAME = this.getClass().getName();

	public UnixCmd_df (String host, String username, String password) {
		super(host, username, password);
	}

	public String getHtmlTable() {
		return this.getHtmlTable("df -k");
	}

	public String getHtmlTable(String command) {
		String METHODNAME = "getHtmlTable";

		String retStr = "";
		retStr = retStr + "<SCRIPT LANGUAGE=\"JScript\">\n"
//						+ "tblUpdate.outerHTML=\"<TABLE ID='tblUpdate' BORDER='1' STYLE='border-collapse:collapse'></TABLE>\";\n"
						+ "tblUpdate.outerHTML=\"<table id='tblUpdate' border='0' cellpadding='5' ellspacing='0'></TABLE>\";\n"
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
					String fileSystem = st1.nextToken();
					String kbytes = st1.nextToken();
					String used = st1.nextToken();
					String avial = st1.nextToken();
					String capacity = st1.nextToken();
					String mount = st1.nextToken();

					retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
									+ "		row.appendChild( cell );\n"
									+ "		cell.innerText = \"" + fileSystem + "\";\n";

					retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
									+ "		row.appendChild( cell );\n"
									+ "		cell.innerText = \"" + kbytes + "\";\n";

					retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
									+ "		row.appendChild( cell );\n"
									+ "		cell.innerText = \"" + used + "\";\n";

					retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
									+ "		row.appendChild( cell );\n"
									+ "		cell.innerText = \"" + avial + "\";\n";

					retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
									+ "		row.appendChild( cell );\n"
									+ "		cell.innerText = \"" + capacity + "\";\n";

					retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
									+ "		row.appendChild( cell );\n";

					String pctBar = " var img = document.createElement(\"img\");\n"
										//+ " img.src = \"http://www.taiwan.com/vote/images/color_g.gif\";\n"
										+ " img.src = \"/images/pctbar.gif\";\n"
										+ " img.width = \"" + capacity.substring(0, capacity.length()-1) + "\";\n"
										+ " img.height = 5;\n"
										+ " cell.appendChild(img);\n";

					retStr = retStr + pctBar;

					retStr = retStr + "		cell = document.createElement( \"TD\" );\n"
									+ "		row.appendChild( cell );\n"
									+ "		cell.innerText = \"" + mount + "\";\n";

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

		UnixCmd_df tt = new UnixCmd_df(s.getMachine(),
											s.getUsername(),
											s.getPassword());
		tt.connect();
//		tt.run("df -k");
//		if (tt.getStatus().equals("0"))
			System.out.println(tt.getHtmlTable("df -k"));

		tt.close();

	}
}