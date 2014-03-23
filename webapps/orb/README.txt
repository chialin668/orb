CLASSPATH=.;c:\Chialin\tomcat41\webapps\orb\WEB-INF\classes;
	c:\Chialin\tomcat41\lib\servlet.jar;
	c:\chialin\jdbc\lib\classes12.zip;

no	C:\Chialin\tomcat41\webapps\orb\WEB-INF\classes\jta20.jar;
no	c:\Chialin\jaxp-1.1\jaxp.jar;
no	c:\Chialin\jaxp-1.1\xalan.jar


JAVA_HOME=


Copy orb under C:\Chialin\Tomcat4.1\webapps\orb
Copy jsp and images from C:\Chialin\Tomcat4.1\webapps\ROOT


login page: http://chialin:8080/orb/jsp/sys/Login.jsp
	login: su
	password: dna



Add a new server:

   1.	Modify the java file:
	c:\Chialin\tomcat-321\webapps\orb\WEB-INF\sys\ServerInfo.java

		add ...
		Server prodlims = new Server(Server.SOLARIS, "2.7.x", "prodlims", "23", "oracle", "oracle00", "prodlims");
			Server prodlimsDB = new Server(Server.ORACLE, "8.1.x", "prodlims", "1521", "system", "oracle00", "PRODLIMS");
		serverTab.put("prodlims", prodlims);
			serverTab.put("PRODLIMS", prodlimsDB);

	c:\> make ServerInfo		


   2.	Modify the Java Script file
	c:\Chialin\tomcat-321\webapps\ROOT\js\treebuilder.js

		add ...		
		aux2 = insFld(aux1, gFld("prodlims", "/orb/jsp/sys/UnixOverview1.jsp?machine=prodlims"))
			insDoc(aux2, gLnk(2, "PRODLIMS", "/orb/jsp/sys/Overview.jsp?sid=PRODLIMS"))


Monitoring a server:
	click: 192.168.1 [network]
	click prodlims [machine]
	click PRODLIMS [SID]
	click 'Config Stat' [under 'Server Monitoring Control']

	See result:
		click 'Stat Result - 1' [under 'Chart Test']
	

set path=c:\Program Files\jdk130.02\bin;%PATH%
set java_home=c:\Program Files\jdk130.02

set CLASSPATH=.;c:\Chialin\tomcat-321\webapps\orb\WEB-INF\classes;c:\Chialin\tomcat-321\lib\servlet.jar;c:\chialin\jdbc\lib\classes12.zip;C:\Chialin\tomcat-321\weba
pps\orb\WEB-INF\classes\jta20.jar;C:\Program Files\Exceed.nt\hcljrcsv.jar;C:\Program Files\Exceed.nt\;c:\Chialin\jaxp-1.1\jaxp.jar;c:\Chialin\jaxp-1.1\xalan.jar


