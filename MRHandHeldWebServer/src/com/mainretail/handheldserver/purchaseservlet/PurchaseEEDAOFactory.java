package com.mainretail.handheldserver.purchaseservlet;

public class PurchaseEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static PurchaseEEDAO getPurchaseDAO(int databaseType) {

		PurchaseEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = PurchaseEEDAOMSSQL.getInstance(); 
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}
}
