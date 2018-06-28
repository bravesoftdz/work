package com.mainretail.handheldserver.purchaseservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.purchase.Request;
import com.mainretail.handheld.purchase.RequestService;
import com.mainretail.handheldserver.ModelEEDAO;
import com.mainretail.handheldserver.ModelEEDAOFactory;
import com.mainretail.handheldserver.util.ParentServlet;

public class SVLRequestInsert extends ParentServlet {

	private static final long serialVersionUID = -5472282879771360547L;
	
	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException {
	boolean retValue = super.processRequest(request,response);
	
	if (!retValue)
	{
		return retValue;
	}
	
	try {
		Vector vector = RequestService.queryStringToVector(getParametros());
		Model modeltemp;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();){
				
			Request myrequest = (Request) en.nextElement();
			modeltemp = searchBarcode(myrequest.model.barcode);
			
			if (modeltemp.idmodel != 0) {
				myrequest.model = modeltemp;
			} 
				
			saveRequest(myrequest);
		}
			
		vector = null;
			
		response.setStatus(HttpServletResponse.SC_OK);
		retValue = true;
	} catch (Exception e) {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
	}
	
		return retValue;  	
	}
	
	private void saveRequest( Request myrequest) throws SQLException {
		RequestEEDAO dao = RequestEEDAOFactory.getRequestDAO(RequestEEDAOFactory.DATABASE_SLQSERVER);
		dao.save(myrequest);
	}
	
	private Model searchBarcode( String barcode) throws SQLException {

		ModelEEDAO dao = ModelEEDAOFactory.getProductDAO(ModelEEDAOFactory.DATABASE_SLQSERVER);

		return dao.findByBarCode(barcode);
	}

}
