package com.mainretail.commun.model.inventory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mainretail.commun.model.ConnectionFunctions;

public class BarcodeDAOMSSQL implements IBarcodeDAO {
	
	public List listAll() {
		List lista = new ArrayList();
		try {
			subListAll(lista);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}

	public boolean save(Object obj) {
		return false;
	}

	public boolean delete(Object obj) {
		return false;
	}

	public void subListAll(List lista) throws SQLException{
		
		String query;
		String sqlSelect = "SELECT	B.IDModel, B.IDBarcode, B.BarcodeOrder FROM Barcode B INNER JOIN Model M ON (M.IDModel = B.IDModel) WHERE M.Desativado = 0 ";
		String sqlOrder = " ORDER BY B.IDModel, B.IDBarcode ";
		
		query = sqlSelect + sqlOrder;
		
		Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs= stmt.executeQuery(query);
			
			while (rs.next()) {
				Barcode barcode = new Barcode();
				loadRS(rs, barcode);
				lista.add(barcode);
			} 
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);
			con = null;
			rs= null;
			stmt = null;
		}
	}
	
	private void loadRS(ResultSet rs, Barcode barcode) throws SQLException {
		try{
			barcode.idbarcode = rs.getString("IDBarcode").trim();
			barcode.idmodel = rs.getInt("IDModel");
			barcode.barcodeOrder = rs.getInt("BarcodeOrder");
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
		}

	}

	public Barcode getBarcode(String idbarcode) {
		return null;
	}


}
