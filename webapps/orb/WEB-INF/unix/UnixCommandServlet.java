package com.orb.unix;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;



public class UnixCommandServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
					throws ServletException, IOException {

		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();

		//
		String command = request.getParameter("command");
		String machine = request.getParameter("sid");

		ServerInfo si = new ServerInfo();
		si.init();
		Server s = si.getServerBySid(machine);

		UnixCommand tt = new UnixCommand(s.getMachine(),
											s.getUsername(),
											s.getPassword());
		tt.connect();
		tt.run(command);
		if (tt.getStatus().equals("0")) {
			out.println(tt.getResult());

		}
	}
}