package com.mainretail.handheldserver.util;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.http.*;


import com.mainretail.util.Util;


public class ParentServlet extends HttpServlet {
	
	private static final long serialVersionUID = 5754176332564150773L;
	
	private String parametros;
	
	private Hashtable hashParametros;
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws
	IOException, ServletException {
		
		parametros = request.getQueryString();
		
		processRequest(request, response);
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws
	IOException, ServletException  {
		
		DataInputStream in =  new DataInputStream((InputStream)request.getInputStream());
		
		parametros = in.readUTF();
		
		processRequest(request, response);
		
	}
	
	
	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException {
		boolean retValue = true;
		hashParametros = Util.queryToHashtable(parametros);
		/*
		 if (!request.getHeader("user-agent").equals("MainRetail-J2ME"))
		 {
		 response.setStatus(HttpServletResponse.SC_FORBIDDEN);
		 retValue = false;
		 }
		 */
		
		//Gerenciamento de sessao
		HttpSession session = request.getSession(true);
		if (session.isNew()) {
			response.setHeader("cookie", "JSESSIONID=" + session.getId());
		}
		
		displayHttpRequest(request);
		
		return retValue;	
	}
	
	
	public void displayHttpRequest(HttpServletRequest request) throws IOException  {
		
		int cont = 0;
		
		System.out.println("----------------- headers");
		Enumeration headerNames= request.getHeaderNames();
		
		while (headerNames.hasMoreElements()) {
			String headerName= (String)headerNames.nextElement() ;
			System.out.println(headerName+":"+ request.getHeader(headerName));
		}  
		
		System.out.println("----------------- parameters");
		Enumeration names = hashParametros.keys();
		
		while (names.hasMoreElements()){  
			String name = (String)names.nextElement() ;
			System.out.println(name + " : " + (String)hashParametros.get(name));
			cont++;
		}
		
		System.out.println("-----------------");
	}
	
	public String getParametros() {
		return parametros;
	}

	public Hashtable getHashParametros() {
		return hashParametros;
	}

	
	/*User user = new User();
	 
	 System.out.println(request.getParameter("pw"));
	 if (request.getParameter("pw") == null){
	 response.getWriter().print("Informação inválida.");
	 return;
	 
	 }
	 user.pw = request.getParameter("pw");
	 
	 User findUser  = null;
	 
	 try {
	 findUser = verifyUser(user.pw);
	 response.setStatus(HttpServletResponse.SC_BAD_REQUEST,"Codigo do produto inexistente");
	 } catch (Exception e) {
	 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR ,e.getMessage());
	 }*/
	
}
