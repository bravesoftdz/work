package com.mainretail.commun.model.purchase;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;
import com.mainretail.commun.model.SQLFunctions;

import com.mainretail.commun.model.inventory.ModelVendorInfo;;



public class PODAOMSSQL implements IPODAO {

	public List listAll() {
		return null;
	} 

	public boolean save(Object obj) {
		boolean result = true;
		Connection con = null;
		try {
			try {
				PO po = (PO)obj;
				
				con = ConnectionFunctions.getInstance().getConnection();
				try {
					con.setAutoCommit(false);
					savePO(con, po);
					
					savePOItems(con, po);
					con.commit();
					
					
				} catch (Exception sql) {
					con.rollback();
					throw sql;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		}
		finally{
			ConnectionFunctions.getInstance().closeConnection(null, null, con);
		}
		return result;
	}

	public boolean delete(Object obj) {
		return false;
	}
	
	private void savePO(Connection con, PO po) throws SQLException {
			
		po.idpo = SQLFunctions.getInstance().getNextCode(con, "PO.IDPO");
				
		Hashtable ht = new Hashtable();
			
		ht.put("idpo",new Integer(po.idpo));
		ht.put("idfornecedor",new Integer(po.idvendor));
		ht.put("idstore",new Integer(po.idstore));
		ht.put("paydays",new Integer(po.paydays));
		
		if (po.obs != null) {
			ht.put("obs", new String(po.obs));
		}
		
		ht.put("freight", new Double(po.freight));
		ht.put("charges", new Double(po.charges));
		ht.put("subtotal", new Double(po.subtotal));
		ht.put("paymentetype", new Double(po.paymentetype));
		
		po.aberto = true;
		po.atendido = false;
		
		ht.put("aberto", new Boolean(po.aberto));
		//ht.put("atendido", new Boolean(po.atendido));
		
		po.datapedido = new Date();
		ht.put("datapedido", po.datapedido);
		
			
		if (po.estarrival != null) {
			ht.put("estarrival", po.estarrival);
		}
						
		String sql = SQLFunctions.getInstance().hashTableToSQLInsert("PO", ht); 
				
				
		Statement stmt = null;
			
		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
		}
	}
	
	private void savePOItems(Connection con, PO po) throws SQLException{
		for (int i = 0; i < po.getItems().size(); i++){
			POItem poitem = (POItem)po.getItems().get(i);
			//Cirar uma funcao para procurar o barcode antes de salver no PO item
			//Caso nao existir o barcode, nao salvar o item.
			if (poitem.idmodel != 0)
			{
			savePOItem(con, po, poitem);
			runPOItemDo(con, poitem);
			}
		}
	}
	
	
	private void savePOItem(Connection con, PO po, POItem poitem) throws SQLException {
		
		poitem.idpoitem = SQLFunctions.getInstance().getNextCode(con, "PreInventoryMov.IDPreInventoryMov");
		poitem.documentid = po.idpo;
		
		Hashtable ht = new Hashtable();
		
		ht.put("modelid", new Integer(poitem.idmodel));	
		ht.put("idpreinventorymov", new Integer(poitem.idpoitem));
		
		poitem.inventmovtypeid = 2;	
		ht.put("inventmovtypeid", new Integer(poitem.inventmovtypeid));	
		
		ht.put("storeid", new Integer(poitem.storeid));
		ht.put("idpessoa", new Integer(poitem.idpessoa));
		ht.put("userid", new Integer(poitem.iduser));
		ht.put("documentid", new Integer(poitem.documentid));
				
		if ( poitem.barcode != null) {
			ht.put("barcodeid", new String(poitem.barcode));
		}
		
		ht.put("costprice", new Double(poitem.costprice));
		ht.put("saleprice", new Double(poitem.saleprice));
		ht.put("suggretail", new Double(poitem.suggretail));
		
		ModelVendorInfo modelVendorInfo = new ModelVendorInfo(poitem.idmodel, po.idvendor);
		getModelVendorInfo(modelVendorInfo, con);
		
		double caseQty = modelVendorInfo.minQty;
		double minQty = modelVendorInfo.minQty;
		
		if (poitem.qty < minQty)
			poitem.qty = minQty;
		
		if (caseQty > 1){
			ht.put("qty", new Double(poitem.qty * caseQty));
			ht.put("caseqty", new Double(poitem.qty));
			ht.put("casecost", new Double((poitem.qty * caseQty) * poitem.costprice));
		} else {
			ht.put("qty", new Double(poitem.qty));
		}
		
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
		
		
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
		}
			
	}
	
	private boolean runPOItemDo(Connection con, POItem poitem) throws SQLException {
		
		boolean result = false; 
		CallableStatement spPOItemDo = null;
						
		try {
			spPOItemDo = con.prepareCall("{call sp_PO_Item_Do(?, ?)}");			
			spPOItemDo.setInt(1, poitem.idpoitem);			
			spPOItemDo.setInt(2, poitem.documentid);
			spPOItemDo.execute();
			result = true;			
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, spPOItemDo, null);	
		}
				
		return result;
	}
	
	//	 Encontrar todas as referencias e futuramente mover para uma classe 
	private void getModelVendorInfo(ModelVendorInfo modelVendorInfo, Connection con) throws SQLException{
		
		String sql = " SELECT  MinQtyPO, CaseQty "+
		 			" FROM Inv_ModelVendor "+
		 			" WHERE IDPessoa = '" + String.valueOf(modelVendorInfo.idvendor) + "' AND IDModel = " + String.valueOf(modelVendorInfo.idmodel);

		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				modelVendorInfo.caseQty = rs.getDouble("CaseQty");
				modelVendorInfo.minQty = rs.getDouble("MinQtyPO");
			}
		}
		finally {
			com.mainretail.commun.model.ConnectionFunctions.getInstance().closeConnection(rs, stmt, null);	
		}		
		
	}

	public PO getActivePO() {
		return null;
	}

}
