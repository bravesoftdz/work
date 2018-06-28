package com.mainretail.handheldserver.inventoryservlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.inventory.InvCount;
import com.mainretail.handheld.inventory.InvCountService;
import com.mainretail.handheldserver.util.*;
import com.mainretail.util.Util;

public class SVLCounteredExist extends ParentServlet {

	private static final long serialVersionUID = 3520228949611794766L;

	public SVLCounteredExist() {
		super();
	}
	
	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
		ServletException, IOException {
		
		boolean retValue = super.processRequest(request,response);
		if (!retValue)
		{
			return retValue;
		}		
		
		if (!getHashParametros().containsKey("IC.idstore")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid store number.");
			return false;
		}
		
		if (!getHashParametros().containsKey("IC.counttype")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid inventory count type.");
			return false;
		}
		
		
		
		InvCount invcount = InvCountService.toInvCount(getHashParametros());
			
		
		try {
			if (invcount.counttype == -1) {
				response.setStatus(HttpServletResponse.SC_OK);
				response.getWriter().print(Util.hashtableToQuery(InvCountService.toHashtable(invcount)));
				retValue = true;
			} else {
				invcount = findInvCount(invcount.idstore, invcount.counttype);
				
				if (invcount.idcount == 0) {
					response.sendError(HttpServletResponse.SC_BAD_REQUEST, "There is no open count for this type");
				} else {
					response.setStatus(HttpServletResponse.SC_OK);
					response.getWriter().print(Util.hashtableToQuery(InvCountService.toHashtable(invcount)));
					retValue = true;
				}		
			}
		} catch (Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
 		}

		return retValue;  	
	}

	private InvCount findInvCount(int idstore, int counttype) throws SQLException {

		InvCountEEDAO dao = InvCountEEDAOFactory.getInvCountDAO(InvCountEEDAOFactory.DATABASE_SLQSERVER);		
		return dao.find(idstore, counttype);
	}
}