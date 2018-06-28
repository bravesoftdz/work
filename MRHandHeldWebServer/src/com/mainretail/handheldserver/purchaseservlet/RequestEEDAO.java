package com.mainretail.handheldserver.purchaseservlet;

import java.sql.SQLException;

import com.mainretail.handheld.purchase.Request;

public interface RequestEEDAO {
	
	public boolean save(Request request) throws SQLException;

}
