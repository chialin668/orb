
// You need to import the java.sql package to use JDBC
import java.sql.*;

class Test
{
  public static void main (String args [])
       throws SQLException
  {

    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

    Connection conn =
DriverManager.getConnection ("jdbc:oracle:thin:@orb:1521:REPOS",
				   "system", "oracle00");
    // Create a Statement
    Statement stmt = conn.createStatement ();

    // Select the ENAME column from the EMP table
    //ResultSet rset = stmt.executeQuery ("select ENAME from EMP");
    ResultSet rset = stmt.executeQuery ("select distinct name from dbstat where value != 0");

    // Iterate through the result and print the employee names
    while (rset.next ()){
		String value = rset.getString (1);
/*
		String retStr = "<A href=\"/orb/jsp/oracle/serverinfo/stat.jsp?statName="
					+  value
					+ "\">" + value + "</a><br>";
      	System.out.println (retStr);
*/

		String retStr = "\t<OPTION VALUE=\"" + value + "\">" + value;
		System.out.println(retStr);

  }
  }
}
