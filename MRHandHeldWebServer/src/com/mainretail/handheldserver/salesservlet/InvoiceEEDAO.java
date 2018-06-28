package com.mainretail.handheldserver.salesservlet;

import java.sql.SQLException;

import com.mainretail.handheld.sales.Invoice;

public interface InvoiceEEDAO {
	
	public boolean save(Invoice invoice)  throws SQLException;
	public void getNewSaleCode(Invoice invoice) throws SQLException; 

}
