package com.softvar.persistence.mysql;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import com.softvar.model.Customer;
import com.softvar.model.order.IOrderDAO;
import com.softvar.model.order.Order;
import com.softvar.model.order.OrderItem;
import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.persistence.jdbc.IParentDAOJDBC;
import com.softvar.persistence.jdbc.JDBCConnectionFunctions;
import com.softvar.persistence.jdbc.SQLFunctions;

public class OrderDAOMySQL extends DAOMySQL implements IOrderDAO {

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
		IParentDAOJDBC dao = (IParentDAOJDBC)(DAOUtil.getDAO(Customer.class, IParentDAO.DATABASE_MYSQL));
		if (!dao.find(con, customer, new Integer(customer.idcustomer)))			
			throw new SQLException("Customer not found");
	}
	
	private void saveOrder(Connection con, Order order) throws SQLException {
		
		int idorder = getNextCodeDAO().getNextCode(con, order.getClass());
		order.idorder = idorder;
		
		Hashtable ht = new Hashtable();
		try{
			ht.put("idorder", new Integer(idorder));
			ht.put("idcustomer", new Integer(order.customer.idcustomer));
			ht.put("idaccount", new Integer(order.idaccount));
			ht.put("creation", order.creation);

			String sql = SQLFunctions.getInstance().hashTableToSQLInsert("ordertable", ht);
			
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
	
	private void saveOrderItems(Connection con, Order order, OrderItem item) throws SQLException {
		int iditem = getNextCodeDAO().getNextCode(con, item.getClass());
		item.iditem = iditem;
		
		Hashtable ht = new Hashtable();
		try{
			ht.put("iditem", new Integer(item.iditem));
			ht.put("idorder", new Integer(order.idorder));
			ht.put("idproduct", new Integer(item.idproduct));
			ht.put("qty", new Double(item.qty));

			String sql = SQLFunctions.getInstance().hashTableToSQLInsert("orderitem", ht);
			
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

	public void saveAsChield(Connection con, Object obj) throws SQLException {
		Order order = (Order)obj;
		saveCustomer(con, order.customer);
		saveOrder(con, order);
		for (int i = 0; i < order.items.size(); i++){
			OrderItem item = (OrderItem)(order.items.get(i)); 
			item.idorder = order.idorder;
			saveOrderItems(con, order, item);
		}
	}

	public Order getOpenOrder() {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList getFinalizedOrders() {
		// TODO Auto-generated method stub
		return null;
	}

	public Order get(Order sale) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean find(Connection con, Object object, Object pk) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	public List getItemView(Order order) {
		// TODO Auto-generated method stub
		return null;
	}

	public List listAllByDate(Date minDate) {
		// TODO Auto-generated method stub
		return null;
	}

}
