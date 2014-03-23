package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.jasper.runtime.*;
import com.orb.sys.ServerInfo;
import com.orb.sys.ServerSession;
import com.orb.sys.ServerSession;
import com.orb.sys.Server;

public class data_jsp extends HttpJspBase {


  private static java.util.Vector _jspx_includes;

  static {
    _jspx_includes = new java.util.Vector(1);
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
      out.write("\r\n\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\r\n\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n\t");
      out.write("<title>");
      out.write("</title>\r\n\r\n\t");
      out.write("<SCRIPT LANGUAGE=\"JavaScript\">\r\n\tfunction goThere() {\r\n\t\tvar list = document.forms[0].sid;\r\n\t\tlocation = \"/orb/jsp/oracle/Overview-Database.jsp?sid=\"\r\n\t\t\t+ list.options[list.selectedIndex].value;\r\n\t}\r\n\t");
      out.write("</SCRIPT>\r\n\r\n");
      out.write("</head>\r\n\r\n");
      out.write("<body>\r\n\t");
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
      out.write("\r\n\r\n\r\n\t");
      out.write("<form>\r\n\t");
      out.write("<table cellspacing=\"2\" cellpadding=\"2\" border=\"0\">\r\n\t");
      out.write("<tr>\r\n\t\t");
      out.write("<td>Select a Server ID:");
      out.write("</td>\r\n\t\t");
      out.write("<td>\r\n\t\t");
      out.write("<select id=sid name=sid onChange=\"goThere()\">\r\n\r\n\t\t");

		// get the sid list
		ServerInfo si = new ServerInfo();
		String[] sidArr = si.getOrderedSidList();

		// current sid
		String id = session.getId();
		ServerSession ss = new ServerSession();
		String sid = ss.getSid(id);

		// generate the output
		for (int j=0;j<sidArr.length;j++) {
			if (sidArr[j].equals(sid))
				out.println("<option value=" + sidArr[j] + " selected>" + sidArr[j]);
			else
				out.println("<option value=" + sidArr[j] + ">" + sidArr[j]);
		}
		
      out.write("\r\n\r\n\t\t");
      out.write("</select>\r\n\r\n\t");
      out.write("</table>\r\n\t");
      out.write("</form>\r\n\r\n\r\n\r\n");
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
