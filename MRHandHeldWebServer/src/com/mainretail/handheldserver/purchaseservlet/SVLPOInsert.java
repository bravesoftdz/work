package com.mainretail.handheldserver.purchaseservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.purchase.*;
import com.mainretail.handheldserver.BarcodeEEDAO;
import com.mainretail.handheldserver.BarcodeEEDAOFactory;
import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLPOInsert extends ParentServlet {

	private static final long serialVersionUID = -5069042273832694507L;
	
	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException {
	boolean retValue = super.processRequest(request,response);
	
	if (!retValue)
	{
		return retValue;
	}

	
	try {
		PO po = POService.toPO(getHashParametros());
		
		if (savePO(po)) {
			Vector vector = POItemService.queryStringToVector(getParametros());
			Vector vectorError = new Vector();
			Barcode barcode = new Barcode();
			
			for (Enumeration en = vector.elements(); en.hasMoreElements();){
				
				POItem poitem = (POItem) en.nextElement();
				
				// POItem Express.
				if (poitem.model.idmodel == 0 ) {
					
					barcode = searchBarcode(poitem.model.barcode);
					poitem.model = barcode.model;
					poitem.costprice = barcode.model.vendorcost;
					poitem.saleprice = barcode.model.sellingprice;
					poitem.suggretail = barcode.model.suggretail;
					
					if (poitem.model.idmodel != 0 ) {
						savePOItem(poitem,po);
					} else {
						vectorError.addElement(poitem);
					}
				} else { 
					savePOItem(poitem,po);
				}
				
			}
			
			vector = null;
			
			response.setStatus(HttpServletResponse.SC_OK);
			
			if (!vectorError.isEmpty()) {
				Hashtable ht = POItemService.vectorToHashtable(vectorError);
				response.getWriter().print(Util.hashtableToQuery(ht));
			}
			
			retValue = true;
			
		} else {
			if (po.idpo == -1) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Vendor.");
				retValue = false;
			}
		}
		
	} catch (Exception e) {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
	}
	
	return retValue;  	
	}
	
	private boolean savePO( PO po) throws SQLException {
	
		POEEDAO dao = POEEDAOFactory.getPODAO(POEEDAOFactory.DATABASE_SLQSERVER);
		return dao.save(po);
	}
	
	private void savePOItem( POItem poitem, PO po) throws SQLException {
		
		poitem.documentid = po.idpo;
		poitem.movdate = po.datapedido;
		poitem.dateestimatedmov = po.estarrival;
		poitem.storeid = po.idstore;
		poitem.idpessoa = po.vendor.idpessoa;
		
		POItemEEDAO dao = POItemEEDAOFactory.getPOItemDAO(POItemEEDAOFactory.DATABASE_SLQSERVER);
		dao.save(poitem);
	}
	
	private Barcode searchBarcode( String barcode) throws SQLException {
		
		BarcodeEEDAO dao = BarcodeEEDAOFactory.getBarcodeDAO(BarcodeEEDAOFactory.DATABASE_SLQSERVER);
	
		return dao.searchBarcode(barcode);
	}
	
}
