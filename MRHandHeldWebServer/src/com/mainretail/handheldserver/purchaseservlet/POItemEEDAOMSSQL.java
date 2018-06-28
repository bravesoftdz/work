package com.mainretail.handheldserver.purchaseservlet;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.purchase.POItem;
import com.mainretail.handheldserver.util.*;

public class POItemEEDAOMSSQL implements POItemEEDAO {
	
	private static POItemEEDAOMSSQL instance;
	private POItemEEDAOMSSQL() {}
	
	public static POItemEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new POItemEEDAOMSSQL(); 
		}
		return instance;		
	}

	public Vector getPoItems(String ponumber) throws SQLException {
		
		Vector vetPOItem = new Vector();
		
		String sql = " SELECT PIM.IDPreInventoryMov, PIM.BarcodeID, PIM.InventMovTypeID, PIM.StoreID, PIM.IDPessoa, "+
					 " PIM.UserID, PIM.IDCotacao, PIM.IDPreInventoryMovParent, PIM.DocumentID, PIM.IDParentPack, PIM.IDModelService, "+
					 " PIM.IDPreInvMovExchange, PIM.ExchangeInvoice, PIM.Marked, PIM.CostPrice, PIM.SalePrice, "+
					 " PIM.Discount, PIM.SuggRetail, PIM.DesiredMarkup, PIM.Qty, PIM.QtyRealMov, PIM.QtyExceeded, "+
					 " PIM.QtyExchanged, PIM.MovDate, PIM.DateEstimatedMov, PIM.DateRealMov, M.IDModel, M.GroupID, "+
					 " M.Model, M.Description, M.TotQtyOnHand "+ 
					 " FROM PreInventoryMov PIM JOIN MODEL M ON (M.IDModel = PIM.ModelID) "+
					 " WHERE DocumentID = '" + ponumber + "' AND InventMovTypeID = 2 " ;	
	
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
				vetPOItem.addElement(load(rs));
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return vetPOItem;
	}
	
	private POItem load(ResultSet rs) throws SQLException 
	{
		POItem poitem = new POItem();
		Model model = new Model();
		
		poitem.idpoitem                = rs.getInt("IDPreInventoryMov");
		poitem.inventmovtypeid         = rs.getInt("InventMovTypeID");			
		poitem.storeid                 = rs.getInt("StoreID");
		poitem.idpessoa                = rs.getInt("IDPessoa");
		poitem.userid                  = rs.getInt("UserID");
		poitem.documentid              = rs.getInt("DocumentID");
		poitem.barcode                 = rs.getString("BarcodeID");
		poitem.costprice               = rs.getDouble("CostPrice");
		poitem.saleprice               = rs.getDouble("SalePrice");
		poitem.suggretail              = rs.getDouble("SuggRetail");
		poitem.qty                     = rs.getDouble("Qty");
		poitem.qtyrealmov              = rs.getDouble("QtyRealMov");
		poitem.movdate                 = rs.getDate("MovDate");
		poitem.dateestimatedmov        = rs.getDate("DateEstimatedMov");
		poitem.daterealmov             = rs.getDate("DateRealMov");
																		
		model.description  = rs.getString("Description");
		model.barcode      = rs.getString("BarcodeID");
		model.idmodel      = rs.getInt("IDModel");
		model.idgroup      = rs.getInt("GroupID");
		model.model        = rs.getString("Model");
		model.qty          = rs.getInt("TotQtyOnHand");
		
		poitem.model = model;
		
		return poitem;
	}

	public void save(POItem poitem) throws SQLException {
		
		poitem.idpoitem = SQLFunctions.getInstance().getNextCode("PreInventoryMov.IDPreInventoryMov"); 
		
		Hashtable ht = new Hashtable();
		
		ht.put("modelid", new Integer(poitem.model.idmodel));	
		ht.put("idpreinventorymov", new Integer(poitem.idpoitem));
		
		poitem.inventmovtypeid = 2;	
		ht.put("inventmovtypeid", new Integer(poitem.inventmovtypeid));	
		
		ht.put("storeid", new Integer(poitem.storeid));
		ht.put("idpessoa", new Integer(poitem.idpessoa));
		ht.put("userid", new Integer(poitem.userid));
		ht.put("documentid", new Integer(poitem.documentid));
				
		if ( poitem.barcode != null) {
			ht.put("barcodeid", new String(poitem.barcode));
		}
		
		ht.put("costprice", new Double(poitem.costprice));
		ht.put("saleprice", new Double(poitem.saleprice));
		ht.put("suggretail", new Double(poitem.suggretail));
		
		double minQtyToOrder = getMinQtyToOrder(poitem);
		double caseQty = getCaseQty(poitem);
		
		if (poitem.qty < minQtyToOrder)			
			ht.put("qty", new Double(minQtyToOrder * caseQty));
		else
			ht.put("qty", new Double(poitem.qty * caseQty));
		
		if (caseQty > 1) 
			ht.put("caseqty", new Double(caseQty));
			
		ht.put("qtyrealmov", new Double(poitem.qtyrealmov));
		
		
		if (poitem.movdate != null) {
			ht.put("movdate", poitem.movdate);
		}
		
		if (poitem.dateestimatedmov != null) {
			ht.put("dateestimatedmov", poitem.dateestimatedmov);
		}
		
		if (poitem.daterealmov != null) {
			ht.put("daterealmov", poitem.daterealmov);
		}
		
		String sql = SQLFunctions.getInstance().hashTableToSQLInsert("PreInventoryMov", ht);
		
		Connection con = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			stmt.execute(sql);
			runPOItemDo(poitem);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, con);	
		}
	}
	
	private double getCaseQty(POItem poitem) throws SQLException {
		
		double caseQty = 1;
		
		String sql = 
					" SELECT " +
					" 	ISNULL(CASE WHEN CaseQty = 0 THEN 1 ELSE CaseQty END,1) CaseQty " +
					" FROM " +
					" 	Model " +
					" WHERE " +
					" 	IDModel = " + poitem.model.idmodel;	

		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;

		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
				caseQty = rs.getDouble("CaseQty");
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return caseQty;
	}
	
	private boolean runPOItemDo(POItem poitem) throws SQLException {
		
		boolean result = false; 
		Connection con = null;
		CallableStatement spPOItemDo = null;
						
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			spPOItemDo = con.prepareCall("{call sp_PO_Item_Do(?, ?)}");			
			spPOItemDo.setInt(1, poitem.idpoitem);			
			spPOItemDo.setInt(2, poitem.documentid);
			spPOItemDo.execute();
			result = true;			
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, spPOItemDo, con);	
		}
				
		return result;
	}
	
	private double getMinQtyToOrder(POItem poitem) throws SQLException {
		
		double MinQtyToOrder = 0;
		
		String sql = " SELECT " +
					 " MinQtyPO " +
					 "FROM " +
					 " Inv_ModelVendor " +
					 "WHERE " +
					 " IDPessoa = " + poitem.idpessoa +  
					 "	AND "+
					 " IDModel = " + poitem.model.idmodel;	

		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;

		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
				MinQtyToOrder = rs.getDouble("MinQtyPO");
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}		
		return MinQtyToOrder;
				
	}
		
}
