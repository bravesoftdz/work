package com.mainretail.handheldserver;

import java.sql.*;
import java.util.Hashtable;

import javax.servlet.http.*;

import java.io.*;
import javax.servlet.*;

import com.mainretail.handheld.ParameterList;
import com.mainretail.handheld.ParameterListService;
import com.mainretail.handheld.User;
import com.mainretail.handheld.UserService;
import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLGetUser extends ParentServlet {

	private static final long serialVersionUID = 3551088533651723798L;

	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
		ServletException, IOException {
		
				
		boolean retValue = super.processRequest(request,response);
		
		if (!retValue)
		{
			return retValue;
		}
         //*
		if (!getHashParametros().containsKey("U.pw")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Password.");
			return false;
		}
        // */
		
		User user = UserService.toUser(getHashParametros());
		// em teste
		//user.pw = request.getParameter("U.pw");
		
		try {
			User findUser = getUser(user.pw);
			
			if (findUser.iduser == 0) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid User");
			} else {
				response.setStatus(HttpServletResponse.SC_OK);
				Hashtable htUser = UserService.toHashtable(findUser);
				Hashtable htParams = ParameterListService.parameterListToHashtable(getParameterList());
				Hashtable ht = Util.joinHashtables(htUser, htParams);
				htUser = null;
				htParams = null;
				response.getWriter().print(Util.hashtableToQuery(ht));
				retValue = true;
			}
				
		} catch (Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
 		}

	    return retValue;  	
    }
	
	private ParameterList getParameterList() throws SQLException {
		ParameterListEEDAO dao = ParameterListEEDAOFactory.getParameterListDAO(UserEEDAOFactory.DATABASE_SLQSERVER);	
		return dao.getParameterList();
	}
	
	private User getUser( String password) throws SQLException {

		UserEEDAO dao = UserEEDAOFactory.getUserDAO(UserEEDAOFactory.DATABASE_SLQSERVER);

		return dao.findUser(password);
	}
	
}