<%@ page import = "com.orb.oracle.DBHtmlSortable" %>
<%@ page import = "com.orb.sys.ServerSession" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>


<h3>Summary:</h3>

<%
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

//	SQLReader sqlReader = new SQLReader();
//	sqlReader.refresh();

	DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("USER_IN_ROLLBACK", "oracle/user/UserInRollbackSegs", chkTag, colName, out);
	out.println(dbhs.getHtmlTable());
%>


<p>
<h3>Note:</h3>
<ul>
	<li>
</ul>
</p>

<h3>Description:</h3>
<ul>
	<li>Username: Oracle username
	<li>RS Name: Rollback segment name
	<li>RS Size: Rollback segment size
	<li>Waits
	<li>Extents
	<li>Shrinks
	<li>Opt Size
	<li>Command: Command in progress (last statement parsed)
</ul>

<hr>
<h3>Command lookup table:</h3>
<ul>
	<li>1: CREATE TABLE
	<li>2: INSERT
	<li>3: SELECT
	<li>4: CREATE CLUSTER
	<li>5: ALTER CLUSTER
	<li>6: UPDATE
	<li>7: DELETE
	<li>8: DROP CLUSTER
	<li>9: CREATE INDEX
	<li>10: DROP INDEX
	<li>11: ALTER INDEX
	<li>12: DROP TABLE
	<li>13: CREATE SEQUENCE
	<li>14: ALTER SEQUENCE
	<li>15: ALTER TABLE
	<li>16: DROP SEQUENCE
	<li>17: GRANT
	<li>18: REVOKE
	<li>19: CREATE SYNONYM
	<li>20: DROP SYNONYM
	<li>21: CREATE VIEW
	<li>22: DROP VIEW
	<li>23: VALIDATE INDEX
	<li>24: CREATE PROCEDURE
	<li>25: ALTER PROCEDURE
	<li>26: LOCK TABLE
	<li>27: NO OPERATION
	<li>28: RENAME
	<li>29: COMMENT
	<li>30: AUDIT
	<li>31: NOAUDIT
	<li>32: CREATE DATABASE LINK
	<li>33: DROP DATABASE LINK
	<li>34: CREATE DATABASE
	<li>35: ALTER DATABASE
	<li>36: CREATE ROLLBACK SEGMENT
	<li>37: ALTER ROLLBACK SEGMENT
	<li>38: DROP ROLLBACK SEGMENT
	<li>39: CREATE TABLESPACE
	<li>40: ALTER TABLESPACE
	<li>41: DROP TABLESPACE
	<li>42: ALTER SESSION
	<li>43: ALTER USE
	<li>44: COMMIT
	<li>45: ROLLBACK
	<li>46: SAVEPOINT
	<li>47: PL/SQL EXECUTE
	<li>48: SET TRANSACTION
	<li>49: ALTER SYSTEM SWITCH LOG
	<li>50: EXPLAIN
	<li>51: CREATE USER
	<li>25: CREATE ROLE
	<li>53: DROP USER
	<li>54: DROP ROLE
	<li>55: SET ROLE
	<li>56: CREATE SCHEMA
	<li>57: CREATE CONTROL FILE
	<li>58: ALTER TRACING
	<li>59: CREATE TRIGGER
	<li>60: ALTER TRIGGER
	<li>61: DROP TRIGGER
	<li>62: ANALYZE TABLE
	<li>63: ANALYZE INDEX
	<li>64: ANALYZE CLUSTER
	<li>65: CREATE PROFILE
	<li>66: DROP PROFILE
	<li>67: ALTER PROFILE
	<li>68: DROP PROCEDURE
	<li>69: DROP PROCEDURE
	<li>70: ALTER RESOURCE COST
	<li>71: CREATE SNAPSHOT LOG
	<li>72: ALTER SNAPSHOT LOG
	<li>73: DROP SNAPSHOT LOG
	<li>74: CREATE SNAPSHOT
	<li>75: ALTER SNAPSHOT
	<li>76: DROP SNAPSHOT
	<li>79: ALTER ROLE
	<li>85: TRUNCATE TABLE
	<li>86: TRUNCATE COUSTER
	<li>88: ALTER VIEW
	<li>91: CREATE FUNCTION
	<li>92: ALTER FUNCTION
	<li>93: DROP FUNCTION
	<li>94: CREATE PACKAGE
	<li>95: ALTER PACKAGE
	<li>96: DROP PACKAGE
	<li>97: CREATE PACKAGE BODY
	<li>98: ALTER PACKAGE BODY
	<li>99: DROP PACKAGE BODY
</ul>

</body>
</html>
