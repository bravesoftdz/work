package com.mainretail.handheldserver;

public class UserEEDAOFactory {

	public static final int DATABASE_ORACLE = 1;

	public static final int DATABASE_SLQSERVER = 2;

	public static UserEEDAO getUserDAO(int databaseType) {

		UserEEDAO dao = null;

		switch (databaseType) {

		case DATABASE_SLQSERVER: {

			dao = new UserEEDAOMSSQL();
			break;
		}
		case DATABASE_ORACLE: {

		}

		}

		return dao;
	}

}
