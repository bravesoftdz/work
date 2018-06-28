package com.mainretail.handheldserver.inventoryservlet;

public class InvCountItemEEDAOFactory {

	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static InvCountItemEEDAO getInvCountDAO(int databaseType) {

		InvCountItemEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = InvCountItemEEDAOMSSQL.getInstance();
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}
}