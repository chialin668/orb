import java.sql.*;

class OraTest
{
  public static void main (String args [])
       throws SQLException
  {
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

    Connection conn =
	DriverManager.getConnection ("jdbc:oracle:thin:@orb:1521:REPOS",
				   "system", "oracle00");
    Statement stmt = conn.createStatement ();

    ResultSet rset = null;
//    stmt.execute("set autotrace on");
	stmt.execute("delete from plan_table");

	stmt.execute ("explain plan for select count(*) from dbstat");
    String sqlStr = "select lpad(' ',2*level)||operation||' '||options"
						+ " ||' '||object_name query_plan"
						+ " from   plan_table"
						+ " connect by prior id = parent_id "
						+ " start with id = 1";

   	rset = stmt.executeQuery (sqlStr);

    while (rset.next ())
      System.out.println (rset.getString (1));

	stmt.close();
	conn.close();
  }
}
