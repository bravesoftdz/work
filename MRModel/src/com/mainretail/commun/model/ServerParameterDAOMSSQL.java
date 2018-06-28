package com.mainretail.commun.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ServerParameterDAOMSSQL implements IServerParameterDAO {

	public Object getParameterValue(int index) {
		ServerParameter result = getServerParameter(index);
		if (result != null){
			return result.srvvalue;
		}
		else
			return null;
	}

	public ServerParameter getServerParameter(int index) {
		try {
			return subGetServerParameter(index);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

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
	
	private void loadRS(ResultSet rs, ServerParameter serverParameter) throws SQLException	{
		try{
			serverParameter.idparam = rs.getInt("IDParam");
			
			String srvType = rs.getString("SrvType").trim();
			
			if (srvType.equals(STRING_PARAMETER)) {
				serverParameter.srvvalue = new String(rs.getString("SrvValue"));
				serverParameter.defaulvalue = new String(rs.getString("DefaultValue"));
			} else if (srvType.equals(INTEGER_PARAMETER)) {
				serverParameter.srvvalue = new Integer(rs.getInt("SrvValue"));
				serverParameter.defaulvalue = new Integer(rs.getInt("DefaultValue"));					
			} else if (srvType.equals(BOOLEAN_PARAMETER)) {
				serverParameter.srvvalue = new Boolean(rs.getBoolean("SrvValue"));
				serverParameter.defaulvalue = new Boolean(rs.getBoolean("DefaultValue"));		
			} else if (srvType.equals(FLOAT_PARAMETER)) {
				serverParameter.srvvalue = new Double(rs.getDouble("SrvValue"));
				serverParameter.defaulvalue = new Double(rs.getDouble("DefaultValue"));								
			}
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
		}

	}
	
	private ServerParameter subGetServerParameter(int idparam) throws SQLException{
		
		ServerParameter result = new ServerParameter();
		
		String query;
		String sqlSelect = "SELECT P.IDParam, P.SrvType, P.DefaultValue, P.SrvValue FROM Param P ";
		String sqlWhere = " WHERE P.Desativado = 0 AND idparam = " + idparam;
		
		query = sqlSelect + sqlWhere;
		
		java.sql.Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs= stmt.executeQuery(query);
			
			if (rs.next()){
				loadRS(rs, result);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);
			con = null;
			rs= null;
			stmt = null;
		}
		return result;
	}
	
	
	public void subListAll(List lista) throws SQLException{
		
		String query;
		String sqlSelect = "SELECT P.IDParam, P.SrvType, P.DefaultValue, P.SrvValue FROM Param P ";
		String sqlWhere = " WHERE P.Desativado = 0 ";
		String sqlOrder = " ORDER BY P.idparam ";
		
		query = sqlSelect + sqlWhere + sqlOrder;
		
		
		java.sql.Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs= stmt.executeQuery(query);
			
			while (rs.next()) {
				ServerParameter serverParameter = new ServerParameter();
				loadRS(rs, serverParameter);
				lista.add(serverParameter);
			} 
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);
			con = null;
			rs= null;
			stmt = null;
		}
	}

}
