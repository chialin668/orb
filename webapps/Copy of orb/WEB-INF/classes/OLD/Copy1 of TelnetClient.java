/*
 *
 * Created       : 2000 Jan 30 (Sun) 20:35:41 by Harold Carr.
 * Last Modified : 2000 Jan 31 (Mon) 03:59:34 by Harold Carr.
 */

//package hc.net;

import java.io.*;
import java.util.*;

import de.mud.telnet.TelnetWrapper;


/**
*
*	producer
*
****************************/
class ReaderThread extends Thread {
	private String CLASSNAME = this.getClass().getName();

	TelnetWrapper telnetWrapper;
	UnixSharedData usd;
	String retStr;
	private boolean running = true;

	ReaderThread (TelnetWrapper telnetWrapper, UnixSharedData usd) {
		super("TelnetReaderThread");
		this.telnetWrapper = telnetWrapper;
		this.usd = usd;
	}

	public void run() {
		String METHODNAME = "run";

		byte[] buf = new byte[2048];
		int n = 0;
		while ((n >= 0) && running) {

			try {
				n = telnetWrapper.read(buf);
				if (n > 0) {
					String retStr = new String(buf, 0, n);
					usd.put(retStr);
				}
			} catch (IOException e) {
				String message = "Got exception in read/write loop";
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
							SysLog.ML_SEVERE,
							e,
							message);
	            return;
			}
		}

		return;
	}

	public void endThread() {
		running = false;
	}

	public String getRetStr() {
		return retStr;
	}
}

////////////////////////////////////////////////////////////////////////////////

class UnixSharedData {
	private String CLASSNAME = this.getClass().getName();

	private String contents;
    private boolean available = false;

	public void print(String contents) {
		System.out.println(contents);
	}

    public synchronized String get() {
        while (available == false) {
            try {
                wait();
            } catch (InterruptedException e) { }
        }
        available = false;
        notifyAll();
        return contents;
    }

    public synchronized void put(String value) {
        while (available == true) {
            try {
                wait();
            } catch (InterruptedException e) { }
        }
        contents = value;
        available = true;
        notifyAll();
    }

}


////////////////////////////////////////////////////////////////////////////////

public class TelnetClient {
	private String CLASSNAME = this.getClass().getName();

	private TelnetWrapper telnetWrapper;
	private ReaderThread readerThread;
	private InputStream in;
	private UnixSharedData usd;
	private String host;

    public TelnetClient (InputStream in, UnixSharedData usd) {
		this.in = in;
		this.usd = usd;
	}

    public Thread createAndStartReader (TelnetWrapper telnetWrapper,
											UnixSharedData usd)
    {
		readerThread = new ReaderThread(telnetWrapper, usd);
		readerThread.start();
		return readerThread;
    }

	public boolean connect(String host, int port) {
		String METHODNAME = "connect";

		this.host = host;

		telnetWrapper = new TelnetWrapper();

		try {
			telnetWrapper.connect(host, port);

		} catch (IOException e) {
			String message = "Error connecting to server: " + host;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						e,
						message);
			return false;
		}

		return true;
	}

	public boolean run(String command) {
		String METHODNAME = "run";

		byte[] buf = new byte[256];

		int n = 0;

		try {
			while (n >= 0) {
				n = in.read(buf);

				if (n > 0) {
					byte[] sendBuf = new byte[n];
					System.arraycopy(buf, 0, sendBuf, 0, n);

					// Must be transpose (not send) or connect is closed.
					telnetWrapper.transpose(sendBuf);
				}
			}

		} catch (IOException e) {
			String message = "Error sending unix command: " + command + " to host: " + host;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						e,
						message);
			return false;

		} finally {

			try {
				try {Thread.sleep(1000);} catch (java.lang.InterruptedException e) {}
				readerThread.endThread();

				try {Thread.sleep(1000);} catch (java.lang.InterruptedException e) {}
				telnetWrapper.disconnect();

			} catch (IOException e) {
				String message = "Error disconnecting from: " + host;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
							SysLog.ML_SEVERE,
							e,
							message);
				return false;
			}
		}

		return true;
	}


	public boolean login(String username, String password) {
		String METHODNAME = "login";

		username = username + "\n";
		password = password + "\n";

		createAndStartReader(telnetWrapper, usd);

		byte[] buf = new byte[256];

		int n = 0;

		try {
			for (int i=0;i<2;i++) {

				if (i == 0) {
					buf = username.getBytes();
					n = username.length();

				} else if (i == 1) {
					buf = password.getBytes();
					n = password.length();
				}
//				try {
//					Thread.sleep(500);
//				} catch (java.lang.InterruptedException e) {}

System.out.println(username);
System.out.println(password);
System.out.println("--------------> " + usd.get());

				byte[] sendBuf = new byte[n];
				System.arraycopy(buf, 0, sendBuf, 0, n);

				// Must be transpose (not send) or connect is closed.
				telnetWrapper.transpose(sendBuf);
			}

		} catch (IOException e) {
			String message = "Can't login to host: " + host + " by login: " + username;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						e,
						message);
			return false;
		}

		return true;
	}


	public boolean execute(String command) {
		String METHODNAME = "execute";

		command = command + "\n";

		byte[] buf = new byte[256];

		int n = 0;

		try {
			buf = command.getBytes();
			n = command.length();

			byte[] sendBuf = new byte[n];
			System.arraycopy(buf, 0, sendBuf, 0, n);
			// Must be transpose (not send) or connect is closed.
			telnetWrapper.transpose(sendBuf);

		} catch (IOException e) {
			String message = "Error executing unix command: " + command;
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
			try { Thread.sleep(300); } catch (java.lang.InterruptedException e) {}

			readerThread.endThread();
			this.execute("");

			telnetWrapper.disconnect();

		} catch (IOException e) {
			String message = "Error closing unix connection from: " + host;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						e,
						message);
			return false;
		}
		return true;
	}




   /**
	*
	*
	*
	*********************************************/
	public static void main (String[] av) {
		String host = "devdcx";
		int    port = 23;

		UnixSharedData usd = new UnixSharedData();
		String username = "oracle";
		String password = "oracle00";

		// ----------------- sar -----------------
		TelnetClient tc = new TelnetClient(System.in, usd);
		tc.connect(host, port);
		tc.login(username, password);
		tc.execute("sar -b 2 3");
		tc.execute("echo status=$?");

		boolean loop = true;
		while(loop) {
			String outStr = usd.get();
			byte[] b = {10};
			byte[] buff = {10, 13};
			String eof = new String(buff);
			StringTokenizer st = new StringTokenizer(outStr, eof);


			while (st.hasMoreTokens()) {

				String tmpStr = st.nextToken();
				System.out.println("|" + tmpStr+ "+");

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					String status = tmpStr.substring(7);
					System.out.println("*****status = " + status);
					tc.close();
					loop = false;
					break;
				}

			}
		}


		// ----------- df -k -----------------
		usd = new UnixSharedData();
		TelnetClient tc1 = new TelnetClient(System.in, usd);
		tc1.connect(host, port);
		tc1.login(username, password);
		tc1.execute("df -k");
		tc1.execute("echo status=$?");

		loop = true;
		while(loop) {
			String outStr = usd.get();
			byte[] buff = {10, 13};
			String eof = new String(buff);

			StringTokenizer st = new StringTokenizer(outStr, eof);
			while (st.hasMoreTokens()) {
				String tmpStr = st.nextToken();
				System.out.println(tmpStr);

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					String status = tmpStr.substring(7);
					System.out.println("*****status = " + status);
					tc1.close();
					loop = false;
					break;
				}
			}
		}

	}


}
/////////////////////////////////////////////////////////////////////////////////////////////


// End of file.
