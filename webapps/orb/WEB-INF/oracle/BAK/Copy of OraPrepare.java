/**
 * A simple sample to demonstrate Batch Updates.
 */

import java.sql.*;


public class OraPrepare
{
  public static void main(String[] args)
  {
    Connection          conn = null;
    Statement           stmt = null;
    PreparedStatement   pstmt = null;
    ResultSet           rset = null;
    int                 i = 0;

	String machine = "orb";
	String port = "1521";
	String sid = "REPOS";
	String username = "system";
	String password = "oracle00";
    try
    {
      DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

//      conn = DriverManager.getConnection(
//               "jdbc:oracle:oci8:@orb:1521:REPOS", "system", "ooracle");


		conn = DriverManager.getConnection (
							"jdbc:oracle:thin:@"
								+ machine + ":" + port + ":" + sid,
							username, password);

      stmt = conn.createStatement();
      try { stmt.execute(
            "create table mytest_table (col1 number, col2 varchar2(20))");
      } catch (Exception e1) {}

      //
      // Insert in a batch.
      //
      pstmt = conn.prepareStatement("insert into mytest_table values (?, ?)");

      pstmt.setInt(1, 1);
      pstmt.setString(2, "row 1");
      pstmt.addBatch();

      pstmt.setInt(1, 2);
      pstmt.setString(2, "row 2");
      pstmt.addBatch();

      pstmt.executeBatch();

      //
      // Select and print results.
      //
      rset = stmt.executeQuery("select * from mytest_table");
      while (rset.next())
      {
        System.out.println(rset.getInt(1) + ", " + rset.getString(2));
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    finally
    {
      if (stmt != null)
      {
	try { stmt.execute("drop table mytest_table"); } catch (Exception e) {}
        try { stmt.close(); } catch (Exception e) {}
      }
      if (pstmt != null)
      {
        try { pstmt.close(); } catch (Exception e) {}
      }
      if (conn != null)
      {
        try { conn.close(); } catch (Exception e) {}
      }
    }
  }
}
