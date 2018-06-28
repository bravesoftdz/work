package com.mainretail.handheldserver.salesservlet;

import java.sql.*;

import com.mainretail.handheld.ParameterList;
import com.mainretail.handheld.sales.Invoice;
import com.mainretail.handheldserver.ParameterListEEDAO;
import com.mainretail.handheldserver.ParameterListEEDAOFactory;
import com.mainretail.handheldserver.util.ConnectionFunctions;
import com.mainretail.handheldserver.util.SQLFunctions;

public class InvoiceEEDAOMSSQL implements InvoiceEEDAO{
	
	private static InvoiceEEDAOMSSQL instance;
	private InvoiceEEDAOMSSQL() {}
	
	public static InvoiceEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new InvoiceEEDAOMSSQL(); 
		}
		return instance;		
	}

	public boolean save(Invoice invoice) throws SQLException {
		boolean result = false;
				
		Connection con = null;
		CallableStatement spCreateHold = null;
					
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			spCreateHold = con.prepareCall("{call sp_PreSale_CreateHold(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");	
			
			spCreateHold.setInt(1, invoice.idcustomer);	
			
			if (invoice.idtouristgroup == 0) {
				spCreateHold.setNull(2, Types.INTEGER);
			} else {
				spCreateHold.setInt(2, invoice.idtouristgroup);
			}

			Timestamp today = SQLFunctions.getInstance().sqlNow();
			
			spCreateHold.setTimestamp(3, today);
			spCreateHold.setInt(4, invoice.idmedia);
			spCreateHold.setInt(5, invoice.iddelivertype);
			
			if (invoice.idothercommission == 0) {
				spCreateHold.setNull(6, Types.INTEGER);
			} else {
				spCreateHold.setInt(6, invoice.idothercommission);
			}
			
			spCreateHold.setString(7, invoice.firstname);
			spCreateHold.setString(8, invoice.lastname);
			spCreateHold.setBoolean(9, invoice.layaway);
			spCreateHold.setInt(10, invoice.idstore);
			spCreateHold.setString(11, invoice.zip);
			spCreateHold.setString(12, invoice.note);
			spCreateHold.setBoolean(13, invoice.printnotes);
			spCreateHold.registerOutParameter(14, Types.INTEGER);
			
			spCreateHold.execute();
			
			invoice.idpresale = spCreateHold.getInt(14);
			
			getNewSaleCode(invoice);
			updateInvoice(invoice);
			
			boolean fExempt = getTaxExemptParamValue();
			
			updateExemptTax(invoice,fExempt);
			
			result = true;	
			
		} finally {
			ConnectionFunctions.getInstance().closeConnection(null, spCreateHold, con);	
		}
		
		return result;
	}
	
	public void getNewSaleCode(Invoice invoice) throws SQLException {
		
		Connection con = null;
		CallableStatement spNewSaleCode = null;
						
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			spNewSaleCode = con.prepareCall("{call sp_PreSale_GetNewSaleCode(?, ?, ?)}");			
			spNewSaleCode.setNull(1, Types.INTEGER);			
			spNewSaleCode.setInt(2, invoice.idstore);
			spNewSaleCode.registerOutParameter(3, Types.VARCHAR);
			spNewSaleCode.execute();
			invoice.salecode = spNewSaleCode.getString(3);
			
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, spNewSaleCode, con);	
		}
			
	}	
	
	private void updateInvoice(Invoice invoice) throws SQLException {
		
			
		String sql = "UPDATE Invoice SET SaleCode = '" + invoice.salecode + "' WHERE IDPreSale = " + invoice.idpresale;
					 
		Connection con = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, con);	
		}
	}
	
	private void updateExemptTax(Invoice invoice, boolean fExempt) throws SQLException {
		
		String taxisent;
		if (fExempt) 
			taxisent = "1";
		else
			taxisent = "0";
		
		
		String sql = "UPDATE Invoice SET Tax = 0, TaxIsent = " + taxisent + " WHERE IDPreSale = " + invoice.idpresale;
							 
		Connection con = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, con);	
		}
	}
	
	private boolean getTaxExemptParamValue() throws SQLException {
		ParameterListEEDAO parameterListEEDAO = ParameterListEEDAOFactory.getParameterListDAO(ParameterListEEDAOFactory.DATABASE_SLQSERVER);
		ParameterList parameterList = parameterListEEDAO.getParameterList();		
		return parameterList.getBooleanValueAt(ParameterList.PARAM_TAX_EXEMPT_ON_SALE).booleanValue();
	}
}
