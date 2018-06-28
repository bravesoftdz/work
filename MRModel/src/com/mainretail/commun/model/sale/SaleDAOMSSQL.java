package com.mainretail.commun.model.sale;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.IServerParameterDAO;
import com.mainretail.commun.model.SQLFunctions;
import com.mainretail.commun.model.ServerParameter;

public class SaleDAOMSSQL implements ISaleDAO {

	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		Sale sale = (Sale)obj;
		boolean result = false;
		
		int idcustomer = 1; 		//	idcustomer padrao
		int idtouristgroup = 0;		//	Zero para setar o padrão ( null )
		int idmedia = 20;			//	Venda expressa
		int iddelivertype = 1;		//	Deliver Type On Hand
		int idothercommission = 0;	//	Zero para setar o padrão ( null )
		String firstname = "";		//	Customer first name
		String lastname = "";		//	Customer last name
		boolean layaway = false;	//	Nao pode ser layaway, tem que ser invoice
		String zip = "";			//	CEP
		String note = "";			//	Sem nada
		boolean printnotes = false;	//	Nao e para imprimir nada
		int idpresale = 0;			//	Retorno da funcao 
		
		
		java.sql.Connection con = null;
		
					
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			try {
				con.setAutoCommit(false);
				
				
				CallableStatement spCreateHold = null;
				
				try {
					spCreateHold = con.prepareCall("{call sp_PreSale_CreateHold(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");	
					
					spCreateHold.setInt(1, idcustomer); 	
					
					if (idtouristgroup == 0) {
						spCreateHold.setNull(2, Types.INTEGER);
					} else {
						spCreateHold.setInt(2, idtouristgroup);
					}

					Timestamp today = SQLFunctions.getInstance().sqlNow();
					
					spCreateHold.setTimestamp(3, today);
					spCreateHold.setInt(4, idmedia);
					spCreateHold.setInt(5, iddelivertype);
					
					if (idothercommission == 0) {
						spCreateHold.setNull(6, Types.INTEGER);
					} else {
						spCreateHold.setInt(6, idothercommission);
					}
					
					spCreateHold.setString(7, firstname);
					spCreateHold.setString(8, lastname);
					spCreateHold.setBoolean(9, layaway);
					spCreateHold.setInt(10, sale.idstore);
					spCreateHold.setString(11, zip);
					spCreateHold.setString(12, note);
					spCreateHold.setBoolean(13, printnotes);
					spCreateHold.registerOutParameter(14, Types.INTEGER);
					
					spCreateHold.execute();
					
					idpresale = spCreateHold.getInt(14);
				} finally {
					ConnectionFunctions.getInstance().closeConnection(null, spCreateHold, null);
				}
				
				getNewSaleCode(con, sale);
				updateInvoice(con, sale, idpresale);
				
				//boolean fExempt = getTaxExemptParamValue();
				
				IServerParameterDAO daoParameter = (IServerParameterDAO) DAOUtil.getDAO(ServerParameter.class, IParentDAO.DATABASE_MSSQL);
				
				boolean fExempt = ((Boolean)(daoParameter.getParameterValue(IServerParameterDAO.PARAM_TAX_EXEMPT_ON_SALE))).booleanValue();
				
				updateExemptTax(con, idpresale, fExempt);
				
				saveItems(con, sale, idpresale);
				
				con.commit();
				
				result = true;
				
			} catch (Exception sql) {
				con.rollback();
				throw sql;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		} finally {
			ConnectionFunctions.getInstance().closeConnection(null, null, con);	
		}

		return result;
	}

	public boolean delete(Object obj) {		
		return false;
	}

	public Sale getOpenSale() {
		return null;
	}
	
	public void getNewSaleCode(Connection con, Sale sale) throws SQLException {
		
		CallableStatement spNewSaleCode = null;
						
		try {
			spNewSaleCode = con.prepareCall("{call sp_PreSale_GetNewSaleCode(?, ?, ?)}");			
			spNewSaleCode.setNull(1, Types.INTEGER);			
			spNewSaleCode.setInt(2, sale.idstore);
			spNewSaleCode.registerOutParameter(3, Types.VARCHAR);
			spNewSaleCode.execute();
			sale.salecode = spNewSaleCode.getString(3);
			
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, spNewSaleCode, null);	
		}
			
	}
	
	
	private void updateInvoice(Connection con, Sale sale, int idpresale) throws SQLException {
		String sql = "UPDATE Invoice SET SaleCode = '" + sale.salecode + "' WHERE IDPreSale = " + idpresale;
					 
		Statement stmt = null;
	
		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
		}
	}
	
	private void updateExemptTax(Connection con, int idpresale, boolean fExempt) throws SQLException {
		
		String taxisent;
		if (fExempt) 
			taxisent = "1";
		else
			taxisent = "0";
		
		
		String sql = "UPDATE Invoice SET Tax = 0, TaxIsent = " + taxisent + " WHERE IDPreSale = " + idpresale;
							 
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
		}
	}
	
	public void saveItems(Connection con, Sale sale, int idpresale) throws SQLException {
		
		int iddepartment = 0;			//	Sem departamento
		int idcustomer = 1; 			//	idcustomer padrao
		double discount = 0.00;			//	Sem desconto
		boolean resetdiscount = false;	//	Sem reset
		boolean manager = true;			//	Sempre manager
		boolean promo = false;			//	Não é item de promo
		int idpreinvmovexchange = 0;	//	Zero para setar o padrão ( null )
		
		
		int iddescriptionprice = 0;
		int idvendorprice = 0;
		int suggprice = 0;
		String documentnumber = "";		//	Vazio para setar o padrão ( null )
		int iddocumentType = 0;
		
		
		Timestamp today = SQLFunctions.getInstance().sqlNow();

		
		CallableStatement spAddItem = null;
		try {
			spAddItem = con.prepareCall("{call sp_PreSale_AddItem(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");	
			
			for (int i = 0; i < sale.getItems().size(); i++){
			
				SaleItem saleItem = (SaleItem)(sale.getItems().get(i));
				
				spAddItem.setInt(1, idpresale);	
				spAddItem.setInt(2, idcustomer);
				spAddItem.setInt(3, saleItem.idmodel);
				spAddItem.setInt(4, sale.idstore);
				spAddItem.setInt(5, sale.iduser);
				spAddItem.setInt(6, sale.idcommission);
				spAddItem.setDouble(7, saleItem.qty);
				spAddItem.setDouble(8, saleItem.salePrice);
				spAddItem.setDouble(9, saleItem.costprice);
				spAddItem.setDouble(10, discount);
				spAddItem.setTimestamp(11, today);
				spAddItem.setBoolean(12, resetdiscount);
				spAddItem.setBoolean(13, manager);
				spAddItem.setTimestamp(14, today);
				if (idpreinvmovexchange == 0)
					spAddItem.setNull(15, Types.INTEGER);
				else
					spAddItem.setInt(15, idpreinvmovexchange);
				spAddItem.setNull(16, Types.INTEGER);
				spAddItem.setInt(17, iddepartment);
				spAddItem.setBoolean(18, promo);
				
				spAddItem.setInt(19, iddescriptionprice);
				spAddItem.setInt(20, idvendorprice);
				spAddItem.setInt(21, suggprice);
				
				if (documentnumber.equals(""))
					spAddItem.setNull(22, Types.VARCHAR);
				else
					spAddItem.setString(22, documentnumber);
				spAddItem.setInt(23, iddocumentType);
				
				spAddItem.registerOutParameter(24, Types.INTEGER);
				
				spAddItem.execute();
				
				//saleItem.idpreinventmov = spAddItem.getInt(24);
			}
			
		} finally {
			ConnectionFunctions.getInstance().closeConnection(null, spAddItem, null);	
		}
	}

	public ArrayList getFinalizedSales() {
		return null;
	}

	public Sale get(Sale sale) {
		return null;
	}


}
