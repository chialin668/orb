package com.orb.oracle;

import java.sql.*;


public class OraPrepare
{
    Connection          conn = null;
    Statement           stmt = null;
    PreparedStatement   pstmt = null;
    ResultSet           rset = null;
    ResultSetMetaData rsmd;

	String machine = "orb";
	String port = "1521";
	String sid = "REPOS";
	String username = "system";
	String password = "oracle00";

	public void prepareInsert() {

		try
		{
		  DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

			conn = DriverManager.getConnection (
								"jdbc:oracle:thin:@"
									+ machine + ":" + port + ":" + sid,
								username, password);


			for (int i=0;i<1000;i++) {
				pstmt = conn.prepareStatement("insert into test(id) values (?)");
				pstmt.setInt(1, i);

				rset = pstmt. executeQuery();
				pstmt.close();
			}

			conn.close();
		} catch (Exception e){
		  	e.printStackTrace();
		}
	}


	public void prepareSelect() {

		try
		{
		  DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

			conn = DriverManager.getConnection (
								"jdbc:oracle:thin:@"
									+ machine + ":" + port + ":" + sid,
								username, password);


			for (int i=400;i<500;i++) {
				pstmt = conn.prepareStatement("select * from test where id = ?");
				pstmt.setInt(1, i);

				rset = pstmt. executeQuery();
				rsmd = rset.getMetaData();
				int colCount = rsmd.getColumnCount();

				 while (rset.next ())
					System.out.print(rset.getString(1));

				pstmt.close();
			}

			conn.close();

		} catch (Exception e)	{
		  	e.printStackTrace();
		}

	}

	public void notPrepareSelect() {

		try
		{
		  DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

			conn = DriverManager.getConnection (
								"jdbc:oracle:thin:@"
									+ machine + ":" + port + ":" + sid,
								username, password);


			for (int i=600;i<700;i++) {
				stmt = conn.createStatement ();
				String sqlStr = "select * from test where id = " + i;
				rset = stmt.executeQuery (sqlStr);
				while (rset.next ())
					System.out.print(rset.getString (1));

				stmt.close();
			}

			conn.close();

		} catch (Exception e)	{
		  	e.printStackTrace();
		}

	}


  public static void main(String[] args)  {

	  OraPrepare op = new OraPrepare();
	  //op.prepareSelect();

	  op.notPrepareSelect();
	  //op.prepareInsert();

  }

}
