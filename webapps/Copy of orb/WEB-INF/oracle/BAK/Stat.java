import java.util.*;


class TimeValue {
	public Date time;
	public String value;

	public TimeValue(Date time, String value) {
		this.time = time;
		this.value = value;
	}
}


//////////////////////////////////////////////////////////////////////////////////////////////

public class Stat extends Thread {
	private String CLASSNAME = this.getClass().getName();
	private String DELIMITER = Environment.COL_DELIMITER;

	private String machine;
	private String port;
	private String username;
	private String password;
	private String sid;
	private String cmdTag;
	private int interval;
	private boolean run = true;

	private static Hashtable sidTab = new Hashtable();

	public void init(String machine, String port,
					String username, String password,
					String sid, String cmdTag, int interval) {
		this.machine = machine;
		this.port = port;
		this.username = username;
		this.password = password;
		this.sid = sid;
		this.cmdTag = cmdTag;
		this.interval = interval*1000;
	}

	public void run() {
		String METHODNAME = "run";
		this.getData();
	}

	public void stopIt() {
		run = false;
	}

	public boolean getData() {
		String METHOD = "getData";

		while (run) {

			Date currentTime = new Date();

			Database db = new Database(machine, port, username, password, sid);
			db.executeSQL(cmdTag);
			Vector resultVect = db.getResultVect();

			for (int j=0;j<resultVect.size();j++) {
				String nextRecord = (String) resultVect.elementAt(j);
				StringTokenizer st = new StringTokenizer(nextRecord, DELIMITER);
				while (st.hasMoreTokens()) {
					String name = st.nextToken();
					String value = st.nextToken();

					// sidTab -> tagTab -> statTab -> tvVect
					Hashtable tagTab = (Hashtable) sidTab.get(sid);
					if (tagTab == null) tagTab = new Hashtable();

					Hashtable statTab = (Hashtable) tagTab.get(cmdTag);
					if (statTab == null) statTab = new Hashtable();

					Vector tvVect = (Vector) statTab.get(name);
					if (tvVect == null) tvVect = new Vector();

					TimeValue tv = new TimeValue(currentTime, value);

					tvVect.add(tv);
					statTab.put(name, tvVect);
					tagTab.put(cmdTag, statTab);
					sidTab.put(sid, tagTab);

				}
			}

			try { Thread.sleep(interval); } catch (java.lang.InterruptedException e) {}

		}

		return true;
	}

	public synchronized String getDataStr(String sid, String cmdTag, String statName) {
		String METHODNAME = "getDataStr";
		String retStr = "";

		Hashtable tagTab = (Hashtable) sidTab.get(sid);
		if (tagTab == null) {
			String message = "tagTab (Hashtable) should not be null but it is! "
							+ "sid: " + sid;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return null;
		}

		Hashtable statTab = (Hashtable) tagTab.get(cmdTag);
		if (statTab == null) {
			String message = "statTab (Hashtable) should not be null but it is! "
							+ "tag: " + cmdTag;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return null;
		}

		Vector tvVect = (Vector) statTab.get(statName);
		if (tvVect == null) {
			String message = "tvVect (time value Vector) should not be null but it is! "
							+ "stat name: " + statName;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
                				SysLog.ML_SEVERE,
                				null,
                                message);
			return null;
		}

		// find the first one
		TimeValue tv = (TimeValue) tvVect.elementAt(0);
		int lastRec =  Integer.parseInt(tv.value);

		for (int k=0;k<tvVect.size();k++) {
			tv = (TimeValue) tvVect.elementAt(k);
			int currentRec = Integer.parseInt(tv.value);
			int diff = currentRec - lastRec;
			lastRec = currentRec;
			retStr = retStr + new Integer(diff).toString() + ",";
		}
		retStr = retStr.substring(0, retStr.length()-1);

		return retStr;
	}


	public static void main(String args[]) {
		int interval = 5;

		Stat s = new Stat();
		s.init("orb", "1521", "system", "oracle00", "REPOS", "STAT_STAT", interval);

		s.start();

		try { Thread.sleep(interval*1000); } catch (java.lang.InterruptedException e) {}
		for (int i=0;i<100;i++) {
			System.out.println(s.getDataStr("REPOS",
													"STAT_STAT",
													"bytes received via SQL*Net from client"));
			try { Thread.sleep(interval*1000); } catch (java.lang.InterruptedException e) {}
		}

	}

}
