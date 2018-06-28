package com.mainretail.handheldserver.purchaseservlet;

import java.sql.SQLException;
import java.util.Vector;

import com.mainretail.handheld.purchase.POItem;

public interface POItemEEDAO {
	
	public Vector getPoItems(String ponumber) throws SQLException;
	public void save(POItem poitem) throws SQLException;
	
}
