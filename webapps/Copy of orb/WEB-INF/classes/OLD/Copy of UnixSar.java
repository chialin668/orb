import java.util.*;

public class UnixSar extends Thread{

	private UnixSharedData usd = new UnixSharedData();
	private Vector colVect = new Vector();
	private Hashtable dataTab = new Hashtable();
	private String host;
	private int port = 23;
	private String username;
	private String password;
	private String option;
	private String interval;
	private String count;

    private WebSharedData wsd;
    private String data;
    private String status;



    public UnixSar(String host, String username, String password,
    			String option, String interval, String count) {
        this.host = host;
        this.username = username;
        this.password = password;
        this.option = option;
        this.interval = interval;
        this.count = count;
    }

	public synchronized void put(String colName, String data) {
		String avgData = (String) dataTab.get(colName);

		// first time
		if (avgData.equals("")) {
			dataTab.put(colName, data);
			return;
		}

		// time stamp
		if (colName.equals("Time")) {
			dataTab.put(colName, data);
			return;
		}

		float avg = new Float(avgData).floatValue();
		float newData = new Float(data).floatValue();
		avg = (avg + newData) / 2;
		dataTab.put(colName, new Float(avg).toString());
		//System.out.println(colName + ":" + avg);

		//System.out.println((String) dataTab.get(colName));
	}

	public synchronized String get(String colName) {
		String retStr = (String) dataTab.get(colName);
		if (retStr != null && !retStr.equals(""))
			return retStr;
		else
			return"0";
	}


	public String getStatus() {
		return status;
	}


	public void run() {

		// ----------------- sar -----------------
		TelnetClient tc = new TelnetClient(System.in, usd);
		tc.connect(host, port);
		tc.login(username, password);
		tc.execute("sar -" + option
					+ " " + interval
					+ " " + count);
		tc.execute("echo status=$?");

		boolean loop = true;
		boolean start = false;
		while(loop) {
			String outStr = usd.get();
			byte[] b = {10};
			byte[] buff = {10, 13};
			String eof = new String(buff);
			StringTokenizer st = new StringTokenizer(outStr, eof);

			while (st.hasMoreTokens()) {

				String tmpStr = st.nextToken();

				// column names
				if (!start && (tmpStr.indexOf("bread/s") != -1)) {
					start = true;

					StringTokenizer st1 = new StringTokenizer(tmpStr);

					String timeStamp = st1.nextToken();
					colVect.add("Time");
					dataTab.put("Time", timeStamp);

					while (st1.hasMoreTokens()) {
						String colName = st1.nextToken();
						//System.out.println(colName);

						colVect.add(colName);		// we want the order
						dataTab.put(colName, "");  	// init the table
					}

					// we don't want this line to be added to the data hash table
					continue;
				}

				// We are done!!
				if (start && (tmpStr.indexOf("Average") != -1))
					start = false;

				// data
				if (start) {

					//System.out.println("|" + tmpStr+ "+");
					StringTokenizer st1 = new StringTokenizer(tmpStr);

					for (int i=0;i<colVect.size();i++) {
						String colName = (String) colVect.elementAt(i);
						String data = st1.nextToken();

						this.put(colName, data);
						//System.out.println(colName + " : " + data);
					}
				}

				if (tmpStr.length() > 7 && tmpStr.substring(0,7).equals("status=")) {
					status = tmpStr.substring(7);
					//System.out.println("*****status = " + status);
					tc.close();
					loop = false;
					break;
				}

			}
		}


	}


	public static void main(String args[]) {

		// first
		UnixSar us = new UnixSar("devdcx", "oracle", "oracle00", "b", "5", "50");
		us.start();

		for (int i=0;i<10;i++) {
			try { Thread.sleep(5000); } catch (java.lang.InterruptedException e) {}
			String retStr = us.get("lread/s");
			if (retStr != null)
				System.out.println("-->" + retStr + "|");
		}

		// second
		UnixSar us1 = new UnixSar("devdcx", "oracle", "oracle00", "b", "5", "50");
		//us1.start();

		for (int i=0;i<3000;i++) {
			try { Thread.sleep(5000); } catch (java.lang.InterruptedException e) {}
			String retStr = us1.get("lread/s");
			if (retStr != null)
				System.out.println("-->" + retStr);
		}



	}
}
