import java.sql.*;

class ExplainPlan
{
  public static void main (String args [])
       throws SQLException
  {
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

    Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@orb:1521:REPOS",
				   "system", "oracle00");
    Statement stmt = conn.createStatement ();

    // Do the SQL "Hello World" thing
    ResultSet rset = stmt.executeQuery ("set autotrace on");

//	stmt.execute ("create or replace function RAISESAL (name CHAR, raise NUMBER) return NUMBER is begin return raise + 100000; end;");
/*
    ResultSet rset = stmt.executeQuery ("select table_name from dba_tables");

    while (rset.next ())
      System.out.println (rset.getString (1));
*/

}

}
