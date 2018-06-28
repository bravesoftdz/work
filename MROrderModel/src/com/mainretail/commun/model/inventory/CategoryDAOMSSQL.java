package com.mainretail.commun.model.inventory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;

public class CategoryDAOMSSQL implements ICategoryDAO {

	public List listAll()  {
		List lista = new ArrayList();
		try {
			subListAll(lista);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	private void loadRS(ResultSet rs, Category category) throws SQLException {
		try{
			category.id = rs.getInt("IDFinal");
			category.type = rs.getInt("IDType");
			category.category = rs.getString("Name");
						
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
			
		}

	}
	
	public void subListAll(List lista) throws SQLException{
		
		String query;
		String sqlSelect = "SELECT	IDFinal, IDType, Name FROM vwCategoryTree";
		String sqlWhere = " WHERE Desativado = 0 AND Hidden = 0 ";
		String sqlOrder = " ORDER BY FullName ";
		
		query = sqlSelect + sqlWhere + sqlOrder;
		
		Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs= stmt.executeQuery(query);
			int i = 0;
			while (rs.next()) {
				Category category = new Category();
				category.order = ++i;
				loadRS(rs, category);
				lista.add(category);
			} 
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);
			con = null;
			rs= null;
			stmt = null;
		}
	}

	public boolean save(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean delete(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	

}
