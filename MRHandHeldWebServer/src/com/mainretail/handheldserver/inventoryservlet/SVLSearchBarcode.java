package com.mainretail.handheldserver.inventoryservlet;


import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.handheldserver.ModelEEDAO;
import com.mainretail.handheldserver.ModelEEDAOFactory;
import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLSearchBarcode extends ParentServlet {

		
	private static final long serialVersionUID = -3191183779470403859L;

	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
		ServletException, IOException {
		
		boolean retValue = super.processRequest(request,response);
		
		if (!retValue)
		{
			return retValue;
		}

		if (!getHashParametros().containsKey("M.barcode")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid barcode.");
			return false;
		}

		Model product = ModelService.toModel(getHashParametros());		
		
		try {
			Model findProduct = searchBarcode(product.barcode);
			if (findProduct.idmodel == 0) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Barcode does not exists");
			} else {
				response.setStatus(HttpServletResponse.SC_OK);
				
				
				response.getWriter().print(Util.hashtableToQuery(ModelService.toHashtable(findProduct)));
				retValue = true;
			}
				
		} catch (Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
 		}

	    return retValue;  	
    }
	
	private Model  searchBarcode( String barcode) throws SQLException {

		ModelEEDAO dao = ModelEEDAOFactory.getProductDAO(ModelEEDAOFactory.DATABASE_SLQSERVER);

		return dao.findByBarCode(barcode);
	}
  
	
}