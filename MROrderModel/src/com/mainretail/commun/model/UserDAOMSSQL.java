package com.mainretail.commun.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAOMSSQL implements IUserDAO {

	public User validateUser(String pw) {
		return null;
	}

	private void loadRS(ResultSet rs, User user) throws SQLException {
		try{
			user.iduser = rs.getInt("IDUser");
			user.idcommission = rs.getInt("ComissionID");			
			user.username = rs.getString("SystemUser");
			user.pw = rs.getString("PW");
			user.idusertype = rs.getInt("UserTypeID");
						
		}catch (Throwable t){
			t.printStackTrace();
			throw new SQLException(t.getMessage());
			
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
	
	
	public void subListAll(List lista) throws SQLException{
		
		String query;
		String sqlSelect = "SELECT U.IDUser, U.SystemUser, U.ComissionID, U.PW, U.UserTypeID FROM SystemUser U ";
		String sqlWhere = " WHERE U.Desativado = 0 AND U.Hidden = 0 AND U.ComissionID IS NOT NULL ";
		String sqlOrder = " ORDER BY U.SystemUser ";
		
		query = sqlSelect + sqlWhere + sqlOrder;
		
		Connection con = null;
		ResultSet rs= null;
		Statement stmt = null;
		try {
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs= stmt.executeQuery(query);
			
			while (rs.next()) {
				User user = new User();
				loadRS(rs, user);
				lista.add(user);
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
		return false;
	}

	public boolean delete(Object obj) {
		return false;
	}


}
