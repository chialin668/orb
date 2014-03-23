import java.io.*;
import java.util.Hashtable;


public class SQLReader {
	private String CLASSNAME = this.getClass().getName();

	private static Hashtable sqlTab = new Hashtable();
	private static boolean hasRead = false;

   /**
    * read the sql
    *
    * @param fileName the file name of the look-up table
    * @return false if error happens
    *
    **/
    protected boolean readFile(String fileName) {
		String METHODNAME = "executeSQL";

		if (hasRead) return true;

        // read the configuration file
        FileReader fr = null;

        try {
            System.out.println("Reading file: " + fileName + " ...");
            fr = new FileReader(fileName);

        } catch (java.io.FileNotFoundException e) {
            String message = "SQL file: " + fileName + "NOT FOUND!!!";
			SysLog log = new SysLog();
			log.write(CLASSNAME, METHODNAME,
						SysLog.ML_SEVERE,
						e,
						message);
            return false;
        }

        // go through the look-up-table definition file
        BufferedReader br = new BufferedReader(fr);

		String buff = "";
		String prevBuff;
		boolean start = false;
		String tagStr = null;
		String sqlStr = "";

        while (true) {

        	try {

				prevBuff = new String(buff);
                buff = br.readLine();

                if (buff != null &&
                		buff.length() > 1
                			&& buff.substring(0, 1).equals("#"))
                	continue;

            } catch (java.io.IOException e) {
				String message = "Error reading SQL file: " + fileName;
				SysLog log = new SysLog();
				log.write(CLASSNAME, METHODNAME,
							SysLog.ML_SEVERE,
							e,
							message);
                return false;
            }

            if (buff == null) {
				hasRead = true;
                return true;  // EOF

            } else {
				// System.out.println("->" + buff);
				buff = buff.replace(';', ' ');
				if (start) sqlStr = sqlStr + buff + "\n";

				if (buff.equals("{")) {
					start = true;
					tagStr = prevBuff;

				} else if (buff.equals("}")) {
					start = false;
					sqlStr = sqlStr.substring(0, sqlStr.indexOf("}"));
					sqlTab.put(tagStr.trim(), sqlStr);
					sqlStr = "";

					//System.out.println("|" + tagStr + "|");
					//System.out.println(sqlStr);
				}

			}

        }

        // should never be here!!
    }

	public void refresh() {
		this.hasRead = false;
	}

	public String getSQL(String tagStr) {
		return (String) sqlTab.get(tagStr);
	}


	public void read(String fileName) {
		this.readFile(fileName);
	}

	public static void main(String args[]) {
		SQLReader sr = new SQLReader();
		sr.readFile("test.sql");
		System.out.println(sr.getSQL("Query-1.3"));

		SQLReader sr1 = new SQLReader();
		sr1.readFile("test.sql");

		SQLReader sr2 = new SQLReader();
		sr2.readFile("test.sql");
		System.out.println(sr2.getSQL("SUMM_INDEX"));
	}

}