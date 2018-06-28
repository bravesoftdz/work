package com.mainretail.handheldserver.salesservlet;


public class InvoiceEEDAOFactory {
	public static final int DATABASE_ORACLE = 1;

	public static final int DATABASE_SLQSERVER = 2;

	public static InvoiceEEDAO getInvoiceDAO(int databaseType) {

		InvoiceEEDAO dao = null;

		switch (databaseType) {

		case DATABASE_SLQSERVER: {

			dao = InvoiceEEDAOMSSQL.getInstance();
			break;
		}
		case DATABASE_ORACLE: {
			break;

		}

		}

		return dao;
	}
}
