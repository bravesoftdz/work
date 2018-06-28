package com.mainretail.handheldserver.inventoryservlet;

import java.sql.*;

import com.mainretail.handheld.inventory.InvCountItem;
import com.mainretail.handheldserver.util.*;

public class InvCountItemEEDAOMSSQL implements InvCountItemEEDAO {

	private static InvCountItemEEDAOMSSQL instance;
	private InvCountItemEEDAOMSSQL() {}
	
	public static InvCountItemEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new InvCountItemEEDAOMSSQL(); 
		}
		return instance;		
	}

	public void save(InvCountItem invcountitem) throws SQLException {
		
		String sql = null;
		
		if (find(invcountitem)) {
			sql = " UPDATE Inv_CountItem " +
				  " SET Qty = Qty + " + invcountitem.qty + 
				  " WHERE Barcode = '" + invcountitem.barcode + "' AND IDCount = " + invcountitem.idcount;
			
		} else {
			invcountitem.idcountitem = SQLFunctions.getInstance().getNextCode("Inv_CountItem.IDCountItem"); 
			
			sql = "INSERT INTO Inv_CountItem (IDCountItem, IDCount, IDUser, Barcode, Qty, SalePrice, CountDate) " +
				  "VALUES (" + invcountitem.idcountitem + "," + invcountitem.idcount + "," + invcountitem.iduser + ", '" + invcountitem.barcode + "' ," + invcountitem.qty + "," + invcountitem.saleprice + ", GetDate())";
		}
		
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
	
	private boolean find(InvCountItem invcountitem) throws SQLException {
		
		boolean result = false;
		
		String sql = "SELECT Qty FROM Inv_CountItem " +
					 "WHERE Barcode = '" + invcountitem.barcode + "' AND IDCount = " + invcountitem.idcount;
		
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
}