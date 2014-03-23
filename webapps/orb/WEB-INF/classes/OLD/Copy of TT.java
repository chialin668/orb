import de.mud.telnet.TelnetWrapper;

public class TT {


	public static void main(String args[]) throws Exception {
		 byte[] buf = new byte[256];
		 int n = 0;

    TelnetWrapper telnet = new TelnetWrapper();
    try {
      telnet.connect("orb", 23);
      telnet.login("oracle", "oracle00");
//      telnet.setPrompt("user@host");
//      telnet.waitfor("Terminal type?");
//      telnet.send("dumb");
      System.out.println(telnet.send("ls -l"));
      System.out.println(telnet.send("echo status=$?"));

			while(n>=0) {
				n = telnet.read(buf);
				String outStr = new String(buf, 0, n);
				System.out.println(outStr);
			}


    } catch(java.io.IOException e) {
      e.printStackTrace();
    }


	}



}