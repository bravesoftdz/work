package com.mainretail.handheldserver.inventoryservlet;

import java.sql.*;

import com.mainretail.handheld.inventory.InvMov;
import com.mainretail.handheldserver.util.*;

public class InvMovEEDAOMSSQL implements InvMovEEDAO {

	private static InvMovEEDAOMSSQL instance;
	private InvMovEEDAOMSSQL() {}
	
	public static InvMovEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new InvMovEEDAOMSSQL(); 
		}
		return instance;		
	}

	public void save(InvMov invmov) throws SQLException {

		invmov.idinvmov = SQLFunctions.getInstance().getNextCode("InventoryMov.IDInventoryMov"); 
		
		String sql = null;
		
		sql = "INSERT INTO InventoryMov (IDInventoryMov, StoreID, ModelID, DocumentID, InventMovTypeID, IDUser, BarcodeID, Qty, MovDate) " +
		      "VALUES (" + invmov.idinvmov + "," + invmov.idstore + "," + invmov.idmodel + "," + invmov.documentid + "," + invmov.idinvmovtype + "," + invmov.iduser + ", '" + invmov.barcode + "' ," + invmov.qty + "," + " GetDate() )"; //+ invmov.movdate + " )";
		
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
}
