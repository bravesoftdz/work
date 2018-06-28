package com.mainretail.commun.model.inventory;

import java.util.ArrayList;
import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.IParentDAODB4O;

public class ModelDAODB4O implements IModelDAO, IParentDAODB4O {

	public List listAll() {
		ObjectSet cont = Connection.getInstance().getDatabase().query(Model.class);
		java.util.ArrayList lista = new java.util.ArrayList();
		lista.addAll(cont);
		return lista;
	}

	public boolean save(Object obj) {
		try{
			Connection.getInstance().getDatabase().set(obj);
			Connection.getInstance().getDatabase().ext().purge(obj);
			Connection.getInstance().getDatabase().deactivate(obj, 5);
			return true;
		}catch(Throwable t){
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

	public List list(Category c) {
		
		ArrayList lista = new ArrayList();
		if (c != null){
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(Model.class);
			
			query.descend("description").orderAscending();
			
			Integer proto = new Integer(c.id);
			
			switch (c.type){
			
			case Category.LEVEL_CATEGORY:{				
				query.descend("idcategory").constrain(proto);
				break;
			}
			case Category.LEVEL_SUBCATEGORY:{
				query.descend("idsubcategory").constrain(proto);
				break;
			}
			case Category.LEVEL_GROUP:{
				query.descend("idgroup").constrain(proto);
				break;
			}
			default:{
				}
			}
			
			ObjectSet cont = query.execute();
			
			lista.addAll(cont);
		}
		return lista;
	}

	public Model getModel(int idmodel) {
		/*
		final int x = idmodel; 
		
		ObjectSet objectSet = Connection.getInstance().getDatabase().query(new Predicate(){
			public boolean match(Model m){
				return (m.idmodel == x);
			}
		});
		
		if (objectSet.isEmpty())
			return null;
		else
			return (Model)objectSet.next();
		*/
		Model result = null;
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Model.class);
		Integer proto = new Integer(idmodel);
		query.descend("idmodel").constrain(proto);
		ObjectSet objectSet = query.execute();
		if (!objectSet.isEmpty())
			result = (Model)objectSet.next(); 
		return result;
		
	}

	public void activateIndexes() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Model.class);
		query.descend("description").constrain("");
		query.execute();
	}
	
}