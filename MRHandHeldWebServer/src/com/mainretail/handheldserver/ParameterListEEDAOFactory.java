package com.mainretail.handheldserver;

public class ParameterListEEDAOFactory {
	
	public static final int DATABASE_ORACLE = 1;
	public static final int DATABASE_SLQSERVER = 2;

	public static ParameterListEEDAO getParameterListDAO(int databaseType) {

		ParameterListEEDAO dao = null;

		switch (databaseType) {
			case DATABASE_SLQSERVER: {
				dao = ParameterListEEDAOMSSQL.getInstance(); 
				break;
			}
			case DATABASE_ORACLE: {
				break;
			}
		}
		
		return dao;
	}
}
