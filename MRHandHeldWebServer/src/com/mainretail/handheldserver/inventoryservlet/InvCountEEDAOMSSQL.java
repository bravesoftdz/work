package com.mainretail.handheldserver.inventoryservlet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mainretail.handheld.inventory.InvCount;
import com.mainretail.handheldserver.util.ConnectionFunctions;

public class InvCountEEDAOMSSQL implements InvCountEEDAO{

	private static InvCountEEDAOMSSQL instance;
	private InvCountEEDAOMSSQL() {}
	
	public static InvCountEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new InvCountEEDAOMSSQL(); 
		}
		return instance;		
	}

	public InvCount find(int idstore, int counttype) throws SQLException {

		InvCount invcount = new InvCount(); 
		
		String sql = "SELECT C.IDCount , C.IDStore, C.CountType " +
					 "FROM Inv_Count C " +
					 "WHERE C.IDStore = " + idstore + " and C.CountType = " + counttype + " and C.EndDate is null";
		
		Connection con = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				load(rs, invcount);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}
		
		return invcount;
	}

	private void load(ResultSet rs, InvCount invcount) throws SQLException 
	{
		invcount.idcount = rs.getInt("IDCount");
		invcount.idstore = rs.getInt("IDStore");
		invcount.counttype = rs.getInt("CountType");
	}

}