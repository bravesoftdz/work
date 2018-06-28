package com.mainretail.handheldserver.salesservlet;

public class PreSaleItemEEDAOFactory {
	public static final int DATABASE_ORACLE = 1;

	public static final int DATABASE_SLQSERVER = 2;

	public static PreSaleItemEEDAO getPreSaleItemDAO(int databaseType) {

		PreSaleItemEEDAO dao = null;

		switch (databaseType) {

		case DATABASE_SLQSERVER: {

			dao = PreSaleItemEEDAOMSSQL.getInstance();
			break;
		}
		case DATABASE_ORACLE: {
			break;

		}

		}

		return dao;
	}
}
