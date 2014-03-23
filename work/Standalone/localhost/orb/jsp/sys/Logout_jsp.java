package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.jasper.runtime.*;
import com.orb.sys.ServerSession;

public class Logout_jsp extends HttpJspBase {


  private static java.util.Vector _jspx_includes;

  static {
    _jspx_includes = new java.util.Vector(1);
    _jspx_includes.add("/jsp/sys/Login.jsp");
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

      out.write("\r\n\r\n");

	String id = session.getId();
	ServerSession ss = new ServerSession();
	ss.logout(id);

      out.write("\r\n\r\n");
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
      out.write("\r\n");
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
