package com.mainretail.handheldserver.salesservlet;

import java.sql.SQLException;

import com.mainretail.handheld.sales.PreSaleItem;

public interface PreSaleItemEEDAO {	
	
	public void save(PreSaleItem presaleitem)  throws SQLException;

}
