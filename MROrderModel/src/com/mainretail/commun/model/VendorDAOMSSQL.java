package com.mainretail.commun.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class VendorDAOMSSQL implements IVendorDAO {

	public List listAll() {
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
		String sqlSelect = " SELECT P.IDPessoa, P.Pessoa ";
		String sqlFrom	 = " FROM Pessoa P JOIN TipoPessoa TP ON (P.IDTipoPessoa = TP.IDTipoPessoa) ";
		String sqlWhere  = " WHERE Path like '.002%' ";
		String sqlOrder  = " ORDER BY P.Pessoa ";
		
		query = sqlSelect + sqlFrom + sqlWhere + sqlOrder;
		
		Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				Vendor vendor = new Vendor();
				loadRS(rs, vendor);
				lista.add(vendor);
			} 
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);
			con = null;
			rs= null;
			stmt = null;
		}
	}
	
	
	private void loadRS(ResultSet rs, Vendor vendor) throws SQLException {
		try{
			vendor.idvendor = rs.getInt("IDPessoa");
			vendor.vendor = rs.getString("Pessoa");			
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
			
		}

	}
	
	
	public boolean save(Object obj) {
		return false;
	}

	public boolean delete(Object obj) {
		return false;
	}

}
