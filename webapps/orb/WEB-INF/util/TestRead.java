import com.orb.util.ReadObj;
import com.orb.sys.ServerList;
import com.orb.sys.Server;
import java.util.Hashtable;
import java.util.Enumeration;

public class TestRead {

	public static void main(String args[]) {
		ReadObj r = new ReadObj("file.obj");

//		ServerList sl = (ServerList) r.read();
//		Server s = sl.getServerBySid("orb");
//		System.out.println(s.getMachine());


		Server[] s = (Server []) r.read();

		for (int i=0;i<s.length;i++) {
			System.out.println(s[i].getMachine());
		}

	}



}