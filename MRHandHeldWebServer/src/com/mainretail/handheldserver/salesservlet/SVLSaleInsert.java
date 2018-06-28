package com.mainretail.handheldserver.salesservlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mainretail.handheld.sales.Invoice;
import com.mainretail.handheld.sales.InvoiceService;
import com.mainretail.handheld.sales.PreSaleItem;
import com.mainretail.handheld.sales.PreSaleItemService;
import com.mainretail.handheldserver.util.ParentServlet;
import com.mainretail.util.Util;

public class SVLSaleInsert extends ParentServlet {
	
	private static final long serialVersionUID = 1174793925253796890L;

	public boolean processRequest(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException {
		boolean retValue = super.processRequest(request,response);	
	
		if (!retValue)
		{
			return retValue;
		}
	
			
		try {
			Invoice invoice = InvoiceService.toInvoice(getHashParametros());
			//em teste
			//Invoice invoice = InvoiceService.toInvoice(Util.queryToHashtable(request.getQueryString()));
									
			if (!saveInvoice(invoice)) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Create Invoice Error");
				retValue = false;
			} else {
				
				//Vector vector = PreSaleItemService.queryStringToVector(request.getQueryString());
				Vector vector = PreSaleItemService.queryStringToVector(getParametros());
				
				for (Enumeration en = vector.elements(); en.hasMoreElements();){
					
					PreSaleItem presaleitem = (PreSaleItem) en.nextElement();
					presaleitem.idpresale = invoice.idpresale;
					savePreSaleItem(presaleitem);
				}
				
				vector = null;
								
				Hashtable ht = InvoiceService.toHashtable(invoice);
								
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

	private boolean saveInvoice(Invoice invoice) throws SQLException {
		InvoiceEEDAO dao = InvoiceEEDAOFactory.getInvoiceDAO(InvoiceEEDAOFactory.DATABASE_SLQSERVER);
	    return dao.save(invoice);
	}

	private void savePreSaleItem(PreSaleItem presaleitem) throws SQLException {
		PreSaleItemEEDAO dao = PreSaleItemEEDAOFactory.getPreSaleItemDAO(PreSaleItemEEDAOFactory.DATABASE_SLQSERVER);
	    dao.save(presaleitem);
	}

}
