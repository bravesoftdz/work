package com.mainretail.handheldserver.purchaseservlet;

public class POEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static POEEDAO getPODAO(int databaseType) {

		POEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = POEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}

}