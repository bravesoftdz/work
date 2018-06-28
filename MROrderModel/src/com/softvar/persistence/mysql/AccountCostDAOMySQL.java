package com.softvar.persistence.mysql;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.softvar.model.order.Account;
import com.softvar.model.order.AccountCost;
import com.softvar.model.order.IAccountCostDAO;
import com.softvar.persistence.jdbc.JDBCConnectionFunctions;

public class AccountCostDAOMySQL extends DAOMySQL implements IAccountCostDAO {

	public AccountCostDAOMySQL() {
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
	
	public List listAccounts(String sql){
		ArrayList result = new ArrayList();
		
		try {
			Connection con = JDBCConnectionFunctions.getInstance().getConnection();
			
			try {
				Statement stm = con.createStatement();
				
				try {
					ResultSet rs = stm.executeQuery(sql);					
					try {
						while (rs.next()){							
							AccountCost ac = new AccountCost();
							ac.idproduct = rs.getInt("idproduct");
							ac.idaccount = rs.getInt("idaccount");		
							ac.cost = rs.getDouble("cost");
							result.add(ac);
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
	
	
	public List listByAccounts(Account[] accounts){
		String in = " idaccount in ( ";
		for(int i = 0; i < accounts.length; i++){
			in += accounts[i].idaccount;
			if (i == (accounts.length - 1))
				in += " ) ";
			else
				in += ", ";
		}
		String sql = "SELECT idproduct, idaccount, cost from accountcost WHERE " + in + " ORDER BY idaccount, idproduct";
		return listAccounts(sql);
	}
	
	public List listByAccount(Account account){
		String sql = "SELECT idproduct, idaccount, cost from accountcost WHERE idaccount = " + account.idaccount + " ORDER BY idaccount, idproduct";
		return listAccounts(sql);
	}

	public List listAll() {
		String sql = "SELECT idproduct, idaccount, cost from accountcost ORDER BY idaccount, idproduct";
		return listAccounts(sql);
		
	}

	public AccountCost getAccountCost(int idaccount, int idproduct) {
		// TODO Auto-generated method stub
		return null;
	}

	public List listAllByDate(Date minDate) {
		// TODO Auto-generated method stub
		return null;
	}

}
