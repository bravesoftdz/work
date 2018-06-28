package com.mainretail.handheldserver.purchaseservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mainretail.handheld.purchase.*;

import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLSearchPO extends ParentServlet {
	
	private static final long serialVersionUID = -5775256235990590296L;

	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
		ServletException, IOException {
		boolean retValue = super.processRequest(request,response);	
		
		if (!retValue)
		{
			return retValue;
		}
		
		
		if (!getHashParametros().containsKey("PO.idpo")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid PO Number.");
			return false;
		}

		try {
			
			Vector vetPOItem = new Vector();
			
			PO po = POService.toPO(getHashParametros());
					
			po = getPo(po.idpo);
			
			if (po.idpo == 0) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "PONumber does not exists");
				retValue = false;
			} else {
				vetPOItem = getPoItem(String.valueOf(po.idpo));	
				
				Hashtable ht = POService.toHashtable(po);
				ht = Util.joinHashtables(ht, POItemService.vectorToHashtable(vetPOItem));
				
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
	
	private Vector getPoItem( String ponumber) throws SQLException {
		POItemEEDAO dao = POItemEEDAOFactory.getPOItemDAO(POItemEEDAOFactory.DATABASE_SLQSERVER);
		return dao.getPoItems(ponumber);
	}
	
	private PO getPo( int idpo) throws SQLException {
		POEEDAO dao = POEEDAOFactory.getPODAO(POEEDAOFactory.DATABASE_SLQSERVER);
		return dao.getPo(idpo);
	}

}
