package com.mainretail.commun.model.inventory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;



public class ModelDAOMSSQL implements IModelDAO {

	private void loadRS(ResultSet rs, Model model) throws SQLException	{
		try{
			model.idmodel = rs.getInt("IDModel");
			model.idcategory = rs.getInt("GroupID");	
			model.idsubcategory = rs.getInt("IDModelGroup");
			model.idgroup = rs.getInt("IDModelSubGroup");
			model.description = rs.getString("Description");			
			model.vendorcost = rs.getDouble("VendorCost");			
			model.sellingprice = rs.getDouble("SellingPrice");			
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
		}

	}

	public List listAll()  {
		List lista = new ArrayList();
		try {
			subListAll(lista);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public void subListAll(List lista) throws SQLException{
		
		String query;
		String sqlSelect = "SELECT M.IDModel, M.Description, M.VendorCost, M.SellingPrice, M.GroupID, M.IDModelGroup, M.IDModelSubGroup FROM Model M ";
		String sqlWhere = " WHERE M.Desativado = 0 AND M.Hidden = 0 ";
		String sqlOrder = " ORDER BY M.Description ";
		
		query = sqlSelect + sqlWhere + sqlOrder;
		
		
		java.sql.Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs= stmt.executeQuery(query);
			
			while (rs.next()) {
				Model model = new Model();
				loadRS(rs, model);
				lista.add(model);
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

	public List list(Category C) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean createIndexs() {
		// TODO Auto-generated method stub
		return false;
	}

	public Model getModel(int idmodel) {
		// TODO Auto-generated method stub
		return null;
	}

	
}