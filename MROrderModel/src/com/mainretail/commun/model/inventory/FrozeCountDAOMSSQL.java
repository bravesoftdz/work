package com.mainretail.commun.model.inventory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;
import com.mainretail.commun.model.SQLFunctions;

public class FrozeCountDAOMSSQL implements IFrozeCountDAO {

	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		return false;
	}

	public boolean delete(Object obj) {
		return false;
	}

	public boolean saveAsItem(Object connection, FrozeCount frozecount) {
		boolean result = true;
		
		try {
			frozecount.qty = 0;
			
			Connection con = (Connection)connection;
			
			if (!find(con, frozecount)) {
				
				getQty(con, frozecount);
				
				Hashtable ht = new Hashtable();
				
				ht.put("idcount", new Integer(frozecount.idcount));
				ht.put("idmodel", new Integer(frozecount.idmodel));
				ht.put("qty", new Double(frozecount.qty));
				
				String sql = SQLFunctions.getInstance().hashTableToSQLInsert("Inv_FrozeCount", ht);
				
				Statement stmt = null;
				
				try {
					stmt = con.createStatement();
					stmt.execute(sql);
					result = true;
				}
				finally {
					ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
				}	
			}
		} catch (Exception e) {
			result = false;
			e.printStackTrace();
		}
			
		return result;
	}
	
	private boolean find(Connection con, FrozeCount frozecount) throws SQLException {
		
		boolean result = false;
		
		String sql = "SELECT IDCount FROM Inv_FrozeCount " +
					 "WHERE IDModel = " + frozecount.idmodel + " AND IDCount = " + frozecount.idcount;
		
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				result = true;
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, null);	
		}
		
		return result;
	} 
	
	public boolean getQty(Connection con, FrozeCount frozecount) throws SQLException {
			
		boolean result = false;
		
		String sql = "SELECT QtyOnHand FROM Inventory " +
					 "WHERE ModelID = " + frozecount.idmodel;
		
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				frozecount.qty = rs.getDouble("QtyOnHand");
				result = true;
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, null);	
		}
		
		return result;
		
	}

}
