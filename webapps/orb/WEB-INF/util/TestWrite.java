import com.orb.util.WriteObj;
import com.orb.sys.ServerList;
import com.orb.sys.Server;

public class TestWrite {

	public static void main(String args[]) {
		WriteObj w = new WriteObj("file.obj");

		Server orb = new Server(Server.SOLARIS, "2.7.x", "orb", "23", "oracle", "oracle00", "orb");
		Server devdcx = new Server(Server.SOLARIS, "2.7.x", "devdcx", "23", "oracle", "oracle00", "devdcx");
		Server nt = new Server(Server.SOLARIS, "2.7.x", "nt", "23", "oracle", "oracle00", "nt");

		Server[] s = new Server[3];
		s[0] = orb;
		s[1] = devdcx;
		s[2] = nt;

		w.write(s);

	}



}