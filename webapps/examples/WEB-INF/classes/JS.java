/* $Id: HelloWorldExample.java,v 1.2 2001/11/29 18:27:25 remm Exp $
 *
 */

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * The simplest possible servlet.
 *
 * @author James Duncan Davidson
 */

public class JS extends HttpServlet {


    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws IOException, ServletException
    {
        ResourceBundle rb =
            ResourceBundle.getBundle("LocalStrings",request.getLocale());
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


		out.println("function test(abc) {");
		out.println("	alert(abc);");
		out.println("}");

    }
}



