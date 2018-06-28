package com.mainretail.handheldservlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class ParentServlet extends HttpServlet {
	private static final long serialVersionUID = 507252625600337751L;
	
	public static final int REQUEST_ERROR = HttpServletResponse.SC_ACCEPTED;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected abstract boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException;

}
