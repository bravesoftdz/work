package com.mainretail.handheldserver.salesservlet;

import java.sql.*;


import com.mainretail.handheld.sales.PreSaleItem;
import com.mainretail.handheldserver.util.ConnectionFunctions;
import com.mainretail.handheldserver.util.SQLFunctions;


public class PreSaleItemEEDAOMSSQL implements PreSaleItemEEDAO {
	
	private static PreSaleItemEEDAOMSSQL instance;
	private PreSaleItemEEDAOMSSQL() {}
	
	public static PreSaleItemEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new PreSaleItemEEDAOMSSQL(); 
		}
		return instance;		
	}

	public void save(PreSaleItem presaleitem) throws SQLException {
		
		Connection con = null;
		CallableStatement spAddItem = null;
							
		try {
			presaleitem.iddepartment = 0;
			
			con = ConnectionFunctions.getInstance().getConnection();
			spAddItem = con.prepareCall("{call sp_PreSale_AddItem(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");	
			
			Timestamp today = SQLFunctions.getInstance().sqlNow();
			
			spAddItem.setInt(1, presaleitem.idpresale);	
			spAddItem.setInt(2, presaleitem.idcliente);
			spAddItem.setInt(3, presaleitem.model.idmodel);
			spAddItem.setInt(4, presaleitem.idstore);
			spAddItem.setInt(5, presaleitem.iduser);
			spAddItem.setInt(6, presaleitem.idcomission);
			spAddItem.setDouble(7, presaleitem.qty);
			spAddItem.setDouble(8, presaleitem.saleprice);
			spAddItem.setDouble(9, presaleitem.costprice);
			spAddItem.setDouble(10, presaleitem.discount);
			spAddItem.setTimestamp(11, today);
			spAddItem.setBoolean(12, presaleitem.resetdiscount);
			spAddItem.setBoolean(13, presaleitem.manager);
			spAddItem.setTimestamp(14, today);
			spAddItem.setInt(15, presaleitem.idpreinvmovexchange);
			spAddItem.setNull(16, Types.INTEGER);
			spAddItem.setInt(17, presaleitem.iddepartment);
			spAddItem.setBoolean(18, presaleitem.promo);
			spAddItem.registerOutParameter(19, Types.INTEGER);
			
			spAddItem.execute();
			
			presaleitem.idpreinventmov = spAddItem.getInt(19);
			
		} finally {
			ConnectionFunctions.getInstance().closeConnection(null, spAddItem, con);	
		}
	}
}
		