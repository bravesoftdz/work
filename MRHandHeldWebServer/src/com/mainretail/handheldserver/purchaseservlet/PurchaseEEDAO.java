package com.mainretail.handheldserver.purchaseservlet;

import java.sql.SQLException;

import com.mainretail.handheld.purchase.Purchase;

public interface PurchaseEEDAO {

	public int save(Purchase purchase)  throws SQLException;
	public boolean runPurchaseDo(int idpurhase)  throws SQLException;
	public Purchase getPurchase(String field, String value)  throws SQLException;
}
