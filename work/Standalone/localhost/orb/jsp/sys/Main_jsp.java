package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.jasper.runtime.*;
import com.orb.sys.ServerSession;

public class Main_jsp extends HttpJspBase {


  private static java.util.Vector _jspx_includes;

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

      out.write("\r\n\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\r\n\r\n");

	String username = request.getParameter("username");
	String password = request.getParameter("password");


      out.write("\r\n\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n\t");
      out.write("<title>");
      out.write("</title>\r\n\t");
      out.write("<style type=\"text/css\">\r\n\t\t");
      out.write("<!-- @import \"/orb/css/test.css\"; -->\r\n\t");
      out.write("</style>\r\n\r\n");
      out.write("</head>\r\n\r\n\r\n");
 if ((username != null && !username.equals("su"))
		|| (username != null && !password.equals("dna"))) {
      out.write("\r\n");
      out.write("<body>\r\n\tLogin Incorrect!!\r\n");
      out.write("</body>\r\n\r\n");

	} else {

	String id = session.getId();
	ServerSession ss = new ServerSession();
	ss.setLogin(id);


      out.write("\r\n\r\n\r\n");
      out.write("<body>\r\n\r\n");
      out.write("<table align=center border=\"0\">\r\n\t");
      out.write("<tr>\r\n\t\t");
      out.write("<td>");
      out.write("<h3>");
      out.write("<u>Main Menu");
      out.write("</u>");
      out.write("</h3>");
      out.write("<td>\r\n\t");
      out.write("</tr>\r\n\r\n\t");
      out.write("<tr>\r\n\t\t");
      out.write("<td>");
      out.write("<A HREF=\"/orb/jsp/util/ServerList.jsp\">Server Management");
      out.write("</A>");
      out.write("</td>\r\n\t");
      out.write("</tr>\r\n\r\n\t");
      out.write("<tr>\r\n\t\t");
      out.write("<td>");
      out.write("<A HREF=\"/orb/jsp/util/UserList.jsp\">User Management");
      out.write("</A>");
      out.write("</td>\r\n\t");
      out.write("</tr>\r\n\r\n\t");
      out.write("<tr>\r\n\t\t");
      out.write("<td>");
      out.write("<A HREF=\"/orb/jsp/erd/ERD-main.jsp\">ERD Design");
      out.write("</A>");
      out.write("</td>\r\n\t");
      out.write("</tr>\r\n\r\n\t");
      out.write("<tr>\r\n\t\t");
      out.write("<td>");
      out.write("<A HREF=\"/orb/jsp/oracle/Admin.jsp\">Admin Information");
      out.write("</A>");
      out.write("</td>\r\n\t");
      out.write("</tr>\r\n\r\n\t");
      out.write("<tr>\r\n\t\t");
      out.write("<td>");
      out.write("<A HREF=\"/orb/jsp/oracle/Tuning.jsp\">\r\n\t\t\t\t");
      out.write("<span class=emphasis>Monitoring and Tuning");
      out.write("</span>");
      out.write("</A>");
      out.write("</td>\r\n\t");
      out.write("</tr>\r\n");
      out.write("</table>\r\n\r\n");
      out.write("</body>\r\n");
 } 
      out.write("\r\n\r\n\r\n\r\n");
      out.write("</html>");
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
