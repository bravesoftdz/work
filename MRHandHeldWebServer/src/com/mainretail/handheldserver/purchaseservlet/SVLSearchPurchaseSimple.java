package com.mainretail.handheldserver.purchaseservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mainretail.handheld.purchase.*;

import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLSearchPurchaseSimple extends ParentServlet {
	
	private static final long serialVersionUID = -5775256235990590296L;

	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
		ServletException, IOException {
		boolean retValue = super.processRequest(request,response);	
		
		if (!retValue)
		{
			return retValue;
		}
		
		
		if (!getHashParametros().containsKey("PU.documentnumber")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Document Number.");
			return false;
		}

		try {
			
			Purchase purchase = PurchaseService.toPurchase(getHashParametros());
			
			purchase = getPurchase("DocumentNumber",purchase.documentnumber);
			
			if (purchase.idpurchase == 0) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "DocumentNumber does not exists");
				retValue = false;
			} else if (purchase.datefinalreceiving != null) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Purchase had Final Receiving");
				retValue = false; 	
			} else {
								
				Hashtable ht = PurchaseService.toHashtable(purchase);
								
				response.setStatus(HttpServletResponse.SC_OK);
				
				response.getWriter().print(Util.hashtableToQuery(ht));
				retValue = true;
			}
		} catch (Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
			e.printStackTrace();
		}
		
		return retValue;  	
	}
	
	private Purchase getPurchase(String field, String value) throws SQLException {
		PurchaseEEDAO dao = PurchaseEEDAOFactory.getPurchaseDAO(PurchaseEEDAOFactory.DATABASE_SLQSERVER);
		return dao.getPurchase(field, value);
	}

}