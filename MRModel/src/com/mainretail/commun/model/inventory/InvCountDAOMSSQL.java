package com.mainretail.commun.model.inventory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.SQLDatabaseFunction;
import com.mainretail.commun.model.SQLFunctions;

public class InvCountDAOMSSQL implements IInvCountDAO {

	public boolean countingExists(InvCount invCount) {
		boolean result = false;
		try {
			Connection con = ConnectionFunctions.getInstance().getConnection();
			try{
				result = (find(con, invCount) != null);
			}
			finally{
				ConnectionFunctions.getInstance().closeConnection(null, null, con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		boolean result = true;
		Connection con = null;
		try {
			try {
				InvCount invCount = (InvCount)obj;
				
				con = ConnectionFunctions.getInstance().getConnection();
				try {
					con.setAutoCommit(false);
					
					// Faz tudo
					
					saveInvCountItems(con, invCount);
					
					
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
	
	
	private void saveInvCountItems(Connection con, InvCount invCount) throws SQLException {
		for (int i = 0; i < invCount.items.size(); i++){
			InvCountItem item = (InvCountItem)(invCount.items.get(i));
			
			saveInvCountItem(con, invCount, item);
			
			if (invCount.counttype == InvCount.INV_COUNT_PHYSICAL) {
				
				double oldQty = item.qty;
				
				FrozeCount frozecount = new FrozeCount();
				frozecount.idcount = invCount.idcount;
				frozecount.idmodel = item.idmodel;
				
				
				IFrozeCountDAO frozeCountDAO = (IFrozeCountDAO)DAOUtil.getDAO(FrozeCount.class, IParentDAO.DATABASE_MSSQL);
				frozeCountDAO.saveAsItem(con, frozecount);
				
				
				InventoryMov invmov = new InventoryMov();
				invmov.iduser = item.iduser;
				invmov.idstore = invCount.idstore;
				invmov.idinvmovtype = 21;	
				invmov.idmodel = item.idmodel;
				invmov.documentid = 0;
				invmov.barcode = item.barcode;
				invmov.qty = oldQty - frozecount.qty;
				
				
				IInventoryMovDAO invmovDAO = (IInventoryMovDAO)DAOUtil.getDAO(InventoryMov.class, IParentDAO.DATABASE_MSSQL);
				invmovDAO.saveAsItem(invmov, con);
			}
			
			
			
			
		}
	}

	private void saveInvCountItem(Connection con, InvCount invCount, InvCountItem item) throws SQLException {
		String sql = null;
		
		Hashtable htValues = new Hashtable();
		
		if (findInvCountItem(con, item)) {
			sql = " UPDATE Inv_CountItem " +
				  " SET Qty = Qty + " + item.qty + 
				  " WHERE Barcode = '" + item.barcode + "' AND IDCount = " + item.idcount;
			
		} else {
			
			item.idcountitem = SQLFunctions.getInstance().getNextCode(con, "Inv_CountItem.IDCountItem");
			
			htValues.put("IDCountItem", new Integer(item.idcountitem));
			htValues.put("IDCount", new Integer(item.idcount));
			htValues.put("IDUser", new Integer(item.iduser));
			htValues.put("Barcode", item.barcode);
			htValues.put("Qty", new Double(item.qty));
			htValues.put("SalePrice", new Double(item.saleprice));
			htValues.put("CountDate", new SQLDatabaseFunction("GetDate()"));

			sql = SQLFunctions.getInstance().hashTableToSQLInsert("Inv_CountItem", htValues);
		}
		

		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(null, stmt, null);	
		}
		
	}

	public boolean delete(Object obj) {
		return false;
	}

	public InvCount find(Connection con, InvCount invCount) throws SQLException {
		
		InvCount result = null;
		
		String sql = "SELECT C.IDCount , C.IDStore, C.CountType " +
					 "FROM Inv_Count C " +
					 "WHERE C.IDStore = " + invCount.idstore + " and C.CountType = " + invCount.counttype + " and C.EndDate is null";
		
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()){
				result = new InvCount();
				load(rs, result);
				load(rs, invCount);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, null);	
		}
		
		return result;
	}
	
	private void load(ResultSet rs, InvCount invcount) throws SQLException{
		invcount.idcount = rs.getInt("IDCount");
		invcount.idstore = rs.getInt("IDStore");
		invcount.counttype = rs.getInt("CountType");
	}
	
	private boolean findInvCountItem(Connection con, InvCountItem invCountItem) throws SQLException{
		boolean result = false;
		
		String sql = "SELECT IDCountItem FROM Inv_CountItem " +
					 "WHERE Barcode = '" + invCountItem.barcode + "' AND IDCount = " + invCountItem.idcount;
		
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
				result = true;
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, null);	
		}
		
		return result;
	}

	public InvCount getOpenCounting(int countType) {
		// TODO Auto-generated method stub
		return null;
	}

	public void deleteGarbageCount(InvCount invCount) {
		// TODO Auto-generated method stub
		
	}

	
}
