package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.jasper.runtime.*;

public class ERD_0002dmain_jsp extends HttpJspBase {


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

      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\r\n\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n\t");
      out.write("<title>");
      out.write("</title>\r\n");
      out.write("</head>\r\n\r\n");
      out.write("<body>\r\n\r\n\t");
      out.write("<A href=\"ERD-New.jsp\">New ERD");
      out.write("</a>");
      out.write("<br>\r\n\r\n");
      out.write("<form method=\"POST\" action=\"/orb/jsp/erd/ERD.jsp\">\r\n\t");
      out.write("<p>");
      out.write("<select size=\"1\" name=\"projectName\">\r\n\t\t");
      out.write("<option>New");
      out.write("</option>\r\n\t\t");
      out.write("<option>CDRS");
      out.write("</option>\r\n\t\t");
      out.write("<option>DDW");
      out.write("</option>\r\n\t");
      out.write("</select>");
      out.write("<input type=\"submit\" value=\"Submit\" name=\"B1\">");
      out.write("<input type=\"reset\" value=\"Reset\" name=\"B2\">");
      out.write("</p>\r\n");
      out.write("</form>\r\n\t\r\n\r\n");
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
