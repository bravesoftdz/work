package com.mainretail.handheldserver.inventoryservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.inventory.BarcodePrint;
import com.mainretail.handheld.inventory.BarcodePrintService;
import com.mainretail.handheldserver.BarcodeEEDAO;
import com.mainretail.handheldserver.BarcodeEEDAOFactory;
import com.mainretail.handheldserver.util.ParentServlet;

public class SVLBarcodePrintInsert extends ParentServlet {

	private static final long serialVersionUID = -1555128846144009443L;
	
	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException {
	boolean retValue = super.processRequest(request,response);
	
	if (!retValue)
	{
		return retValue;
	}
	
	try {
		Vector vector = BarcodePrintService.queryStringToVector(getParametros());
				
		for (Enumeration en = vector.elements(); en.hasMoreElements();){
				
			BarcodePrint barcodeprint = (BarcodePrint) en.nextElement();
			saveBarcodePrint(barcodeprint);
		}
			
		vector = null;
			
		response.setStatus(HttpServletResponse.SC_OK);
		retValue = true;
	} catch (Exception e) {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
	}
	
		return retValue;  	
	}
	
	private void saveBarcodePrint( BarcodePrint barcodeprint) throws SQLException {
		BarcodeEEDAO barcodeDao = BarcodeEEDAOFactory.getBarcodeDAO(BarcodePrintEEDAOFactory.DATABASE_SLQSERVER);
		barcodeprint.barcode = barcodeDao.searchBarcode(barcodeprint.barcode);
		
		BarcodePrintEEDAO dao = BarcodePrintEEDAOFactory.getBarcodePrintDAO(BarcodePrintEEDAOFactory.DATABASE_SLQSERVER);
		dao.save(barcodeprint);
	}
	
}
