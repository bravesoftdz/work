package com.mainretail.commun.model.purchase;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

import com.mainretail.commun.model.ConnectionFunctions;
import com.mainretail.commun.model.SQLFunctions;
import com.mainretail.commun.model.inventory.ModelVendorInfo;


public class ReceivingDAOMSSQL implements IReceivingDAO {
	private static final String DOCUMENTTYPE = "Packing Slip";
	
	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		boolean result = true;
		Connection con = null;
		try {
			try{
				con = ConnectionFunctions.getInstance().getConnection();
				con.setAutoCommit(false);
				try{
					int idpurchase = saveReceiving((Receiving)obj, con);
					saveReceivingItems((Receiving)obj, con);
					execPurchaseDO(idpurchase, con);
					con.commit();
				}catch (Exception sql){
					con.rollback();
					throw sql;
				}
			} catch (Exception e) {
			result = false;
			e.printStackTrace();
			}
		}finally {
			ConnectionFunctions.getInstance().closeConnection(null, null, con);
		}
				
		return result;
	}
	
	public int saveReceiving(Receiving receiving, Connection con) throws SQLException{
		
		String sql = null;
		receiving.idpurchase = SQLFunctions.getInstance().getNextCode(con, "Pur_Purchase.IDPurchase");
		
		receiving.dateprereceiving = new Date();
		receiving.documenttype = DOCUMENTTYPE;
		
		{
			Hashtable ht = new Hashtable();
			
			ht.put("idpurchase", new Integer(receiving.idpurchase));
			ht.put("idfornecedor", new Integer(receiving.idvendor));
			ht.put("idstore", new Integer(receiving.idstore));
			ht.put("iduserprereceiving", new Integer(receiving.iduserprereceiving));
			if (receiving.idpo != 0) {
				ht.put("idpo",new Integer(receiving.idpo));
			} 		
			if (receiving.documenttype != null) {
				ht.put("documenttype", new String(receiving.documenttype));
			}
			if (receiving.documentnumber != null) {
				ht.put("documentnumber", new String(receiving.documentnumber));
			}
			if (receiving.dateprereceiving != null) {
				ht.put("dateprereceiving", receiving.dateprereceiving);
			}
			if (receiving.documentdate != null) {
				ht.put("documentdate", receiving.documentdate);
			}
			if (receiving.documentduedate != null) {
				ht.put("documentduedate", receiving.documentduedate);
			}
			ht.put("freight", new Double(receiving.freight));
			ht.put("othercharges", new Double(receiving.othercharges));
			ht.put("subtotal", new Double(receiving.subtotal));

			sql = SQLFunctions.getInstance().hashTableToSQLInsert("Pur_Purchase", ht);
		}
		
		Statement stmt = null;

		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
		}
		
		return receiving.idpurchase;
	}
	
	public void saveReceivingItems(Receiving receiving, Connection con) throws SQLException{
		for (int i=0; i < receiving.items.size(); i++){
			ReceivingItem ri = (ReceivingItem)receiving.items.get(i);
			if (ri.qty != 0)
				saveReceivingItem(receiving, ri, con);
		}
	}
	
	public void saveReceivingItem(Receiving receiving, ReceivingItem receivingItem, Connection con) throws SQLException {
		int idpurchaseitem = SQLFunctions.getInstance().getNextCode(con, "Pur_PurchaseItem.IDPurchaseItem");
		
		Hashtable ht = new Hashtable();
			
		ht.put("idpurchaseitem", new Integer(idpurchaseitem));
		ht.put("idpurchase", new Integer(receiving.idpurchase));
		ht.put("idmodel", new Integer(receivingItem.idmodel));
		ht.put("idgroup", new Integer(receivingItem.idgroup));
		ht.put("idfornecedor", new Integer(receiving.idvendor));
		ht.put("newcostprice", new Double(receivingItem.newcostprice));
		ht.put("newsaleprice", new Double(receivingItem.newsaleprice));
		ht.put("newsuggretail", new Double(receivingItem.newsuggretail));
		
		ht.put("freightcost", new Double(receivingItem.freightcost));
		ht.put("othercost", new Double(receivingItem.othercost)); 
		
		
		
		if ( receivingItem.barcode != null)
			ht.put("barcode", new String(receivingItem.barcode));
		
		
		double caseQty = 1;
		double minQty = 1;
		
		if (receivingItem.idpoitem == null){
			ModelVendorInfo modelVendorInfo = new ModelVendorInfo(receivingItem.idmodel, receiving.idvendor);
			getModelVendorInfo(modelVendorInfo, con);
			
			caseQty = modelVendorInfo.minQty;
			minQty = modelVendorInfo.minQty;
			
			if (receivingItem.qty < minQty)
				receivingItem.qty = minQty;
		}
		else {
			ht.put("idpoitem", receivingItem.idpoitem);
		}
		
		if (caseQty > 1){
			ht.put("qty", new Double(receivingItem.qty * caseQty));
			ht.put("caseqty", new Double(receivingItem.qty));
			ht.put("casecost", new Double((receivingItem.qty * caseQty) * receivingItem.newcostprice));
		} else {
			ht.put("qty", new Double(receivingItem.qty));
		}

		
		
		ht.put("costprice", new Double(receivingItem.costprice * receivingItem.qty));
			
		String sql = SQLFunctions.getInstance().hashTableToSQLInsert("Pur_PurchaseItem", ht);
		
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
		}
	}
	
	// Encontrar todas as referencias e futuramente mover para uma classe de CaseQty
	private void getModelVendorInfo(ModelVendorInfo modelVendorInfo, Connection con) throws SQLException{
		
		String sql = " SELECT  MinQtyPO, CaseQty "+
		 			" FROM Inv_ModelVendor "+
		 			" WHERE IDPessoa = '" + String.valueOf(modelVendorInfo.idvendor) + "' AND IDModel = " + String.valueOf(modelVendorInfo.idmodel);

		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				modelVendorInfo.caseQty = rs.getDouble("CaseQty");
				modelVendorInfo.minQty = rs.getDouble("MinQtyPO");
			}
		}
		finally {
			com.mainretail.commun.model.ConnectionFunctions.getInstance().closeConnection(rs, stmt, null);	
		}		
		
	}
	
	public boolean execPurchaseDO(int idpurhase, Connection con) throws SQLException{
		boolean result = false;
		
		// Nao pode estar dentro do callable statment pois dá erro de transação
		boolean taxincost = getTaxInCost(con);
		
		CallableStatement spPurchaseDo = null;
							
		try {
			spPurchaseDo = con.prepareCall("{call sp_Purchase_Do(?, ?, ?)}");	
			
			Timestamp today = SQLFunctions.getInstance().sqlNow();
			
			
			spPurchaseDo.setInt(1, idpurhase);	
			spPurchaseDo.setTimestamp(2, today);
			spPurchaseDo.setBoolean(3, taxincost);
						
			spPurchaseDo.execute();
			result = true;
						
		} finally {
			ConnectionFunctions.getInstance().closeConnection(null, spPurchaseDo, null);	
		}
		
		return result;
		
	}
	
	private boolean getTaxInCost(Connection con) throws SQLException {
		
		boolean result = false;
		
		String sql = " SELECT SrvValue FROM Param WHERE IDParam = 66 ";	
		
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				result = rs.getBoolean("SrvValue");
				
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, null);	
		}	
		
		return result;
	}
	
	
	public boolean delete(Object obj) {
		return false;
	}

	public Receiving importPO(String idPO) {
		
		Receiving receiving = null;
		
		try {
			receiving = getPO(idPO);
			if (receiving != null)
				receiving.items.addAll(getPOItems(idPO, receiving));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return receiving;
	}
	
	private Receiving getPO(String idPO) throws SQLException{
		
		Receiving receiving = null;
		
		String sql = " SELECT PO.IDPO, PO.IDFornecedor, PO.IDStore "+
					 " FROM PO "+
					 " WHERE IDPO = '" + idPO + "' " + 
					 " AND Aberto = 1 ";	

		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = com.mainretail.commun.model.ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()){
				receiving = new Receiving();
				receiving.idvendor = rs.getInt("IDFornecedor");
				receiving.idstore = rs.getInt("IDStore");
				receiving.idpo = rs.getInt("IDPO");
			}
				
		}
		finally {
			com.mainretail.commun.model.ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}
		
		return receiving;
	}
	
	private Vector getPOItems(String idPO, Receiving receiving) throws SQLException{
		
		Vector vetPOItem = new Vector();
		
		String sql = " SELECT PIM.IDPreInventoryMov, PIM.BarcodeID, PIM.IDPessoa, "+
					 " PIM.CostPrice, PIM.SalePrice, PIM.SuggRetail, PIM.Qty, PIM.QtyRealMov, "+
					 " M.IDModel, M.Description, M.GroupID "+
					 " FROM PreInventoryMov PIM JOIN MODEL M ON (M.IDModel = PIM.ModelID) "+
					 " WHERE DocumentID = '" + idPO + "' AND InventMovTypeID = 2 " +
					 " AND (PIM.QtyRealMov < PIM.Qty) ";	
		
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = com.mainretail.commun.model.ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
				ReceivingItem receivingItem = load(rs);
				vetPOItem.addElement(receivingItem);
				//receiving.subtotal += (receivingItem.qty * receivingItem.newcostprice);
			}
		}
		finally {
			com.mainretail.commun.model.ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return vetPOItem;
		
	}
	
	private ReceivingItem load(ResultSet rs) throws SQLException 
	{
		ReceivingItem receivingItem = new ReceivingItem();
		
		receivingItem.idpoitem		= new Integer(rs.getInt("IDPreInventoryMov"));
		receivingItem.idmodel 		= rs.getInt("IDModel");
		receivingItem.description	= rs.getString("Description");
		receivingItem.barcode		= rs.getString("BarcodeID");
		receivingItem.newcostprice	= rs.getDouble("CostPrice");
		receivingItem.newsaleprice	= rs.getDouble("SalePrice");
		receivingItem.newsuggretail	= rs.getDouble("SuggRetail");
		receivingItem.qty			= (rs.getDouble("Qty") - rs.getDouble("QtyRealMov"));
		receivingItem.costprice		= rs.getDouble("CostPrice");
		receivingItem.idgroup		= rs.getInt("GroupID");
		receivingItem.freightcost	= 0;
		receivingItem.othercost		= 0; 
		
		return receivingItem;
	}

	public Receiving getActiveReceiving() {
		return null;
	}
}

