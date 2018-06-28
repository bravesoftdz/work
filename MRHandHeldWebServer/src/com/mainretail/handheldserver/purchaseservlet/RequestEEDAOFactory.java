package com.mainretail.handheldserver.purchaseservlet;

public class RequestEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static RequestEEDAO getRequestDAO(int databaseType) {

		RequestEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = RequestEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}

}
