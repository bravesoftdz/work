package com.mainretail.handheldserver.inventoryservlet;

public class InvMovEEDAOFactory {

	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static InvMovEEDAO getInvMovDAO(int databaseType) {

		InvMovEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = InvMovEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}
}
