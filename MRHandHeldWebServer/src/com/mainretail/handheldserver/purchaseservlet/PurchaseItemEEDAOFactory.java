package com.mainretail.handheldserver.purchaseservlet;

public class PurchaseItemEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static PurchaseItemEEDAO getPurchaseItemDAO(int databaseType) {

		PurchaseItemEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = PurchaseItemEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}

}
