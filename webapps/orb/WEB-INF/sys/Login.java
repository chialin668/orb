package com.orb.sys;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Login extends HttpServlet {

	private String username;
	private String password;


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		username = request.getParameter("username");
		password = request.getParameter("password");

		if (username == null || password == null) {
			out.println("username or password should NOT be empty!!");

		} else if (!(username.equals("su") && password.equals("dna"))) {
			out.println("login incorrect!!");

		} else if ((username.equals("su") && password.equals("dna"))) {
			out.println("login correct!!");

		}

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);

	}









}