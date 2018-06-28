package com.mainretail.handheldserver;

public class BarcodeEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;

	public static final int DATABASE_SLQSERVER = 2;

	public static BarcodeEEDAO getBarcodeDAO(int databaseType) {

		BarcodeEEDAO dao = null;

		switch (databaseType) {

		case DATABASE_SLQSERVER: {

			dao = BarcodeEEDAOMSSQL.getInstance();
			break;
		}
		case DATABASE_ORACLE: {
			break;

		}

		}

		return dao;
	}



}
