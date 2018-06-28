package com.mainretail.commun.model.inventory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;
import com.mainretail.commun.model.SQLDatabaseFunction;
import com.mainretail.commun.model.SQLFunctions;

public class BarcodePrintListDAOMSSQL implements IBarcodePrintListDAO {

	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		boolean result = true;
		Connection con = null;
		try {
			try {
				BarcodePrintList barcodePrintList = (BarcodePrintList)obj;
				
				con = ConnectionFunctions.getInstance().getConnection();
				try {
					con.setAutoCommit(false);
					saveBarcodePrintList(con, barcodePrintList);
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
		// TODO Auto-generated method stub
		return false;
	}
	
	private void saveBarcodePrintList(Connection con, BarcodePrintList barcodePrintList) throws SQLException {
		for (int i = 0; i < barcodePrintList.items.size(); i++){
			BarcodePrintItem barcodeItem = (BarcodePrintItem)(barcodePrintList.items.get(i));
			
			String sql = null;
			
			if (existBarcodePrint(con, barcodeItem.idbarcode)){
				sql = " UPDATE Inv_BarcodePrint " +
				  " SET Qtd = Qtd + " + barcodeItem.qty + ", IDUser = " + barcodeItem.iduser + " , Date = GetDate() " +        
				  " WHERE IDBarcode = '" + barcodeItem.idbarcode + "'";
			
			} else
			{
				Hashtable htValues = new Hashtable();
				
				htValues.put("IDUser", new Integer(barcodeItem.iduser));
				htValues.put("IDBarcode", barcodeItem.idbarcode);
				htValues.put("Qtd", new Double(barcodeItem.qty));
				htValues.put("Date", new SQLDatabaseFunction("GetDate()"));
				
				sql = SQLFunctions.getInstance().hashTableToSQLInsert("Inv_BarcodePrint", htValues);
			}
			
			Statement stmt = null;
			try {
				stmt = con.createStatement();
				stmt.execute(sql);
			} finally {
				ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
			}

			
		}
	}
	

	private boolean existBarcodePrint(Connection con, String idbarcode) throws SQLException {
		boolean result = false;
		
		String sql = " SELECT IDBarcode " +
					 " FROM Inv_BarcodePrint " +
					 " WHERE IDBarcode = '" + idbarcode + "'";
		
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

	public BarcodePrintList getOpenBarcodePrintList() {
		// TODO Auto-generated method stub
		return null;
	}
	

}
