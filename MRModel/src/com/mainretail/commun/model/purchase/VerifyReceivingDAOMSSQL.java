package com.mainretail.commun.model.purchase;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import com.mainretail.commun.model.ConnectionFunctions;
import com.mainretail.commun.model.inventory.ModelVerifyQty;


public class VerifyReceivingDAOMSSQL implements
		IVerifyReceivingDAO {

	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		return false;
	}

	public boolean delete(Object obj) {
		return false;
	}
	
	
	public VerifyReceiving getPurchase(String field, String value)  throws SQLException {
		VerifyReceiving purchaseVerifyReceiving = new VerifyReceiving();
		
		String sql = 			
			"SELECT" +
			"	PU.idpurchase," +
			"	PU.idstore," +
			"	PU.iduserprereceiving," +
			"	PU.idpo," +
			"	PU.documenttype," +
			"	PU.documentnumber," +
			"	PU.freight," +
			"	PU.othercharges," +
			"	PU.subtotal," +
			"	PU.dateprereceiving," +
			"	PU.documentdate," +
			"	PU.documentduedate," +
			"	PU.datefinalreceiving," +
			"	P.pessoa," +
			"	P.idtipopessoa," +
			"	P.idpessoa " +
			"FROM " +
			"	Pur_Purchase PU " +
			"	JOIN Pessoa P ON (P.IDPessoa = PU.IDFornecedor) " +
			"WHERE " +
				field + " = " + "'" + value + "'";
	
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				/*
				Pessoa vendor = new Pessoa();
				purchase.vendor = vendor;
				*/
				loadRS(rs, purchaseVerifyReceiving);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}
		
		purchaseVerifyReceiving.items.addAll(getPurchaseVerifyReceivingItems(purchaseVerifyReceiving.idpurchase));
		
		return purchaseVerifyReceiving;
	}
	
	private VerifyReceiving loadRS(ResultSet rs, VerifyReceiving purchaseVerifyReceiving) throws SQLException{
		purchaseVerifyReceiving.idpurchase = rs.getInt("idpurchase");
		purchaseVerifyReceiving.idstore = rs.getInt("idstore");
		purchaseVerifyReceiving.iduserprereceiving = rs.getInt("iduserprereceiving");
		purchaseVerifyReceiving.idpo = rs.getInt("idpo");
		purchaseVerifyReceiving.documenttype = rs.getString("documenttype");
		purchaseVerifyReceiving.documentnumber = rs.getString("documentnumber");
		purchaseVerifyReceiving.freight = rs.getInt("freight");
		purchaseVerifyReceiving.othercharges = rs.getInt("othercharges");
		purchaseVerifyReceiving.subtotal = rs.getInt("subtotal");
		purchaseVerifyReceiving.dateprereceiving = rs.getDate("dateprereceiving");
		purchaseVerifyReceiving.documentdate = rs.getDate("documentdate");
		purchaseVerifyReceiving.documentduedate = rs.getDate("documentduedate");
		purchaseVerifyReceiving.datefinalreceiving = rs.getDate("datefinalreceiving");
	
		return purchaseVerifyReceiving;	
	}

	public VerifyReceiving getPurchase(String documentNumber) {
		try {
			return getPurchase("documentnumber", documentNumber);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public VerifyReceiving getPurchase(int idpurchase) {
		try {
			return getPurchase("idpurchase", String.valueOf(idpurchase));
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	
	private ModelVerifyQty loadRSItems(ResultSet rs) throws SQLException{
		ModelVerifyQty modelVerifyQty = new ModelVerifyQty();
		
		modelVerifyQty.idmodel = rs.getInt("idmodel");
		modelVerifyQty.description = rs.getString("description");		
		modelVerifyQty.qty = rs.getDouble("qty");
		modelVerifyQty.qtyReceived = 0;
		
		return modelVerifyQty;	
	}
	
	
	
	private Vector getPurchaseVerifyReceivingItems(int idpurchase) throws SQLException {
		Vector vetPurchaseItem = new Vector();
		
		String sql = 
			
			"SELECT " +  
	        "	PUI.idmodel, " +
	        "	PUI.qty, " +
	        "	M.description " +
	        "FROM " +
	        "	Pur_PurchaseItem PUI " +
	        "	JOIN Model M ON (M.IDModel = PUI.IDModel) " +
	        "	JOIN Pessoa P ON (P.IDPessoa = PUI.IDFornecedor) " +
	        "   LEFT JOIN Barcode B ON (B.IDModel = PUI.IDModel) " +
			"WHERE " +
			"	IDPurchase = " + String.valueOf(idpurchase);
	
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
				vetPurchaseItem.addElement(loadRSItems(rs));
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return vetPurchaseItem;
	}

	public VerifyReceiving getActiveVerifyreceiving() {
		// TODO Auto-generated method stub
		return null;
	}

	public ModelVerifyQty getItem(int idpurchase, int idmodel) {
		// TODO Auto-generated method stub
		return null;
	}



}
