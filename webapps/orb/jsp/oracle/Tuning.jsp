<%@ page import = "com.orb.sys.ServerInfo" %>
<%@ page import = "com.orb.sys.Server" %>
<%@ page import = "java.util.Hashtable" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "com.orb.sys.ServerSession" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="../sys/Session.jsp"%>


<html>
<head>
	<title> Tuning </title>

	<link rel="stylesheet" href="ftstyle.css">
	<script language = "Javascript" src = "/js/FT/ft.js"></script>
	<script language = "Javascript" src = "/js/FT/ftoptions.js"></script>
	<script language = "Javascript" src = "/js/FT/OracleTuning.js"></script>
</head>


<FRAMESET cols="200,*"  onLoad="self.blank()">
  <FRAME SRC = "control.jsp" name="menufrm" >
  <FRAME SRC="data.jsp" name="basefrm">
</FRAMESET>

</HTML>
