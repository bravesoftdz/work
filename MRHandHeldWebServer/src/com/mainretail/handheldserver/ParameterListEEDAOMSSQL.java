package com.mainretail.handheldserver;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.mainretail.handheld.ParameterList;
import com.mainretail.handheldserver.util.ConnectionFunctions;



public class ParameterListEEDAOMSSQL implements ParameterListEEDAO {
	
	private static final String STRING_PARAMETER = "String";
	private static final String FLOAT_PARAMETER = "Float";
	private static final String BOOLEAN_PARAMETER = "Boolean";
	private static final String INTEGER_PARAMETER = "Integer";
	
	private static ParameterListEEDAOMSSQL instance;
	private ParameterListEEDAOMSSQL() {}
	
	public static ParameterListEEDAO getInstance()
	{
		if (instance == null)
		{
			instance = new ParameterListEEDAOMSSQL(); 
		}
		return instance;		
	}
	
	public ParameterList getParameterList() throws SQLException {
		ParameterList parameterList = new ParameterList();
		
		String sql;
		
		Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con = ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();

			sql = "SELECT IDParam, SrvValue, DefaultValue, SrvType FROM Param";
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				load(rs, parameterList);
			}
		}
		finally {
			ConnectionFunctions.getInstance().closeConnection(rs, stmt, con);	
		}
		
		
		return parameterList;
	}

	public boolean save(ParameterList parameterList) throws SQLException {
		return false;
	}
	
	private void load(ResultSet rs, ParameterList parameterList) throws SQLException 
	{
		try{
			do {
				com.mainretail.handheld.Parameter p = new com.mainretail.handheld.Parameter();
				
				if (parameterList.parameters == null)
					parameterList.parameters = new Vector();
				
				p.idparam = rs.getInt("IDParam");
				
				String srvType = rs.getString("SrvType").trim();
				
				if (srvType.equals(STRING_PARAMETER)) {
					p.srvvalue = new String(rs.getString("SrvValue"));
					p.defaulvalue = new String(rs.getString("DefaultValue"));
				} else if (srvType.equals(INTEGER_PARAMETER)) {
					p.srvvalue = new Integer(rs.getInt("SrvValue"));
					p.defaulvalue = new Integer(rs.getInt("DefaultValue"));					
				} else if (srvType.equals(BOOLEAN_PARAMETER)) {
					p.srvvalue = new Boolean(rs.getBoolean("SrvValue"));
					p.defaulvalue = new Boolean(rs.getBoolean("DefaultValue"));		
				} else if (srvType.equals(FLOAT_PARAMETER)) {
					p.srvvalue = new Double(rs.getDouble("SrvValue"));
					p.defaulvalue = new Double(rs.getDouble("DefaultValue"));								
				}
				
				parameterList.parameters.add(p);
				
			} while (rs.next());
				
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
			
		}

	}
	
}
