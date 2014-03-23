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


/**
*
*	producer
*
****************************/
class ReaderThread extends Thread {
	TelnetWrapper telnetWrapper;
	SharedData out;
	String retStr;
	private boolean running = true;

	ReaderThread (TelnetWrapper telnetWrapper, SharedData out) {
		super("TelnetReaderThread");
		this.telnetWrapper = telnetWrapper;
		this.out = out;
	}

	public void run () {

		byte[] buf = new byte[2048];
		int n = 0;
		while ((n >= 0) && running) {

			try {
				n = telnetWrapper.read(buf);
				if (n > 0) {
					String retStr = new String(buf, 0, n);
					out.put(retStr);
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

class SharedData {

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

	private TelnetWrapper telnetWrapper;
	private ReaderThread readerThread;
	private InputStream in;
	private SharedData out;

    public TelnetClient (InputStream in, SharedData out) {
		this.in = in;
		this.out = out;
	}

    public Thread createAndStartReader (TelnetWrapper telnetWrapper,
											SharedData out)
    {
		readerThread = new ReaderThread(telnetWrapper, out);
		readerThread.start();
		return readerThread;
    }

	public boolean connect(String host, int port) {
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
					Thread.sleep(500);
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
			buf = command.getBytes();
			n = command.length();

			byte[] sendBuf = new byte[n];
			System.arraycopy(buf, 0, sendBuf, 0, n);
			// Must be transpose (not send) or connect is closed.
			telnetWrapper.transpose(sendBuf);

		} catch (IOException e) {
			System.out.println("TelnetClient: Got exception in read/write loop: " + e);
			e.printStackTrace();
			return false;

		}

		return true;
	}


	public boolean close() {
		try {
			try { Thread.sleep(500); } catch (java.lang.InterruptedException e) {}

			readerThread.endThread();
			this.execute("");

			telnetWrapper.disconnect();

		} catch (IOException e) {
			System.out.println("TelnetClient: got exception in disconnect: " + e);
			e.printStackTrace();
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

		SharedData out = new SharedData();
		String username = "oracle";
		String password = "oracle00";
/*
		// sar
		TelnetClient tc = new TelnetClient(System.in, out);
		tc.connect(host, port);
		tc.login(username, password);
		tc.execute("sar -b 5 3");

		while(true) {
			String outStr = out.get();
			System.out.print(outStr);

			if (outStr.indexOf("Average") != -1) {
				System.out.println("---------->last line");
				tc.close();
				break;
			}
		}
*/

		// df -k
		TelnetClient tc1 = new TelnetClient(System.in, out);
		tc1.connect(host, port);
		tc1.login(username, password);
		tc1.execute("df -k");


		while(true) {
			String outStr = out.get();
			System.out.print(outStr);

			if (outStr.indexOf("data6") != -1) {
				System.out.println("---------->last line");
				tc1.close();
				break;
			}
		}

	}


}
/////////////////////////////////////////////////////////////////////////////////////////////


// End of file.
