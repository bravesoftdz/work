package com.mainretail.commun.model.inventory;

import java.sql.Connection;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;
import com.mainretail.commun.model.SQLDatabaseFunction;
import com.mainretail.commun.model.SQLFunctions;

public class InventoryMovDAOMSSQL implements IInventoryMovDAO {

	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		return false;
	}

	public boolean delete(Object obj) {
		return false;
	}

	public boolean saveAsItem(InventoryMov obj, Object connection) {
		boolean result = true;
		try {
			Connection con = (Connection)connection;
			
			obj.idinvmov = SQLFunctions.getInstance().getNextCode(con, "InventoryMov.IDInventoryMov"); 
		
			Hashtable ht = new Hashtable();
			
			ht.put("IDInventoryMov", new Integer(obj.idinvmov));
			ht.put("StoreID", new Integer(obj.idstore));
			ht.put("ModelID", new Integer(obj.idmodel));
			ht.put("DocumentID", new Integer(obj.documentid));
			ht.put("InventMovTypeID", new Integer(obj.idinvmovtype));
			ht.put("IDUser", new Integer(obj.iduser));
			ht.put("BarcodeID", obj.barcode);
			ht.put("Qty", new Double(obj.qty));
			ht.put("MovDate", new SQLDatabaseFunction("GetDate()"));
			
			String sql = SQLFunctions.getInstance().hashTableToSQLInsert("InventoryMov", ht);
			
			Statement stmt = null;
			
			try {
				stmt = con.createStatement();
				stmt.execute(sql);
				result = true;
			}
			finally {
				ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
			}		
			
			
		} catch (Exception e) {
			result  = false;
			e.printStackTrace();
		}
		return result;
	}

}
