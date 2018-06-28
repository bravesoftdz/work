package com.mainretail.handheldserver.inventoryservlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.BarcodeService;
import com.mainretail.handheld.Model;
import com.mainretail.handheldserver.BarcodeEEDAO;
import com.mainretail.handheldserver.BarcodeEEDAOFactory;
import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLNewSearchBarcode extends ParentServlet {
	
	private static final long serialVersionUID = 3368838439097543546L;

		public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
		ServletException, IOException {
		
		boolean retValue = super.processRequest(request,response);
		
		if (!retValue)
		{
			return retValue;
		}
	
		if (!getHashParametros().containsKey("B.barcode")){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid barcode.");
			return false;
		}
	
		Barcode barcode = BarcodeService.toBarcode(getHashParametros());	
		barcode.model = new Model();
				
		try {
			searchBarcode(barcode);
			if (barcode.model.idmodel == 0) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Barcode does not exists");
			} else {
				response.setStatus(HttpServletResponse.SC_OK);
				
				
				response.getWriter().print(Util.hashtableToQuery(BarcodeService.toHashtable(barcode)));
				retValue = true;
			}
				
		} catch (Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
			}
	
	    return retValue;  	
	}
	
	private Barcode searchBarcode( Barcode barcode) throws SQLException {
	
		BarcodeEEDAO dao = BarcodeEEDAOFactory.getBarcodeDAO(BarcodeEEDAOFactory.DATABASE_SLQSERVER);
	
		return dao.searchBarcode(barcode);
	}

}
