package com.mainretail.handheldserver.inventoryservlet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;

import com.mainretail.handheld.inventory.FrozeCount;
import com.mainretail.handheldserver.util.ConnectionFunctions;
import com.mainretail.handheldserver.util.SQLFunctions;

public class FrozeCountEEDAOMSSQL implements FrozeCountEEDAO{

	private static FrozeCountEEDAOMSSQL instance;
	private FrozeCountEEDAOMSSQL() {}
	
	public static FrozeCountEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new FrozeCountEEDAOMSSQL(); 
		}
		return instance;		
	}

	public boolean save(FrozeCount frozecount) throws SQLException {
		
		boolean result = false;
		
		frozecount.qty = 0; 
		
		if (!find(frozecount)) {
			
			getQty(frozecount);
			
			Hashtable ht = new Hashtable();
			
			ht.put("idcount", new Integer(frozecount.idcount));
			ht.put("idmodel", new Integer(frozecount.model.idmodel));
			ht.put("qty", new Double(frozecount.qty));
			
			String sql = SQLFunctions.getInstance().hashTableToSQLInsert("Inv_FrozeCount", ht);
			
			Connection con = null;
			Statement stmt = null;
			
			try {
				con = ConnectionFunctions.getInstance().getConnection();
				stmt = con.createStatement();
				stmt.execute(sql);
				result = true;
			}
			finally {
				ConnectionFunctions.getInstance().closeConnection(null, stmt, con);	
			}	
		}
			
		return result;
	}
	
	private boolean find(FrozeCount frozecount) throws SQLException {
		
		boolean result = false;
		
		String sql = "SELECT IDCount FROM Inv_FrozeCount " +
					 "WHERE IDModel = " + frozecount.model.idmodel + " AND IDCount = " + frozecount.idcount;
		
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				result = true;
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}
		
		return result;
	} 
	
	public boolean getQty(FrozeCount frozecount) throws SQLException {
			
		boolean result = false;
		
		String sql = "SELECT QtyOnHand FROM Inventory " +
					 "WHERE ModelID = " + frozecount.model.idmodel;
		
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				frozecount.qty = rs.getDouble("QtyOnHand");
				result = true;
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}
		
		return result;
		
	}
}
