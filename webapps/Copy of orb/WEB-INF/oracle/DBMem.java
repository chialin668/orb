package com.orb.oracle;

//import java.io.Serializable;
import java.util.Hashtable;
import java.util.Vector;
import com.orb.sys.*;


/**
*
* save the static data in the memory
*
*
*  table	table		 vector
*  sid --> stat name --> value
*
*
*  sid --> sql tag --> stat name (first column) --> column name --> value
*
**/
public class DBMem {
	private String CLASSNAME = this.getClass().getName();
	private String COL_DELIMITER = Environment.COL_DELIMITER;
	//private int MAXLEN = 96;			// @@@ 5 min interval for 8 hr (12*8)
	private int MAXLEN = 600;			// @@@ Every minute for 10 hr (60*10)
	private static Hashtable sidTab = new Hashtable();

	public DBMem(){}
	public DBMem(int maxLen) {this.MAXLEN=maxLen;}

///////////////////////////////////////////////////////////////////////////////////////////////////////
   /**
	*
	* save the data to memory
	*
	**/
	public void put(String sid, String tag, String stat, String col, String value) {
		Hashtable tagTab = (Hashtable) sidTab.get(sid);
		if (tagTab == null)
			tagTab = new Hashtable();
		sidTab.put(sid, tagTab);

		Hashtable statTab = (Hashtable) tagTab.get(tag);
		if (statTab == null)
			statTab = new Hashtable();
		tagTab.put(tag, statTab);

		Hashtable colTab = (Hashtable) statTab.get(stat);
		if (colTab == null)
			colTab = new Hashtable();
		statTab.put(stat, colTab);

		Vector valueVect = (Vector) colTab.get(col);
		if (valueVect == null)
			valueVect = new Vector();

		if (valueVect.size() >= MAXLEN)
			valueVect.removeElementAt(0);

		valueVect.add(value);
		colTab.put(col, valueVect);
	}


   /**
	*
	* get the data in (delimited) string format
	*
	**/
	public String get(String sid, String tag, String stat, String col) {
		String retStr = "";
		Hashtable tagTab = (Hashtable) sidTab.get(sid);
		Hashtable statTab = (Hashtable) tagTab.get(tag);
		Hashtable colTab = (Hashtable) statTab.get(stat);

		if (colTab != null) {

			Vector valueVect = (Vector) colTab.get(col);
			if (valueVect != null)
				for (int i=0;i<valueVect.size();i++)
					retStr = retStr + COL_DELIMITER + (String) valueVect.elementAt(i);
		}

		return retStr;
	}





///////////////////////////////////////////////////////////////////////////////////////////////////////
   /**
	*
	* save the data to memory
	*
	**/
	public void put(String sid, String stat, String value) {
		Hashtable statTab = (Hashtable) sidTab.get(sid);
		if (statTab == null)
			statTab = new Hashtable();
		sidTab.put(sid, statTab);

		Vector valueVect = (Vector) statTab.get(stat);
		if (valueVect == null)
			valueVect = new Vector();

		if (valueVect.size() >= MAXLEN)
			valueVect.removeElementAt(0);

		valueVect.add(value);
		statTab.put(stat, valueVect);
	}

   /**
	*
	* get the data in (delimited) string format
	*
	**/
	public String get(String sid, String stat) {
		String retStr = "";
		Hashtable statTab = (Hashtable) sidTab.get(sid);

		if (statTab != null) {
			Vector valueVect = (Vector) statTab.get(stat);
			if (valueVect != null)
				for (int i=0;i<valueVect.size();i++)
					retStr = retStr + COL_DELIMITER + (String) valueVect.elementAt(i);
		}

		return retStr;
	}


   /**
	*
	* get the data in vector
	*
	**/
	public Vector getVect(String sid, String stat) {
		String METHODNAME = "getVect";

		String retStr = "";
		Hashtable statTab = (Hashtable) sidTab.get(sid);

		if (statTab != null)
			return (Vector) statTab.get(stat);
/*
		// error!!
		String message = "Vector is NULL!! for sid: " + sid
							+ " stat name: " + stat;
		SysLog log = new SysLog();
		log.write(CLASSNAME, METHODNAME,
							SysLog.ML_SEVERE,
							null,
							message);
*/
		return null;
	}

   /**
	*
	* get the data in vector
	*
	**/
	public Vector getVect(String sid, String tag, String stat, String col) {
		String METHODNAME = "getVect";

		Hashtable tagTab = (Hashtable) sidTab.get(sid);
		if (tagTab == null) {
			String message = "Tag table should not be null, but it is!!"
							+ " sid=" + sid
							+ ", tag=" + tag
							+ ", stat=" + stat
							+ ", col=" + col;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								null,
								message);
			return null;
		}

		Hashtable statTab = (Hashtable) tagTab.get(tag);
		if (statTab == null) {
			String message = "Stat table should not be null, but it is!!"
							+ " sid=" + sid
							+ ", tag=" + tag
							+ ", stat=" + stat
							+ ", col=" + col;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								null,
								message);
			return null;
		}

		Hashtable colTab = (Hashtable) statTab.get(stat);

		if (colTab == null) {
			String message = "Col table should not be null, but it is!!"
							+ " sid=" + sid
							+ ", tag=" + tag
							+ ", stat=" + stat
							+ ", col=" + col;
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
								SysLog.ML_SEVERE,
								null,
								message);
			return null;
		}

		return (Vector) colTab.get(col);

	}





///////////////////////////////////////////////////////////////////////////////////////////////////

	public static void main(String args[]) {
//		ObjReader o = new ObjReader("test.out");

		DBMem t = new DBMem();

		t.put("DDNA20", "cpu", "2");
		t.put("DDNA20", "cpu", "3");
		t.put("DDNA20", "cpu", "2");
		t.put("DDNA20", "cpu", "2");
		t.put("DDNA20", "cpu", "6");
		t.put("DDNA20", "cpu", "5");
		t.put("DDNA20", "cpu", "4");

		t.put("DDNA20", "io", "27");
		t.put("DDNA20", "io", "24");
		t.put("DDNA20", "io", "25");
		t.put("DDNA20", "io", "27");
		t.put("DDNA20", "io", "25");
		t.put("DDNA20", "io", "24");
		t.put("DDNA20", "io", "21");

		t.put("ABC", "cpu", "2");
		t.put("ABC", "cpu", "3");
		t.put("ABC", "cpu", "2");
		t.put("ABC", "cpu", "2");
		t.put("ABC", "cpu", "6");
		t.put("ABC", "cpu", "5");
		t.put("ABC", "cpu", "2");

		System.out.println(t.get("DDNA20", "cpu"));
		System.out.println(t.get("DDNA20", "io"));
		System.out.println(t.get("ABC", "cpu"));
	}
}