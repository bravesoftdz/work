package com.mainretail.handheldserver;

import java.sql.*;

import com.mainretail.handheld.User;
import com.mainretail.handheldserver.util.ConnectionFunctions;

public class UserEEDAOMSSQL implements UserEEDAO {

	// TODO criar singleton
	public UserEEDAOMSSQL() {
		super();
		
	}

	public User findUser(String pw) throws SQLException {
		User user  = new User();

		String sql = "SELECT IDUser, UserTypeId, ComissionID, SystemUser, PW, System, Desativado, Hidden, CodSystemUser, StoresAccess, ContadorClasse FROM SystemUser WHERE PW = '" + pw + "'";

		Connection con = null;
		ResultSet rs   = null;
		Statement stmt = null;

		try {
		
			con= ConnectionFunctions.getInstance().getConnection();
			stmt = con.createStatement();
			rs= stmt.executeQuery(sql);

			if (rs.next())
			{
			
				load(rs,user);
				
			}
		}
		finally {
			
			ConnectionFunctions.getInstance().closeConnection(rs,stmt,con);
			
		}
		
		return user;
	
	}
	
	private void load(ResultSet rs, User user) throws SQLException 
	{
		user.iduser     	= rs.getInt("IDUser");
		user.usertypeid 	= rs.getInt("UserTypeId");
		user.comissionid 	= rs.getInt("ComissionID");
		user.systemuser 	= rs.getString("SystemUser");
		user.pw         	= rs.getString("PW");
		user.system         = rs.getString("System");
		user.desativado     = rs.getString("Desativado");
		user.hidden         = rs.getString("Hidden");
		user.codsystemuser  = rs.getString("CodSystemUser");
		user.storesaccess   = rs.getString("StoresAccess");
		user.contadorclasse = rs.getString("ContadorClasse");
		
	}

	

}
