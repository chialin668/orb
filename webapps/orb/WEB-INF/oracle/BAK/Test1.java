import java.io.Serializable;
import java.util.Hashtable;
import java.util.Vector;

public class Test1 implements Serializable{
	private String COL_DELIMITER = Environment.COL_DELIMITER;

	private static Hashtable sidTab = new Hashtable();

	public void put(String sid, String stat, String value) {
		Hashtable statTab = (Hashtable) sidTab.get(sid);
		if (statTab == null)
			statTab = new Hashtable();
			sidTab.put(sid, statTab);

		Vector valueVect = (Vector) statTab.get(stat);
		if (valueVect == null)
			valueVect = new Vector();

		valueVect.add(value);
		statTab.put(stat, valueVect);
	}

	public String get(String sid, String stat) {
		String retStr = "";
		Hashtable statTab = (Hashtable) sidTab.get(sid);

		if (statTab != null) {
			Vector valueVect = (Vector) statTab.get(stat);
			for (int i=0;i<valueVect.size();i++)
				retStr = retStr + COL_DELIMITER + (String) valueVect.elementAt(i);
		}

		return retStr;
	}

	public static void main(String args[]) {
		Test1 t = new Test1();

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
		t.put("ABC", "cpu", "4");


		System.out.println(t.get("DDNA20", "cpu"));
		System.out.println(t.get("DDNA20", "io"));
		System.out.println(t.get("ABC", "cpu"));
	}
}