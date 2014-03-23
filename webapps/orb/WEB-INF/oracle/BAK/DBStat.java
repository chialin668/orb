import java.util.*;


/**
*

create table dbstat (sid char(32),
						timestamp date,
						name varchar2(64),
						value number);

create index dbstat_sid on dbstat(sid);
create index dbstat_ts on dbstat(timestamp);
create index dbstat_name on dbstat(name);


insert into dbstat values('Test', sysdate, 'aname', 123);

*
**/
public class DBStat extends Thread {
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

					System.out.println(name + " : " + value);
				}
			}

			try { Thread.sleep(interval); } catch (java.lang.InterruptedException e) {}

		}

		return true;
	}

	public synchronized String getDataStr(String sid, String cmdTag, String statName) {
		String METHODNAME = "getDataStr";
		String retStr = "";

		return retStr;
	}


	public static void main(String args[]) {
		int interval = 5;

		DBStat s = new DBStat();
//		s.init("orb", "1521", "system", "oracle00", "REPOS", "STAT_STAT", interval);
		s.init("Chialin", "1521", "system", "oracle00", "CHIALIN", "STAT_STAT", interval);

		s.start();

		try { Thread.sleep(interval*1000); } catch (java.lang.InterruptedException e) {}
		for (int i=0;i<100;i++) {
			System.out.println(s.getDataStr("CHIALIN",
													"STAT_STAT",
													"bytes received via SQL*Net from client"));
			try { Thread.sleep(interval*1000); } catch (java.lang.InterruptedException e) {}
		}

	}

}
