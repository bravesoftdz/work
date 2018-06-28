package com.mainretail.handheldserver;

import java.sql.*;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.ParameterList;
import com.mainretail.handheldserver.util.*;

public class ModelEEDAOMSSQL implements ModelEEDAO {

	private static ModelEEDAOMSSQL instance;
	private ModelEEDAOMSSQL() {}
	
	public static ModelEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new ModelEEDAOMSSQL(); 
		}
		return instance;		
	}

	public Model findByBarCode(String barcode) throws SQLException {

		Model p= new Model(); 
		String sqlSelect = "SELECT M.IDModel, M.GroupID, Model, Description, IDBarcode, VendorCost, SellingPrice, SuggRetail FROM Model M JOIN Barcode B ON (B.IDModel = M.IDModel)";
		
		String sqlWhere = " WHERE IDBarcode='" + barcode + "'";
		
		Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs= stmt.executeQuery(sqlSelect + sqlWhere);
			if (rs.next()) {
				load(rs,p);
			} else { 
				
				int barcodeType = getBarcodeSearchType();
				if ((barcodeType != 0) && (barcode.length() >= getMinBarcodeLengthParamValue())){
					switch (barcodeType) {
					// Retira primeiro caracter
					case 1:{
						sqlWhere = " WHERE IDBarcode='" + barcode.substring(1, barcode.length()) + "'";
						break;
					}
					
					// Retira último caracter
					case 2:{
						sqlWhere = " WHERE IDBarcode='" + barcode.substring(0, barcode.length() - 1) + "'";
						break;
					}
					
					// Retira primeiro e ultimo
					case 3:{
						sqlWhere = " WHERE IDBarcode='" + barcode.substring(1, barcode.length() - 1) + "'";
						break;
					}
					
					default:{
						sqlWhere = " WHERE IDBarcode='" + barcode.substring(1, barcode.length() - 1) + "'";
					}
					}
					
					rs = stmt.executeQuery(sqlSelect + sqlWhere);
					
					if (rs.next()) {
						load(rs,p);
					
					
					}
				}
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs,stmt,con);	
		}
		return p;
	}
	
	private int getBarcodeSearchType() throws SQLException {
		ParameterListEEDAO parameterListEEDAO = ParameterListEEDAOFactory.getParameterListDAO(ParameterListEEDAOFactory.DATABASE_SLQSERVER);
		ParameterList parameterList = parameterListEEDAO.getParameterList();		
		return parameterList.getIntegerValueAt(ParameterList.PARAM_REMOVE_BARCODE_DIGIT).intValue();
	}

	private void load(ResultSet rs, Model p) throws SQLException 
	{
		try{
			p.idmodel = rs.getInt("IDModel");
			p.barcode = rs.getString("IDBarcode");
			p.description = rs.getString("Description");
			p.model = rs.getString("model");
			p.idgroup = rs.getInt("GroupID");
			
			p.vendorcost = rs.getDouble("VendorCost");
			p.suggretail = rs.getDouble("SuggRetail");
			p.sellingprice = rs.getDouble("SellingPrice");
				
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
			
		}

	}

	public void save(Model product) {
	
		if (product.idmodel ==0)
		{
			int newId = 0; //Obtenha aqui o novo idmodel
			
			product.idmodel= newId;
			//faca aqui o insert
		}
		else
		{
			//faca aqui o update	
		}	
	}
	
	private int getMinBarcodeLengthParamValue() throws SQLException {
		ParameterListEEDAO parameterListEEDAO = ParameterListEEDAOFactory.getParameterListDAO(ParameterListEEDAOFactory.DATABASE_SLQSERVER);
		ParameterList parameterList = parameterListEEDAO.getParameterList();		
		return parameterList.getIntegerValueAt(ParameterList.PARAM_MIN_BARCODE_LENGTH).intValue();
	}
}