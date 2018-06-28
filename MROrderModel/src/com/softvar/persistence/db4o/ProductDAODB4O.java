package com.softvar.persistence.db4o;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.softvar.model.order.IProductDAO;
import com.softvar.model.order.Product;

public class ProductDAODB4O implements IParentDAODB4O, IProductDAO {

	public ProductDAODB4O() {
		super();
	}

	public List listAll() {
		ArrayList retorno = new ArrayList();		
		try {
			ObjectSet objectSet;
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(Product.class);			
			objectSet = query.execute();
			retorno.addAll(objectSet);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retorno;
	}

	public boolean save(Object obj) {
		try{
			ObjectContainer db = Connection.getInstance().getDatabase();
			
			/*
			Query query = db.query();
			query.constrain(Product.class);
			query.descend("idproduct").constrain(new Integer(((Product)obj).idproduct));
			ObjectSet objectSet = query.execute();
			if (!objectSet.isEmpty()) {
				long id = db.ext().getID(objectSet.next());
				db.ext().bind(obj, id);
			}
			*/
			
			
			
			db.set(obj);
			db.ext().purge(obj);
			db.deactivate(obj, 5);
			return true;
		}catch(Throwable t){
			t.printStackTrace();
			return false;
		}
	}

	public boolean delete(Object obj) {
		try{
			Connection.getInstance().getDatabase().delete(obj);
			Connection.getInstance().getDatabase().ext().purge(obj);
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public void activateIndexes() {
		Query query;
		try{
			query = Connection.getInstance().getDatabase().query();
			query.constrain(Product.class);
			query.descend("UPC").constrain("");		
			query.execute();
		} catch (Exception e) {
		e.printStackTrace();
		}
		
	}

	public Product findByUPC(String UPC) {
		Product result = null;
		try {
			Query query;
			query = Connection.getInstance().getDatabase().query();			
			query.constrain(Product.class);
			query.descend("UPC").constrain(UPC);		
			ObjectSet objectSet = query.execute();		
			if (!objectSet.isEmpty())
				result = (Product)objectSet.next();
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
