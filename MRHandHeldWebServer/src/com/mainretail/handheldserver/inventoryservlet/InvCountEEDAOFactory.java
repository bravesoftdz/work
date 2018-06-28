package com.mainretail.handheldserver.inventoryservlet;

public class InvCountEEDAOFactory {

	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static InvCountEEDAO getInvCountDAO(int databaseType) {

		InvCountEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = InvCountEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}
}