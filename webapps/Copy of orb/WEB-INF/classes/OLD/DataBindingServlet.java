import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

/**
*
* just a (servlet) wrapper
*
**/
public class DataBindingServlet extends HttpServlet {

	private Oracle ora;
	private DataBinding dBinding;
	private String dbString;
	private String id;
	private static Hashtable dataTab = new Hashtable();


	public DataBindingServlet() {

	}

	public void init(Oracle ora) {
		this.ora = ora;
		dBinding = new DataBinding(ora);
		dbString = dBinding.getDBString();

		// save the data for furture use
		java.util.Date date = new java.util.Date();
		Random r = new Random(date.getTime());

		Long l = new Long(r.nextLong());
		if (l.longValue() < 0)
			l = new Long(l.longValue() * -1);

		id = l.toString();

		dataTab.put(id, dbString);
	}

	public String getId() {	return id; }
	public String getHTMLCol() { return dBinding.getHTMLCol(); }
	public String getHTMLDataFld() { return dBinding.getHTMLDataFld(); }
	public String getDataBindingObj(String url, String param) { return dBinding.getDataBindingObj(url, param); }
	public String getDataBindingTable(String title) { return dBinding.getDataBindingTable(title); }
	public String getSelectDataBindingTable(String title, String colName) { return dBinding.getSelectDataBindingTable(title, colName); }
	public String getDBString() { return dbString; }


   /**
	*
	* servlet
	*
	**/
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws IOException, ServletException
    {
        PrintWriter out = response.getWriter();

		String id = request.getParameter("id");
		out.println((String) dataTab.get(id));

		// remove the data from the hashtable
		dataTab.remove(id);
    }

	public static void main(String args[]) {
		Oracle o = new Oracle("Chialin", "1521", "system", "oracle00", "CHIALIN");
		SQLReader sr = new SQLReader();
		sr.readFile("test.sql");
//			String sqlStr = sr.getSQL("Query-1.10");
		String sqlStr = "select  substr(FILE_ID,1,3) \"ID#\","
							+ " substr(FILE_NAME,1,52) \"Filename\","
							+ " substr(TABLESPACE_NAME,1,25) \"Tablespace\","
							+ " BYTES/1024/1024 \"M Bytes\","
							+ " BLOCKS \"SQL Blks\","
							+ " BYTES/512 \"VMS Blocks\","
							+ " STATUS"
							+ " from sys.dba_data_files"
							+ " order by TABLESPACE_NAME, FILE_NAME";

		System.out.println(sqlStr);
		o.executeSQL(sqlStr);

		DataBindingServlet db = new DataBindingServlet();
		db.init(o);
		System.out.println("----------------");
		System.out.println(db.getHTMLCol());
		System.out.println(db.getHTMLDataFld());
		System.out.println(db.getId());
		System.out.println(db.getDBString());
		System.out.println("----------------");

	}


}