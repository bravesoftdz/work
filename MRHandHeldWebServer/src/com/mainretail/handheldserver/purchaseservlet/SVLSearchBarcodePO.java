package com.mainretail.handheldserver.purchaseservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.handheldserver.ModelEEDAO;
import com.mainretail.handheldserver.ModelEEDAOFactory;
import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLSearchBarcodePO extends ParentServlet {

	
	private static final long serialVersionUID = 7440316702170620556L;
	
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
		
		//Model model = ModelService.toModel(Util.queryToHashtable(request.getQueryString()));
		Model model = ModelService.toModel(getHashParametros());
				
		try {
			
			model = searchBarcode(model.barcode);
						
			if (model.idmodel == 0) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Barcode does not exists");
			} else {
				
				
				boolean existsmodel = verifiesExistsModelPO(model);
				Boolean var = new Boolean(existsmodel);
					
				response.setStatus(HttpServletResponse.SC_OK);
				
				Hashtable ht = ModelService.toHashtable(model);
				ht.put("modelexists", var);
				response.getWriter().print(Util.hashtableToQuery(ht));
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
	
	private boolean  verifiesExistsModelPO(Model model) throws SQLException {

		POEEDAO dao = POEEDAOFactory.getPODAO(POEEDAOFactory.DATABASE_SLQSERVER);

		return dao.verifiesExistsModelPO(model);
	}

}
