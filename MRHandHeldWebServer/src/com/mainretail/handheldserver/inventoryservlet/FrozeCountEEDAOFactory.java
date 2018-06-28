package com.mainretail.handheldserver.inventoryservlet;

public class FrozeCountEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static FrozeCountEEDAO getFrozeCountDAO(int databaseType) {

		FrozeCountEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = FrozeCountEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}

}
