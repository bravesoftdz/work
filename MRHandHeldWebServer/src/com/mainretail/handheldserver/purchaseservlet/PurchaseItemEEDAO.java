package com.mainretail.handheldserver.purchaseservlet;

import java.sql.SQLException;
import java.util.Vector;

import com.mainretail.handheld.purchase.PurchaseItem;

public interface PurchaseItemEEDAO {

	public void save(PurchaseItem purchaseitem)  throws SQLException;
	public Vector getPurchaseItem(int idpurchase) throws SQLException;
	public Vector getVerifyQty(int idpurchase) throws SQLException;
	public Vector getBarcode(int idpurchase) throws SQLException;
	public Vector getResultVerifyQty(int idpurchase, Vector verBarcodeVerifyQty) throws SQLException;
}
