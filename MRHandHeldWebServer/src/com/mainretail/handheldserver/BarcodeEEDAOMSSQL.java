package com.mainretail.handheldserver;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ParameterList;
import com.mainretail.handheldserver.util.ConnectionFunctions;

public class BarcodeEEDAOMSSQL implements BarcodeEEDAO {

	private static BarcodeEEDAOMSSQL instance;
	private BarcodeEEDAOMSSQL() {}
	
	public static BarcodeEEDAOMSSQL getInstance()
	{
		if (instance == null)
		{
			instance = new BarcodeEEDAOMSSQL(); 
		}
		return instance;		
	}

	public Barcode searchBarcode(Barcode barcode) throws SQLException {
		return searchBarcode(barcode.idbarcode);
	}
	
	public Barcode searchBarcode(String idbarcode) throws SQLException {
		
		Barcode barcode = new Barcode();
		Model model = new Model();
		
		barcode.model = model;  
		barcode.model.barcode = idbarcode;
		barcode.idbarcode = idbarcode;
		
		String sqlSelect = " SELECT M.IDModel, M.GroupID, B.Data, Model, Description, IDBarcode, VendorCost, SellingPrice, SuggRetail " +
		 			 " FROM Model M JOIN Barcode B ON (B.IDModel = M.IDModel) ";
		String sqlWhere = " WHERE IDBarcode='" + barcode.idbarcode + "'";
		
		Connection con = null;
		ResultSet rs   = null;
		Statement stmt = null;
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sqlSelect + sqlWhere);
			if (rs.next())
			{
				load(rs,barcode);
			}else {
				int barcodeType = getBarcodeSearchType();
				if ((barcodeType != 0) && (barcode.idbarcode.length() >= getMinBarcodeLengthParamValue())){
					switch (barcodeType) {
					// Retira primeiro caracter
					case 1:{
						sqlWhere = " WHERE IDBarcode='" + barcode.idbarcode.substring(1, barcode.idbarcode.length()) + "'";
						break;
					}
					
					// Retira último caracter
					case 2:{
						sqlWhere = " WHERE IDBarcode='" + barcode.idbarcode.substring(0, barcode.idbarcode.length() - 1) + "'";
						break;
					}
					
					// Retira primeiro e ultimo
					case 3:{
						sqlWhere = " WHERE IDBarcode='" + barcode.idbarcode.substring(1, barcode.idbarcode.length() - 1) + "'";
						break;
					}
					
					default:{
						sqlWhere = " WHERE IDBarcode='" + barcode.idbarcode.substring(1, barcode.idbarcode.length() - 1) + "'";
					}
					}
					
					rs = stmt.executeQuery(sqlSelect + sqlWhere);
					
					if (rs.next()) {
						load(rs,barcode);
					
					
					}
				}
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs,stmt,con);	
		}
		return barcode;
	}
	
	private int getBarcodeSearchType() throws SQLException {
		ParameterListEEDAO parameterListEEDAO = ParameterListEEDAOFactory.getParameterListDAO(ParameterListEEDAOFactory.DATABASE_SLQSERVER);
		ParameterList parameterList = parameterListEEDAO.getParameterList();		
		return parameterList.getIntegerValueAt(ParameterList.PARAM_REMOVE_BARCODE_DIGIT).intValue();
	}

	private void load(ResultSet rs, Barcode barcode) throws SQLException 
	{
		try{
							
			barcode.idbarcode = rs.getString("IDBarcode");
			barcode.data = rs.getDate("Data");
			barcode.model.idmodel = rs.getInt("IDModel");
			barcode.model.barcode = rs.getString("IDBarcode");
			barcode.model.description = rs.getString("Description");
			barcode.model.model = rs.getString("model");
			barcode.model.idgroup = rs.getInt("GroupID");
			barcode.model.vendorcost = rs.getDouble("VendorCost");
			barcode.model.suggretail = rs.getDouble("SuggRetail");
			barcode.model.sellingprice = rs.getDouble("SellingPrice");
					
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
			
		}

	}
	
	private int getMinBarcodeLengthParamValue() throws SQLException {
		ParameterListEEDAO parameterListEEDAO = ParameterListEEDAOFactory.getParameterListDAO(ParameterListEEDAOFactory.DATABASE_SLQSERVER);
		ParameterList parameterList = parameterListEEDAO.getParameterList();		
		return parameterList.getIntegerValueAt(ParameterList.PARAM_MIN_BARCODE_LENGTH).intValue();
	}

}
