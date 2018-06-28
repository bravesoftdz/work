package com.mainretail.handheldserver.purchaseservlet;

public class POItemEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static POItemEEDAO getPOItemDAO(int databaseType) {

		POItemEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = POItemEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}

}
