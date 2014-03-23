/*
 *
 * Created       : 2000 Jan 30 (Sun) 20:35:41 by Harold Carr.
 * Last Modified : 2000 Jan 31 (Mon) 03:59:34 by Harold Carr.
 */

//package hc.net;

import java.io.InputStream;
import java.io.IOException;
import java.io.PrintStream;

import de.mud.telnet.TelnetWrapper;


class ReaderThread extends Thread {
	TelnetWrapper telnetWrapper;
	ABC out;
	String retStr;
	private boolean running = true;

	ReaderThread (TelnetWrapper telnetWrapper, ABC out) {
		super("TelnetReaderThread");
		this.telnetWrapper = telnetWrapper;
		this.out = out;
	}

	public void run () {
		// System.out.println("thread-starting");

		byte[] buf = new byte[2048];
		int n = 0;
		while ((n >= 0) && running) {

			try {
				n = telnetWrapper.read(buf);
				if (n > 0) {
					String retStr = new String(buf, 0, n);
					out.print(retStr);
				}
			} catch (IOException e) {
				System.out.println("ReaderThread.run: got exception in read/write loop: " + e);
				e.printStackTrace();
				return;
			}
		}
	}

	public void endThread() {
		running = false;
	}

	public String getRetStr() {
		return retStr;
	}
}

////////////////////////////////////////////////////////////////////////////////

class ABC {

	private static long lastTime = 0;
	private static String outStr = "";

	public void print(String inStr) {
		long thisTime = System.currentTimeMillis();

		if ((thisTime-lastTime) > 3000) {
//			System.out.println("===> " + (lastTime/1000) + ", " + (thisTime/1000));
			lastTime = thisTime;

		}

		System.out.println(inStr);
//		System.out.println((lastTime/1000) + ", " + (thisTime/1000));

	}
}


////////////////////////////////////////////////////////////////////////////////

public class TelnetClient {

	private TelnetWrapper telnetWrapper;
	private ReaderThread readerThread;
	private InputStream in;
	private ABC out;
	private String host;
	private int port;

    public TelnetClient (InputStream in, ABC out,
								 String host, int port) {
		this.in = in;
		this.out = out;
		this.host = host;
		this.port = port;
	}

    public Thread createAndStartReader (TelnetWrapper telnetWrapper,
											ABC out)
    {
		readerThread = new ReaderThread(telnetWrapper, out);
		readerThread.start();
		return readerThread;
    }

	public boolean connect() {
		telnetWrapper = new TelnetWrapper();

		try {
			telnetWrapper.connect(host, port);

		} catch (IOException e) {
			System.out.println("TelnetClient: Got exception during connect: " + e);
			e.printStackTrace();
			return false;
		}

		return true;
	}

	public boolean run(String command) {

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
			System.out.println("TelnetClient: Got exception in read/write loop: " + e);
			e.printStackTrace();
			return false;

		} finally {
			try {

				try {Thread.sleep(1000);} catch (java.lang.InterruptedException e) {}
				readerThread.endThread();
				try {Thread.sleep(1000);} catch (java.lang.InterruptedException e) {}
				telnetWrapper.disconnect();

			} catch (IOException e) {
				System.out.println("TelnetClient: got exception in disconnect: " + e);
				e.printStackTrace();
				return false;
			}
		}

		return true;
	}


	public boolean login(String username, String password) {
		username = username + "\n";
		password = password + "\n";

		createAndStartReader(telnetWrapper, out);

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

				try {
					Thread.sleep(100);
				} catch (java.lang.InterruptedException e) {}

				byte[] sendBuf = new byte[n];
				System.arraycopy(buf, 0, sendBuf, 0, n);
				// Must be transpose (not send) or connect is closed.
				telnetWrapper.transpose(sendBuf);
			}

		} catch (IOException e) {
			System.out.println("TelnetClient: Got exception in read/write loop: " + e);
			e.printStackTrace();
			return false;

		}

		return true;
	}


	public boolean execute(String command) {
		command = command + "\n";

		byte[] buf = new byte[256];

		int n = 0;

		try {
			for (int i=0;i<1;i++) {

				if (i == 0) {
					buf = command.getBytes();
					n = command.length();

				} else if (i == 1) {
					buf = command.getBytes();
					n = command.length();
				}

				try {
					Thread.sleep(100);
				} catch (java.lang.InterruptedException e) {}

				byte[] sendBuf = new byte[n];
				System.arraycopy(buf, 0, sendBuf, 0, n);
				// Must be transpose (not send) or connect is closed.
				telnetWrapper.transpose(sendBuf);
			}

		} catch (IOException e) {
			System.out.println("TelnetClient: Got exception in read/write loop: " + e);
			e.printStackTrace();
			return false;

		}

		return true;
	}


	public boolean close() {
		try {
			telnetWrapper.disconnect();

		} catch (IOException e) {
			System.out.println("TelnetClient: got exception in disconnect: " + e);
			e.printStackTrace();
			return false;
		}
		return true;
	}


		public static void main (String[] av) {
			String host = "devdcx";
			int    port = 23;

			ABC out = new ABC();
			String username = "oracle";
			String password = "oracle00";

			TelnetClient tc = new TelnetClient(System.in, out, host, port);
			tc.connect();
			try { Thread.sleep(300); } catch (java.lang.InterruptedException e) {}
			tc.login(username, password);

			try { Thread.sleep(300); } catch (java.lang.InterruptedException e) {}
			tc.execute("df -k");

			tc.run("df -k");
			tc.close();

		}



    }
/////////////////////////////////////////////////////////////////////////////////////////////


// End of file.
