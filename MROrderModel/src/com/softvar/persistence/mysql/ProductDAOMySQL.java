package com.softvar.persistence.mysql;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.softvar.model.order.IProductDAO;
import com.softvar.model.order.Product;
import com.softvar.persistence.jdbc.JDBCConnectionFunctions;

public class ProductDAOMySQL extends DAOMySQL implements IProductDAO {

	public ProductDAOMySQL() {
		super();
		// TODO Auto-generated constructor stub
	}

	public boolean save(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	public void saveAsChield(Connection con, Object obj) throws SQLException {
		// TODO Auto-generated method stub

	}

	public boolean find(Connection con, Object object, Object pk)
			throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}
	
	public List listAll(){
		return listAllByDate(null);
	}

	public Product findByUPC(String UPC) {
		// TODO Auto-generated method stub
		return null;
	}

	public List listAllByDate(Date minDate) {
		String sql;
		if (minDate == null)
			sql = "SELECT idproduct, UPC, description from product order by UPC";
		else
			sql = "SELECT idproduct, UPC, description from product WHERE lastupdate > "+ "'" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(minDate) + "'" + "order by UPC ";

		ArrayList result = new ArrayList();
		
		try {
			Connection con = JDBCConnectionFunctions.getInstance().getConnection();
			
			try {
				Statement stm = con.createStatement();
				
				try {
					ResultSet rs = stm.executeQuery(sql);
					
					try {
						while (rs.next()){
							Product p = new Product();
							p.idproduct = rs.getInt("idproduct");
							p.UPC = rs.getString("UPC");
							p.description = rs.getString("description");
							result.add(p);
						}
					} finally {
						rs.close();
						rs = null;
					}
				} finally {
					stm.close();
					stm = null;
				}
			} finally {
				con.close();
				con = null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	

}
