<%@ page import = "com.orb.sys.ServerSession" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>The only official FolderTree by Essence Associates Ltd.</title>

<link rel="stylesheet" href="ftstyle.css">
<!-- Infrastructure code for the tree -->
<script language = "Javascript" src = "/js/FT/ft.js"></script>
<script language = "Javascript" src = "/js/FT/ftoptions.js"></script>
<script language = "Javascript" src = "/js/FT/OracleAdmin.js"></script>
</head>


<FRAMESET cols="200,*"  onLoad="self.blank()">
  <FRAME SRC = "control.jsp" name="menufrm" >
  <FRAME SRC="data.jsp" name="basefrm">
</FRAMESET>


</HTML>
