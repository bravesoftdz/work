package com.mainretail.handheldserver.inventoryservlet;

public class BarcodePrintEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static BarcodePrintEEDAO getBarcodePrintDAO(int databaseType) {

		BarcodePrintEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = BarcodePrintEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}

}
