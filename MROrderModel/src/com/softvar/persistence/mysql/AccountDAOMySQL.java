package com.softvar.persistence.mysql;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.softvar.model.order.Account;
import com.softvar.model.order.IAccountDAO;
import com.softvar.persistence.jdbc.JDBCConnectionFunctions;

public class AccountDAOMySQL extends DAOMySQL implements IAccountDAO {

	public AccountDAOMySQL() {
		super();
		// TODO Auto-generated constructor stub
	}

	public boolean save(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	public void saveAsChield(Connection con, Object obj) throws SQLException {
		// TODO Auto-generated method stub

	}

	public boolean find(Connection con, Object object, Object pk)
			throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}
	
	public List listAll(){
		return listAllByDate(null);
	}

	public Account getByAccountNum(String accountNum) {
		return null;
	}

	public List listAllByDate(Date minDate) {
		String sql;
		if (minDate == null)
			sql = "SELECT idaccount, accountnum, accountname from account order by accountnum";
		else
			sql = "SELECT idaccount, accountnum, accountname from account WHERE lastUpdate > " + "'" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(minDate) + "'" +  " order by accountnum";
		

		ArrayList result = new ArrayList();
		
		try {
			Connection con = JDBCConnectionFunctions.getInstance().getConnection();
			
			try {
				Statement stm = con.createStatement();
				
				try {
					ResultSet rs = stm.executeQuery(sql);
					
					try {
						while (rs.next()){
							
							Account a = new Account();
							a.idaccount = rs.getInt("idaccount");
							a.accountnum = rs.getString("accountnum");
							a.accountname = rs.getString("accountname");
							result.add(a);
						}
					} finally {
						rs.close();
						rs = null;
					}
				} finally {
					stm.close();
					stm = null;
				}
			} finally {
				con.close();
				con = null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
