package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.jasper.runtime.*;
import com.orb.oracle.Database;
import com.orb.oracle.DBHtml;
import com.orb.oracle.DBHtmlSortable;
import com.orb.sys.ServerSession;
import java.util.Vector;
import com.orb.sys.ServerSession;
import com.orb.sys.Server;
import com.orb.sys.ServerInfo;
import com.orb.sys.ServerSession;
import com.orb.sys.Server;

public class Overview_0002dDatabase_jsp extends HttpJspBase {


  private static java.util.Vector _jspx_includes;

  static {
    _jspx_includes = new java.util.Vector(3);
    _jspx_includes.add("/jsp/oracle/../sys/Session.jsp");
    _jspx_includes.add("/jsp/oracle/../sys/Login.jsp");
    _jspx_includes.add("/jsp/oracle/Header.jsp");
  }

  public java.util.List getIncludes() {
    return _jspx_includes;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    javax.servlet.jsp.PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html;charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n\r\n");
      out.write("\r\n\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n\r\n");

	String id = session.getId();
	ServerSession ss = new ServerSession();
	String loginId = ss.getLogin(id);  // is the http session id

	if (loginId == null) {

      out.write("\r\n\t");
      out.write("<!-- The Login Page -->\r\n\t");
      out.write("<script language=\"JavaScript\" type=\"text/javascript\">\r\n\t\t\tif (self.parent.frames.length != 0)\r\n\t\t\t\tself.parent.location=document.location;\r\n\t");
      out.write("</script>\r\n\r\n\t");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\r\n\r\n\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<body>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\r\n\r\n");
      out.write("</head>\r\n\r\n");
      out.write("<table bgcolor=\"#ffffff\" cellpadding=0 cellspacing=0 border=0 width=100% height=80%>\r\n\r\n");
      out.write("<FORM method=post action=/orb/jsp/sys/Main.jsp id=Login name=Login>\r\n");
      out.write("<tr>\r\n");
      out.write("<td valign=top width=66>\r\n");
      out.write("</td>\r\n\r\n");
      out.write("<td bgcolor=\"#ffffff\">\r\n\r\n");
      out.write("<table align=center border=\"0\">\r\n\t");
      out.write("<tr>\r\n            ");
      out.write("<th align=\"right\">Login:");
      out.write("</th>\r\n            ");
      out.write("<td>");
      out.write("<input type=\"text\" size=\"20\" name=\"username\">");
      out.write("</td>\r\n\t    ");
      out.write("<td>&nbsp;");
      out.write("</td>\r\n\t");
      out.write("</tr>\r\n        ");
      out.write("<tr>\r\n            ");
      out.write("<th align=\"right\">Password:");
      out.write("</th>\r\n            ");
      out.write("<td>");
      out.write("<input type=\"password\" size=\"20\" name=\"password\">");
      out.write("</td>\r\n\t    ");
      out.write("<td>&nbsp;");
      out.write("</td>\r\n        ");
      out.write("</tr>\r\n\t");
      out.write("<tr>");
      out.write("<td>&nbsp;");
      out.write("</td>");
      out.write("<td>&nbsp;");
      out.write("</td>");
      out.write("</tr>\r\n\t");
      out.write("<tr>\r\n\t    ");
      out.write("<td>&nbsp;");
      out.write("</td>\r\n\r\n            ");
      out.write("<td align=right>");
      out.write("<input type=\"submit\" value=\"Login\">");
      out.write("</td>\r\n        ");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("</form>\r\n");
      out.write("</td>\r\n");
      out.write("<td>\r\n&nbsp\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td>\r\n&nbsp\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n\r\n");
      out.write("</table>\r\n\r\n");
      out.write("</form>");
      out.write("\r\n\r\n");

		return;
	}

	String sid = null;
	String choosenSid = request.getParameter("sid");
	String savedSid = ss.getSid(id);

	if (choosenSid != null) {
		// first time
		sid = choosenSid;
		ss.setSid(id, sid);

	} else if (savedSid != null) {
		sid = savedSid;

	} else if (choosenSid == null && savedSid == null) {

		// sort the server list
		ServerInfo si = new ServerInfo();
		String[] sidArr = si.getOrderedSidList();
		sid = sidArr[0];
		ss.setSid(id, sid);
	}

	String machine = ss.getMachine(id);
	String port = ss.getPort(id);
	String username = ss.getUsername(id);
	String password = ss.getPassword(id);





      out.write("\r\n");
      out.write("\r\n\r\n");

	// Want to order this sql by this column
	String chkTag = request.getParameter("chkTag");
	String colName = request.getParameter("orderBy");

      out.write("\r\n\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\r\n\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n\t");
      out.write("<title>");
      out.write("</title>\r\n\t");
      out.write("<SCRIPT LANGUAGE=\"JavaScript1.2\" SRC=\"/js/HM_Global.js\">");
      out.write("</SCRIPT>\r\n");
      out.write("</head>\r\n\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("\r\n\r\n\r\n");

	// printing sid
	String idx = session.getId();
	ServerSession ssx = new ServerSession();
	String sidx = ssx.getSid(idx);
	out.println("[" + sidx + "]");

      out.write("\r\n\r\n");
      out.write("<A target=_top HREF=\"/orb/jsp/sys/Main.jsp\">Main");
      out.write("</A> |\r\n");
      out.write("<A HREF=\"/orb/jsp/oracle/data.jsp\">Change DB");
      out.write("</A> |\r\n");
      out.write("<A HREF=\"/orb/jsp/util/ServerList.jsp\">Server List");
      out.write("</A> |\r\n");
      out.write("<A target=_top HREF=\"/orb/jsp/sys/Logout.jsp\">Logout");
      out.write("</A>\r\n");
      out.write("\r\n\r\n");
      out.write("<H3>Enough memory?");
      out.write("</H3>\r\nOracle init parameters\r\n");
      out.write("<ul>\r\n\t");

	//	SQLReader sqlReader = new SQLReader();
	//	sqlReader.refresh();
		DBHtml dbh = new DBHtml(machine, port, username, password, sid);
		DBHtmlSortable dbhs = new DBHtmlSortable(machine, port, username, password, sid);
		dbhs.executeSQL("OV_INIT_PARAM", "oracle/Overview-Database", chkTag, colName);
		out.println(dbhs.getHtmlTable());
	
      out.write("\r\n");
      out.write("</ul>\r\n\r\nHit Ratio:\r\n");
      out.write("<ul>\r\n");
      out.write("<table border=\"1\" cellpadding=\"5\" cellspacing=\"0\">\r\n");
      out.write("<tr>\r\n\t\t");
      out.write("<td>");
      out.write("<b>Buffer Type");
      out.write("</b>");
      out.write("</td>\r\n\t\t");
      out.write("<td>");
      out.write("<b>%");
      out.write("</b>");
      out.write("</td>\r\n");
      out.write("</tr>\r\n\r\n");
      out.write("<tr>\r\n");

	// data buffer
	Database db = new Database(machine, port, username, password, sid);
	db.executeSQL("OV_HIT_RATIO");
	Vector resultVect = db.getResultVect();
	out.println("<td>Data Buffer: </td>"
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");

      out.write("\r\n");
      out.write("</tr>\r\n\r\n");
      out.write("<tr>\r\n");

	// data dictionary
	db.executeSQL("OV_ROW_CACHE");
	resultVect = db.getResultVect();
	out.println("<td>Data Dictionary: </td>"
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");

      out.write("\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");

	// library
	db.executeSQL("OV_LIB_CACHE");
	resultVect = db.getResultVect();
	out.println("<td>Library Cache: </td>"
		+ "<td>" + ((String) resultVect.elementAt(0)).substring(0, 5) + "</td>");


      out.write("\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("</ul>\r\n\r\nShared pool size:\r\n");
      out.write("<ul>\r\n");

	dbh.executeSQL("OV_SHARED_POOL_SIZE");
	out.println(dbh.getHtmlTable());

      out.write("\r\n");
      out.write("</ul>\r\n");
      out.write("<P>\r\n\r\n\r\nShared pool detail break down:\r\n\t");
      out.write("<A href=\"Overview-sys.jsp\" target=body >Run as sys");
      out.write("</a>");
      out.write("<br>\r\n");
      out.write("<P>\r\n\r\n\r\nSort:\r\n");
      out.write("<ul>\r\n");

	dbh.executeSQL("OV_SORT");
	out.println(dbh.getHtmlTable());

      out.write("\r\n");
      out.write("</ul>\r\n\r\n\r\n");
      out.write("<h3>Datafile I/O");
      out.write("</h3>\r\n");
      out.write("<ul>\r\n");

	dbhs = new DBHtmlSortable(machine, port, username, password, sid);
	dbhs.executeSQL("OV_DISK_IO", "oracle/Overview-Database", chkTag, colName);
	out.println(dbhs.getHtmlTable());

      out.write("\r\n");
      out.write("</TR>");
      out.write("</TABLE>\r\n");
      out.write("</ul>\r\n\r\n");
      out.write("<h3>SQL Info:");
      out.write("</h3>\r\n");
      out.write("<A href=\"Overview-SQL.jsp\" target=body >Click here");
      out.write("</a>");
      out.write("<br>\r\n\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      out = _jspx_out;
      if (out != null && out.getBufferSize() != 0)
        out.clearBuffer();
      if (pageContext != null) pageContext.handlePageException(t);
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(pageContext);
    }
  }
}
