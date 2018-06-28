package com.softvar.persistence.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * @author Carlos Lima
 *
 */ 
public class JDBCConnectionFunctions {
	private static final String CONNECTION_POOL_NAME = "java:comp/env/mrpool";

	private static JDBCConnectionFunctions instance;
	private JDBCConnectionFunctions() {}
	
	public static JDBCConnectionFunctions getInstance()
	{
		if (instance == null)
		{
			instance = new JDBCConnectionFunctions(); 
		}
		return instance;
	}

	public java.sql.Connection getConnection() throws SQLException  {
		Connection connection = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds  = (DataSource)ctx.lookup(CONNECTION_POOL_NAME);

			if (ds == null)
				throw new Exception ("Error: Create data source in the pool of connection");
			if (ds != null){
				connection = ds.getConnection();
			}
		    else {
		    	System.out.println("Erro ds = null");
		    }
			
		} catch (Exception e) {				
			e.printStackTrace();
		}
		connection.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
		return connection;
	  }

	public boolean executeSQL(String sql) {
		boolean result;
		PreparedStatement st;
        
		try {
			st = getConnection().prepareStatement(sql);
			st.executeUpdate(sql);
			st.close();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}            
		return result;
    }

	public void closeConnection(ResultSet rs, Statement stmt, Connection conn) {

		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e){
				e.printStackTrace(); 
			}
		
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException e){
				e.printStackTrace(); 
			}
		
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException e){
				e.printStackTrace(); 
			}
	}

	public void startTransaction(Connection conn) throws SQLException	{
		conn.setAutoCommit(false);
	}
	
	public void commitTransaction(Connection conn) throws SQLException	{
		conn.commit();
	}
	
	public void rollbackTransaction(Connection conn) throws SQLException	{
		conn.rollback();
	}	
}