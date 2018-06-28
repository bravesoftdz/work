package com.mainretail.handheldserver;

public class ModelEEDAOFactory {

	public static final int DATABASE_ORACLE = 1;

	public static final int DATABASE_SLQSERVER = 2;

	public static ModelEEDAO getProductDAO(int databaseType) {

		ModelEEDAO dao = null;

		switch (databaseType) {

		case DATABASE_SLQSERVER: {

			dao = ModelEEDAOMSSQL.getInstance();
			break;
		}
		case DATABASE_ORACLE: {
			break;

		}

		}

		return dao;
	}

}