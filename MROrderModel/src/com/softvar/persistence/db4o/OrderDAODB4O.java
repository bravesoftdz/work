package com.softvar.persistence.db4o;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.softvar.model.order.AccountCost;
import com.softvar.model.order.IOrderDAO;
import com.softvar.model.order.Order;
import com.softvar.model.order.OrderItem;
import com.softvar.model.order.OrderItemView;
import com.softvar.model.order.Product;

public class OrderDAODB4O implements IOrderDAO, IParentDAODB4O {

	public OrderDAODB4O() {
		super();
		// TODO Auto-generated constructor stub
	}

	public List listAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean save(Object obj) {
		try{
			Connection.getInstance().getDatabase().set(obj);
			return true;
		}catch(Throwable t){
			t.printStackTrace();
			return false;
		}
	}

	public boolean delete(Object obj) {
		try{
			Connection.getInstance().getDatabase().delete(obj);
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public ArrayList getFinalizedOrders() {
		ArrayList retorno = new ArrayList();
		
		try {
			ObjectSet objectSet;
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(Order.class);
			query.descend("finalized").constrain(new Boolean(true));
			objectSet = query.execute();
			retorno.addAll(objectSet);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retorno;
		
	}
	
	public Order getOpenOrder() {
		Order result = null;
		try {
			Query query =  Connection.getInstance().getDatabase().query();
			query.constrain(Order.class);
			query.descend("finalized").constrain(new Boolean(false));
			ObjectSet objectSet = query.execute();
			
			if (!objectSet.isEmpty())
				result =(Order)objectSet.next();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public Order get(Order order) {
		Order result = null;
		
		try {
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(Order.class);
			query.descend("creation").constrain(order.creation).and(query.descend("finalized").constrain(new Boolean(order.finalized)));
			ObjectSet objectSet = query.execute();
			
			if (!(objectSet.isEmpty()))
				result = (Order)objectSet.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public void activateIndexes() {
		// TODO Auto-generated method stub
	}
	
	public List getItemView(Order order){
		ArrayList result = new ArrayList();
		try{
			ObjectContainer db = Connection.getInstance().getDatabase(); 
			for(int i = 0; i < order.items.size(); i++){
				OrderItemView oiv = new OrderItemView();
				oiv.orderitem = (OrderItem) order.items.get(i);
				
				Query query = db.query();
				query.constrain(Product.class);
				query.descend("idproduct").constrain(new Integer(oiv.orderitem.idproduct));
				ObjectSet objectSet = query.execute();
				
				if (!objectSet.isEmpty())
					oiv.product = (Product)objectSet.next();
				
				query = db.query();
				query.constrain(AccountCost.class);
				query.descend("idaccount").constrain(new Integer(order.idaccount));
				query.descend("idproduct").constrain(new Integer(oiv.orderitem.idproduct));
				objectSet = query.execute();
				
				if (!objectSet.isEmpty())
					oiv.cost = ((AccountCost)objectSet.next()).cost;
				
				result.add(oiv);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return result;
	}

	public List listAllByDate(Date minDate) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
