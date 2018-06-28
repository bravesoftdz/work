package com.mainretail.handheldserver.purchaseservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.BarcodeService;
import com.mainretail.handheld.ModelVerifyQtyService;
import com.mainretail.handheld.purchase.Purchase;
import com.mainretail.handheld.purchase.PurchaseService;
import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLValidateReceiving extends ParentServlet {

	private static final long serialVersionUID = -4550659332115376021L;
	
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
			
			Vector vetVerifyQty = new Vector();
			Vector vetBarcode   = new Vector();
			
			Purchase purchase = PurchaseService.toPurchase(getHashParametros());
					
			purchase = getPurchase("DocumentNumber",purchase.documentnumber);
			
			if (purchase.idpurchase == 0) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "DocumentNumber does not exists");
				retValue = false;
			} else if (purchase.datefinalreceiving != null) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Purchase had Final Receiving");
				retValue = false; 	
			} else {
				vetVerifyQty = getVerifyQty(purchase.idpurchase);
				vetBarcode   = getBarcode(purchase.idpurchase);
				
				Hashtable ht = PurchaseService.toHashtable(purchase);
				Hashtable ht2 = ModelVerifyQtyService.vectorToHashtable(vetVerifyQty); 
				
				ht = Util.joinHashtables(ht, ht2);
				ht = Util.joinHashtables(ht, BarcodeService.vectorToHashtable(vetBarcode));
				
				response.setStatus(HttpServletResponse.SC_OK);
				String qry = Util.hashtableToQuery(ht);
				response.getWriter().print(qry);
				System.out.println(qry);
				qry = null;
				ht = null;
				ht2 = null;
				System.gc();
				retValue = true;
			}
		} catch (Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
			e.printStackTrace();
		}
		
		return retValue;  	
	}
	
	private Vector getVerifyQty(int idpurchase) throws SQLException {
		PurchaseItemEEDAO dao = PurchaseItemEEDAOFactory.getPurchaseItemDAO(PurchaseItemEEDAOFactory.DATABASE_SLQSERVER);
		return dao.getVerifyQty(idpurchase);
	}
	
	private Vector getBarcode(int idpurchase) throws SQLException {
		PurchaseItemEEDAO dao = PurchaseItemEEDAOFactory.getPurchaseItemDAO(PurchaseItemEEDAOFactory.DATABASE_SLQSERVER);
		return dao.getBarcode(idpurchase);
	}
	
	private Purchase getPurchase(String field, String value) throws SQLException {
		PurchaseEEDAO dao = PurchaseEEDAOFactory.getPurchaseDAO(PurchaseEEDAOFactory.DATABASE_SLQSERVER);
		return dao.getPurchase(field, value);
	}

}
