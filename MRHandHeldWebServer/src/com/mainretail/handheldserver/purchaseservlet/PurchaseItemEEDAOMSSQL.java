package com.mainretail.handheldserver.purchaseservlet;

import java.sql.*;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.BarcodeVerifyQty;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelVerifyQty;
import com.mainretail.handheld.Pessoa;
import com.mainretail.handheld.purchase.PurchaseItem;
import com.mainretail.handheldserver.util.*;

public class PurchaseItemEEDAOMSSQL implements PurchaseItemEEDAO {
	
	private static PurchaseItemEEDAOMSSQL instance;
	private PurchaseItemEEDAOMSSQL() {}
	
	public static PurchaseItemEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new PurchaseItemEEDAOMSSQL(); 
		}
		return instance;		
	}

	public void save(PurchaseItem purchaseitem) throws SQLException {
		purchaseitem.idpurchaseitem = SQLFunctions.getInstance().getNextCode("Pur_PurchaseItem.IDPurchaseItem"); 
		
		Hashtable ht = new Hashtable();
			
		ht.put("idpurchaseitem", new Integer(purchaseitem.idpurchaseitem));
		ht.put("idpurchase", new Integer(purchaseitem.idpurchase));	
		ht.put("idpoitem", new Integer(purchaseitem.idpoitem));
		ht.put("idmodel", new Integer(purchaseitem.model.idmodel));
		ht.put("idgroup", new Integer(purchaseitem.model.idgroup));
		ht.put("idfornecedor", new Integer(purchaseitem.vendor.idpessoa));
		
		if ( purchaseitem.barcode != null) {
			ht.put("barcode", new String(purchaseitem.barcode));
		}
		
		ht.put("newcostprice", new Double(purchaseitem.newcostprice));
		ht.put("newsaleprice", new Double(purchaseitem.newsaleprice));
		ht.put("newsuggretail", new Double(purchaseitem.newsuggretail));
		ht.put("qty", new Double(purchaseitem.qty));
		ht.put("costprice", new Double(purchaseitem.costprice));
		ht.put("freightcost", new Double(purchaseitem.freightcost));
		ht.put("othercost", new Double(purchaseitem.othercost)); 
		
		String sql = SQLFunctions.getInstance().hashTableToSQLInsert("Pur_PurchaseItem", ht);
		
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

	private PurchaseItem load(ResultSet rs) throws SQLException 
	{
		
		PurchaseItem purchaseitem = new PurchaseItem();
		Pessoa vendor = new Pessoa();
		Model model = new Model();
		
		purchaseitem.idpurchaseitem = rs.getInt("idpurchaseitem");
		purchaseitem.idpurchase     = rs.getInt("idpurchase");	
		purchaseitem.idpoitem       = rs.getInt("idpoitem");
		purchaseitem.barcode        = rs.getString("idbarcode");
		purchaseitem.newcostprice   = rs.getDouble("newcostprice");
		purchaseitem.newsaleprice   = rs.getDouble("newsaleprice");
		purchaseitem.newsuggretail  = rs.getDouble("newsuggretail");
		purchaseitem.qty            = rs.getDouble("qty");
		purchaseitem.costprice      = rs.getDouble("costprice");
		purchaseitem.freightcost    = rs.getDouble("freightcost");
		purchaseitem.othercost      = rs.getDouble("othercost"); 
		
														
		model.description  = rs.getString("description");
		model.barcode      = rs.getString("idbarcode");
		model.idmodel      = rs.getInt("idmodel");
		model.idgroup      = rs.getInt("groupid");
		model.model        = rs.getString("model");
		model.qty          = rs.getInt("qty");
		
		vendor.idtipopessoa = rs.getInt("idtipopessoa");
		vendor.pessoa		= rs.getString("pessoa");
		vendor.idpessoa     = rs.getInt("idpessoa");
		
		purchaseitem.model = model;
		purchaseitem.vendor = vendor;
		
		return purchaseitem;
	}

	public Vector getPurchaseItem(int idpurchase) throws SQLException {
		Vector vetPurchaseItem = new Vector();
		
		String sql = 
			
			"SELECT " +  
	        "	PUI.idpurchaseitem, " +
	        "	PUI.idpurchase, " +	
	        "	PUI.idpoitem, " +
	        "	PUI.idmodel, " +
	        "	PUI.newcostprice, " +
	        "	PUI.newsaleprice, " +
	        "	PUI.newsuggretail, " +
	        "	PUI.qty, " +
	        "	PUI.costprice, " +
	        "	PUI.freightcost, " +
	        "	PUI.othercost, " +
	        "	B.idbarcode, " +
	        "	P.pessoa, " +
	        "	P.idtipopessoa, " +
	        "	P.idpessoa, " +
	        "	M.groupid, " +
	        "	M.model, " +	
	        "	M.description, " +
	        "	M.vendorcost, " +
	        "	M.sellingprice, " +
	        "	M.suggretail " +
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
				vetPurchaseItem.addElement(load(rs));
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return vetPurchaseItem;
	}
	
	public Vector getVerifyQty(int idpurchase) throws SQLException {
		Vector vetVerifyQty = new Vector();
		
		String sql =
			"SELECT " +  
	        "	PUI.qty, " +
	        "	M.idmodel, " +	        
	        //"	M.groupid, " +
	        "	M.model, " +	
	        "	null as description " +	        
	        "FROM " +
	        "	Pur_PurchaseItem PUI " +
	        "	JOIN Model M ON (M.IDModel = PUI.IDModel) " +
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
				ModelVerifyQty modelverifyqty = new ModelVerifyQty();
				Model model = new Model();
				
				model.model = rs.getString("model");
				model.description = rs.getString("description");
				//model.idgroup = rs.getInt("groupid");
				model.idmodel = rs.getInt("idmodel");
				
				modelverifyqty.qty = rs.getDouble("qty");
				modelverifyqty.qtyVerified = 0;
				modelverifyqty.model = model;
				
				vetVerifyQty.addElement(modelverifyqty);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return vetVerifyQty;		
	}
	
	public Vector getBarcode(int idpurchase) throws SQLException {
		Vector vetBarcode = new Vector();
		
		String sql =
			"SELECT " +  
	        "	M.idmodel, " +	        
	        //"	null model, " +
	        //"	null description, " +
	        "	B.idbarcode " +	        
	        "FROM " +
	        "	Pur_PurchaseItem PUI " +
	        "	JOIN Model M ON (M.IDModel = PUI.IDModel) " +
	        "	JOIN Barcode B ON (B.IDModel = M.IDModel)" +
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
				Barcode barcode = new Barcode();
				Model model = new Model();
				
				//model.model = rs.getString("model");
				//model.description = rs.getString("description");
				model.idmodel = rs.getInt("idmodel");
				
				barcode.idbarcode = rs.getString("idbarcode");
				barcode.model = model;
				
				vetBarcode.addElement(barcode);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return vetBarcode;		
	}

	public Vector getResultVerifyQty(int idpurchase, Vector verBarcodeVerifyQty) throws SQLException {
		
		boolean find  = false; 
		Vector vetVerifyQty = getVerifyQty(idpurchase);
		Vector vetBarcode   = getBarcode(idpurchase);
				
		for (Enumeration en = verBarcodeVerifyQty.elements(); en.hasMoreElements();){
			BarcodeVerifyQty barcodeVerifyQty = (BarcodeVerifyQty) en.nextElement();
			
			find = false;
			for (Enumeration en2 = vetBarcode.elements(); en2.hasMoreElements();){
				Barcode barcode = (Barcode) en2.nextElement(); 
				if (barcodeVerifyQty.barcode.equals((barcode.idbarcode).trim())) {
					find = true;
					for (Enumeration en3 = vetVerifyQty.elements(); en3.hasMoreElements();){
						ModelVerifyQty modelVerifyQty = (ModelVerifyQty) en3.nextElement(); 
						if (modelVerifyQty.model.idmodel == barcode.model.idmodel) {
							modelVerifyQty.qtyVerified = modelVerifyQty.qtyVerified + barcodeVerifyQty.qty;
						}
					}
				}
				
			}
			
			if (!find) {
				ModelVerifyQty modelVerifyQty = new ModelVerifyQty();
				modelVerifyQty.model = new Model();
				modelVerifyQty.model.barcode = barcodeVerifyQty.barcode;
				modelVerifyQty.qtyVerified = barcodeVerifyQty.qty;
				modelVerifyQty.qty = 0;
				modelVerifyQty.model.description = "NOT FOUND in this Purchase.";
				vetVerifyQty.addElement(modelVerifyQty);
			}
			
		}
		
		for (Enumeration en = vetVerifyQty.elements(); en.hasMoreElements();){
			ModelVerifyQty modelVerifyQty = (ModelVerifyQty) en.nextElement();
			if (modelVerifyQty.qty == modelVerifyQty.qtyVerified) {
				vetVerifyQty.removeElement(modelVerifyQty);
			}
		}
		
		vetBarcode = null;
		verBarcodeVerifyQty = null;
				
		return vetVerifyQty;
	}

		
}
