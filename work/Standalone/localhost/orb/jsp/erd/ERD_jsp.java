package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.jasper.runtime.*;
import com.orb.oracle.XmlSchemaIO;

public class ERD_jsp extends HttpJspBase {


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
      out.write("\r\n\r\n\r\n");


	String projectName = request.getParameter("projectName");

	//String xmlStr = request.getParameter("xml");

	XmlSchemaIO sw = new XmlSchemaIO();
	String xmlStr = sw.read(projectName);
	
	System.out.println(xmlStr);

      out.write("\r\n\r\n\r\n");
      out.write("<html xmlns:v=\"urn:schemas-microsoft-com:vml\">\r\n");
      out.write("<head>\r\n\r\n\t");
      out.write("<style>\tv\\:* { behavior: url(#default#VML); }");
      out.write("</style>\r\n\t");
      out.write("<style type=\"text/css\">\t@import url(./JS/ERD-Style.css); ");
      out.write("</style>\r\n\t");
      out.write("<style> @import url(\"./JS/ERD-Style.css\"); ");
      out.write("</style>\r\n\r\n\t");
      out.write("<script src=\"./JS/ERD-protable.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-global.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-sys.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-util.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-Netscape.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-xmlschema.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-datatype.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-validate.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-default.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-table.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-index.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-column.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-relationship.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\t");
      out.write("<script src=\"./JS/ERD-mouseEvent.js\" type=\"text/javascript\">");
      out.write("</script>\r\n\r\n\t");
      out.write("<script type=\"text/javascript\" src=\"/js/xml4script-20/jsXMLParser/xmldom.js\">");
      out.write("</script>\r\n");
      out.write("</head>\r\n\r\n\r\n");
      out.write("<body onload=\"sy_Init()\">\r\n\r\n");
      out.write("<FORM>\r\n\t");
      out.write("<INPUT TYPE=\"hidden\" ID=\"projectName\" NAME=\"projectName\" VALUE=\"");
      out.print(projectName);
      out.write("\">\r\n\r\n\t\r\n\t");
      out.write("<INPUT TYPE=\"button\" class=\"modeCtl\" VALUE=\"Select\" onClick=\"sy_SetSysMode(MOD_SELECT)\">\r\n\t");
      out.write("<INPUT TYPE=\"button\" class=\"modeCtl\" VALUE=\"New Table\" onClick=\"sy_SetSysMode(MOD_TABLE)\">\r\n\t\r\n\t");
      out.write("<INPUT TYPE=\"button\" class=\"modeCtl\" VALUE=\"1:1\" onClick=\"sy_SetSysMode(MOD_ONE2ONE)\">\r\n\t");
      out.write("<INPUT TYPE=\"button\" class=\"modeCtl\" VALUE=\"1:N\" onClick=\"sy_SetSysMode(MOD_ONE2MANY)\">\r\n\t");
      out.write("<INPUT TYPE=\"button\" class=\"modeCtl\" VALUE=\"M:N\" onClick=\"sy_SetSysMode(MOD_MANY2MANY)\">\r\n\t");
      out.write("<INPUT TYPE=\"button\" class=\"modeCtl\" VALUE=\"SQL\" onClick=\"xm_SaveSchema()\">\r\n\t\r\n\t\r\n\t");
      out.write("<INPUT TYPE=\"text\" NAME=\"sysModeField\" VALUE=\"\">\r\n\t");
      out.write("<table cellspacing=\"2\" cellpadding=\"2\" border=\"0\">\r\n\t");
      out.write("<tr>\r\n\t\t");
      out.write("<td>View:");
      out.write("</td>\r\n\t\t");
      out.write("<td>\r\n\t\t");
      out.write("<select id=viewType name=viewType onChange=\"tb_ChangeView()\">\r\n\t\t\t");
      out.write("<option value='' selected>\r\n\t\t\t");
      out.write("<option value='Compact'>Compact\r\n\t\t\t");
      out.write("<option value='Short'>Short\r\n\t\t\t");
      out.write("<option value='Full'>Full\r\n\t\t");
      out.write("</select>\r\n\t");
      out.write("</table>\t\r\n\t\r\n\t");
      out.write("<textarea name='xml' rows='10' cols='100'>");
      out.print(xmlStr);
      out.write("</textarea>\r\n\r\n");
      out.write("</FORM>\r\n\r\n\r\n\r\n");
      out.write("<SCRIPT LANGUAGE=JavaScript>\r\n\r\n\r\n\r\nxm_ReadSchema();\r\n/*\r\n// DB_USER\r\nvar User_WID \t= new Array(PRIMARY_EKY_MARK, \"User_WID\", \"number\", \"-\", \"-\", \"-\", \"-\");\r\nvar User_Name \t= new Array(\"-\", \"User_Name\", \"varchar2\", \"16\", \"-\", \"-\", \"-\");\r\nvar First_Name \t= new Array(\"-\", \"First_Name\", \"varchar2\", \"32\", \"-\", \"-\", \"-\");\r\nvar Last_Name \t= new Array(\"-\", \"Last_Name\", \"varchar2\", \"32\", NULLABLE_MARK, \"sex\", \"male\");\r\nvar MD5_Hex_Password = new Array(\"-\", \"MD5_Hex_Password\", \"varchar2\", \"64\", \"-\", \"-\", \"-\");\r\nvar Status \t\t= new Array(\"-\", \"Status\", \"char\", \"1\", \"-\", \"-\", \"-\");\r\nvar Version_Nbr = new Array(\"-\", \"Version_Nbr\", \"number\", \"3\", \"-\", \"-\", \"-\");\r\nvar columnArray = new Array(User_WID, User_Name, First_Name,\r\n\t\t\t\tLast_Name, MD5_Hex_Password, Status, Version_Nbr);\r\ntb_AddTable(\"DB_User\", 100, 100, columnArray);\r\n\r\n//ROLE\r\nvar Role_WID \t= new Array(PRIMARY_EKY_MARK, \"Role_WID\", \"number\", \"-\", \"-\", \"-\", \"-\");\r\nvar Role_Name \t= new Array(\"-\", \"Role_Name\", \"varchar2\", \"32\", \"-\", \"-\", \"-\");\r\nvar Version_Nbr = new Array(\"-\", \"Version_Nbr\", \"number\", \"3\", \"-\", \"-\", \"-\");\r\n");
      out.write("var columnArray1 = new Array(Role_WID, Role_Name, Version_Nbr);\r\ntb_AddTable(\"Role\", 150, 450, columnArray1);\r\n\r\n//DB_User_Role\r\nvar User_WID \t= new Array(PRIMARY_EKY_MARK, \"ABC\", \"number\", \"-\", \"-\", \"-\", \"-\");\r\nvar Role_WID \t= new Array(\"-\", \"XYZ\", \"number\", \"-\", \"-\", \"-\", \"-\");\r\nvar Version_Nbr = new Array(\"-\", \"Version_Nbr\", \"number\", \"3\", \"-\", \"-\", \"-\");\r\nvar columnArray1 = new Array(User_WID, Role_WID, Version_Nbr);\r\ntb_AddTable(\"DB_User_Role\", 400, 200, columnArray1);\r\n\r\n//addRelationship(\"DB_User\", \"DB_User_Role\");\r\n//addRelationship(\"Role\", \"DB_User_Role\");\r\n*/\r\n");
      out.write("</script>\r\n\r\n");
      out.write("</body>\r\n\r\n");
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
