package com.mainretail.commun.model.sale;

import java.util.ArrayList;
import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.IParentDAODB4O;

public class SaleDAODB4O implements ISaleDAO, IParentDAODB4O {

	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		try{
			Sale sale = (Sale)obj;
			Connection.getInstance().getDatabase().delete(sale);
			Connection.getInstance().getDatabase().set(sale);
			Connection.getInstance().getDatabase().commit();
			return true;
		}catch(Throwable t){
			t.printStackTrace();
			return false;
		}		
	}

	public boolean delete(Object obj) {
		try{
			Sale sale = (Sale)obj;
			Connection.getInstance().getDatabase().delete(sale);
			Connection.getInstance().getDatabase().commit();
			return true;
		}catch(Throwable t){
			return false;
		}
		
	}

	public Sale getOpenSale() {
		Query query =  Connection.getInstance().getDatabase().query();
		query.constrain(Sale.class);
		query.descend("finalized").constrain(new Boolean(false));
		ObjectSet objectSet = query.execute();
		
		if (objectSet.isEmpty())
			return null;
		else
			return (Sale)objectSet.next();
	}

	public ArrayList getFinalizedSales() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Sale.class);
		query.descend("finalized").constrain(new Boolean(true));
		ObjectSet objectSet = query.execute();
		
		ArrayList retorno = new ArrayList();
		retorno.addAll(objectSet);
		return retorno;
		
	}
	
	public Sale get(Sale sale) {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Sale.class);
		query.descend("idstore").constrain(new Integer(sale.idstore)).and(query.descend("saleDate").constrain(sale.saleDate).and(query.descend("finalized").constrain(new Boolean(sale.finalized))));
		ObjectSet objectSet = query.execute();
		
		if (objectSet.isEmpty())
			return null;
		else
			return (Sale)objectSet.next();
		
	}

	public void activateIndexes() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Sale.class);
		query.descend("salecode").constrain("");
		query.execute();
	}

}
