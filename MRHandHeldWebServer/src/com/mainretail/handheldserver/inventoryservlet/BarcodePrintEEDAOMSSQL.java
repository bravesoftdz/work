package com.mainretail.handheldserver.inventoryservlet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Hashtable;

import com.mainretail.handheld.inventory.BarcodePrint;
import com.mainretail.handheldserver.util.ConnectionFunctions;
import com.mainretail.handheldserver.util.SQLFunctions;

public class BarcodePrintEEDAOMSSQL implements BarcodePrintEEDAO{

	private static BarcodePrintEEDAOMSSQL instance;
	private BarcodePrintEEDAOMSSQL() {}
	
	public static BarcodePrintEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new BarcodePrintEEDAOMSSQL(); 
		}
		return instance;		
	}

	public boolean save(BarcodePrint barcodeprint) throws SQLException {
		boolean result = false;
		
		Timestamp today = SQLFunctions.getInstance().sqlNow();
		barcodeprint.date = today;
		
		String sql;
		
		if (existBarcodePrint(barcodeprint)) {
			
			sql = " UPDATE Inv_BarcodePrint " +
				  " SET Qtd = " + barcodeprint.qtd + ", IDUser = " + barcodeprint.iduser + " , Date = '" + barcodeprint.date + "' " +        
				  " WHERE IDBarcode = '" + barcodeprint.barcode.idbarcode + "'";
			
		} else {
			
			Hashtable ht = new Hashtable();
			
			ht.put("idbarcode", new String(barcodeprint.barcode.idbarcode));
			ht.put("qtd", new Integer(barcodeprint.qtd));
			ht.put("iduser", new Integer(barcodeprint.iduser));
			ht.put("date", barcodeprint.date);
			
			sql = SQLFunctions.getInstance().hashTableToSQLInsert("Inv_BarcodePrint", ht);
		}
				
		Connection con = null;
		Statement stmt = null;
		
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			stmt.execute(sql);
			result = true;
		} finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, con);	
		}
		return result;
	}
	
	private boolean existBarcodePrint(BarcodePrint barcodeprint) throws SQLException {
		boolean result = false;
		
		String sql = " SELECT IDBarcode " +
					 " FROM Inv_BarcodePrint " +
					 " WHERE IDBarcode = '" + barcodeprint.barcode.idbarcode + "'";
		
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
