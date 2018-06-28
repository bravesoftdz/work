package com.softvar.persistence.mysql;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import com.softvar.model.Customer;
import com.softvar.persistence.jdbc.JDBCConnectionFunctions;
import com.softvar.persistence.jdbc.SQLFunctions;

public class CustomerDAOMySQL extends DAOMySQL  {
	
	public boolean save(Object obj) {
		boolean result = true;
		Connection con;
		try {
			con = JDBCConnectionFunctions.getInstance().getConnection();
			try{
				con.setAutoCommit(false);
				try{
					saveAsChield(con, obj);
					
				} catch (Exception e) {
					con.rollback();
					throw e;
				}
				con.commit();
				
			}		
			finally{
				con.close();
			}
			
		} catch (Exception e) {
			result = false;
			e.printStackTrace();
		}

		return result;
	}
	
	private void saveCustomer(Connection con, Customer customer) throws SQLException {
		int idcustomer = getNextCodeDAO().getNextCode(con, customer.getClass());
		customer.idcustomer = idcustomer;
		
		Hashtable ht = new Hashtable();
		try{
			ht.put("idcustomer", new Integer(customer.idcustomer));
			ht.put("customer", customer.customer);

			String sql = SQLFunctions.getInstance().hashTableToSQLInsert("customer", ht);
			
			Statement stm = con.createStatement();
			try {
				stm.execute(sql);			
			} finally {
				stm.close();
				stm = null;
			}			
		} finally{
			ht = null;
		}

	}
	
	public boolean customerExists(Connection con, Customer customer) throws SQLException{
		boolean result;
		
		String sql = "SELECT customer FROM customer WHERE idcustomer = '" + customer.idcustomer + "'";
		
		Statement stm = con.createStatement();
		try{
			ResultSet rs = stm.executeQuery(sql);
			try{
				result = rs.next();
				if (result)
					customer.customer = rs.getString("customer");
			}
			finally{
				rs.close();
				rs = null;
			}			
		}finally{
			stm.close();
			stm = null;
		}
		return result;		
	}
	



	public void saveAsChield(Connection con, Object obj) throws SQLException {		
		Customer customer = (Customer)obj;
		saveCustomer(con, customer);	
	}

	public boolean find(Connection con, Object object, Object pk) throws SQLException {
		boolean result;
		Customer customer = (Customer)object;
		String sql = "SELECT customer FROM customer WHERE idcustomer = '" + customer.idcustomer + "'";
		
		Statement stm = con.createStatement();
		try{
			ResultSet rs = stm.executeQuery(sql);
			try{
				result = rs.next();
				if (result)
					customer.customer = rs.getString("customer");
			}
			finally{
				rs.close();
				rs = null;
			}			
		}finally{
			stm.close();
			stm = null;
		}
		return result;		
	}

	public List listAllByDate(Date minDate) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
