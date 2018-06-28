package com.mainretail.commun.model.inventory;

import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.IParentDAODB4O;

public class CategoryDAODB4O implements ICategoryDAO, IParentDAODB4O{
	
	public List listAll() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Category.class);
		query.descend("order").orderAscending();
		
		ObjectSet cont = query.execute();
		java.util.ArrayList lista = new java.util.ArrayList();
		lista.addAll(cont);
		return lista;
	}

	public boolean save(Object obj) {
		try{
			Connection.getInstance().getDatabase().set(obj);
		}catch(Throwable t){
			return false;
		}
		return true;
	}

	public boolean delete(Object obj) {
		try{
			Connection.getInstance().getDatabase().delete(obj);
			Connection.getInstance().getDatabase().ext().purge(obj);
		}catch(Throwable t){
			return false;
		}
		return true;
	}

	public void activateIndexes() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Category.class);
		query.descend("category").constrain("");
		query.execute();
	}


}
