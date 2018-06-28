package com.mainretail.handheldserver.inventoryservlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.inventory.InvCountItem;
import com.mainretail.handheld.inventory.InvCountItemService;
import com.mainretail.handheldserver.util.*;



public class SVLItemCountInsert extends ParentServlet {

	private static final long serialVersionUID = -716837115862156593L;

	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
		ServletException, IOException {
		boolean retValue = super.processRequest(request,response);
		
		if (!retValue)
		{
			return retValue;
		}
        
		System.out.println(request.getQueryString());
		
		if (!getHashParametros().containsKey("ICI.barcode")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid barcode.");
			return false;
		}

		if (!getHashParametros().containsKey("ICI.iduser")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user.");
			return false;
		}

		if (!getHashParametros().containsKey("ICI.idcount")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid inventory count number.");
			return false;
		}

		if (!getHashParametros().containsKey("ICI.qty")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity.");
			return false;
		}

		if (Double.parseDouble((String)getHashParametros().get("ICI.qty")) <= 0){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantity must be positive.");
			return false;
		}
		
		//		Em teste
		InvCountItem invcountitem = InvCountItemService.toInvCountItem(getHashParametros());
		
		/*
		InvCountItem invcountitem = new InvCountItem();
		invcountitem.idcount = Integer.parseInt(request.getParameter("ICI.idcount"));
		invcountitem.barcode = request.getParameter("ICI.barcode");
		invcountitem.iduser  = Integer.parseInt(request.getParameter("ICI.iduser"));
		invcountitem.qty = Double.parseDouble(request.getParameter("ICI.qty"));
		
		
		if (request.getParameter("ICI.saleprice") != null){
			invcountitem.saleprice = Double.parseDouble(request.getParameter("ICI.saleprice"));	
		}
		*/

		try {
			saveInvCountItem(invcountitem);
			response.setStatus(HttpServletResponse.SC_OK);
			retValue = true;
		} catch (Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
		}

		return retValue;  	
	}

	private void saveInvCountItem( InvCountItem invcountitem) throws SQLException {
		InvCountItemEEDAO dao = InvCountItemEEDAOFactory.getInvCountDAO(InvCountItemEEDAOFactory.DATABASE_SLQSERVER);
		dao.save(invcountitem);
	}
}