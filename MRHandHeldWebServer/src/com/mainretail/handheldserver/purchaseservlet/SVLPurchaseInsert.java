package com.mainretail.handheldserver.purchaseservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.purchase.*;

import com.mainretail.handheldserver.BarcodeEEDAO;
import com.mainretail.handheldserver.BarcodeEEDAOFactory;
import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLPurchaseInsert extends ParentServlet {
	
	private static final long serialVersionUID = 3670805540366220816L;

	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException {
	boolean retValue = super.processRequest(request,response);
	
	if (!retValue)
	{
		return retValue;
	}
	
	if (!getHashParametros().containsKey("PU.vendor.usercode")){
		response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Vendor.");
		return false;
	}

	if (!getHashParametros().containsKey("PU.idstore")){
		response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Store.");
		return false;
	}
	
	if (!getHashParametros().containsKey("PU.iduserprereceiving")){
		response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid User.");
		return false;
	}
	
	if (!getHashParametros().containsKey("PU.documentnumber")){
		response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid User.");
		return false;
	}
	
	try {
		Purchase purchase = PurchaseService.toPurchase(getHashParametros());
		
		int idpurchase = savePurchase(purchase);
		purchase.idpurchase = idpurchase;
		
		if (idpurchase != -1) {
			
			Vector vector = PurchaseItemService.queryStringToVector(getParametros());
			Vector vectorError = new Vector();
			Barcode barcode = new Barcode();
			
			for (Enumeration en = vector.elements(); en.hasMoreElements();){
				
				PurchaseItem purchaseitem = (PurchaseItem) en.nextElement();
				
				// PurchaseItem Express.
				if (purchaseitem.model.idmodel == 0 ) {
					
					barcode = searchBarcode(purchaseitem.model.barcode);
					purchaseitem.model = barcode.model;
					
					purchaseitem.newcostprice = barcode.model.vendorcost;
					purchaseitem.newsaleprice = barcode.model.sellingprice;
					purchaseitem.newsuggretail = barcode.model.suggretail;
					
					if (purchaseitem.model.idmodel != 0 ) {
						savePurchaseItem(purchaseitem,purchase);
					} else {
						vectorError.addElement(purchaseitem);
					}
				} else {
					savePurchaseItem(purchaseitem,purchase);
				}
			}
			
			if (runPurchaseDo(idpurchase)) {
				
				vector = null;
				
				response.setStatus(HttpServletResponse.SC_OK);
				
				if (!vectorError.isEmpty()) {
					Hashtable ht = PurchaseItemService.vectorToHashtable(vectorError);
					response.getWriter().print(Util.hashtableToQuery(ht));
				}
				
				retValue = true;
			} else {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "PurhaseDo Error.");
				retValue = false;
			}
			
		} else {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Vendor.");
			retValue = false;
		}
		
	} catch (Exception e) {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
	}
	
	return retValue;  	
}
	private int savePurchase( Purchase purchase) throws SQLException {
	
		int idpurchase = -1;
		
		PurchaseEEDAO dao = PurchaseEEDAOFactory.getPurchaseDAO(PurchaseEEDAOFactory.DATABASE_SLQSERVER);
		idpurchase = dao.save(purchase);
		return idpurchase;
	}
	
	private boolean runPurchaseDo(int idpurhase) throws SQLException {
		
		PurchaseEEDAO dao = PurchaseEEDAOFactory.getPurchaseDAO(PurchaseEEDAOFactory.DATABASE_SLQSERVER);
		return dao.runPurchaseDo(idpurhase);
	}
	
	private void savePurchaseItem( PurchaseItem purchaseitem, Purchase purchase) throws SQLException {
		
		purchaseitem.idpurchase = purchase.idpurchase;
		purchaseitem.vendor = purchase.vendor;
		
		PurchaseItemEEDAO dao = PurchaseItemEEDAOFactory.getPurchaseItemDAO(PurchaseItemEEDAOFactory.DATABASE_SLQSERVER);
		dao.save(purchaseitem);
	}
	
	private Barcode searchBarcode( String barcode) throws SQLException {
		
		BarcodeEEDAO dao = BarcodeEEDAOFactory.getBarcodeDAO(BarcodeEEDAOFactory.DATABASE_SLQSERVER);
		return dao.searchBarcode(barcode);
	}

}
