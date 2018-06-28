package com.mainretail.commun.model.purchase;

import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.IParentDAODB4O;

public class ReceivingDAODB4O implements IReceivingDAO, IParentDAODB4O {

	public List listAll() {
		ObjectSet cont = Connection.getInstance().getDatabase().query(Receiving.class);
		java.util.ArrayList lista = new java.util.ArrayList();
		lista.addAll(cont);
		return lista;
	}

	public boolean save(Object obj) {
		try{
			Receiving receiving = (Receiving)obj;
			Connection.getInstance().getDatabase().delete(receiving);
			Connection.getInstance().getDatabase().set(receiving);
			Connection.getInstance().getDatabase().commit();			
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public boolean delete(Object obj) {
		try{
			Receiving receiving = (Receiving)obj;
			Connection.getInstance().getDatabase().delete(receiving);
			Connection.getInstance().getDatabase().commit();			
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public void activateIndexes() {
		// TODO Auto-generated method stub
	}

	public Receiving importPO(String idPO) {
		return null;
	}
	
	public Receiving getActiveReceiving() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(Receiving.class);
		ObjectSet result = query.execute();
		if (result.isEmpty())
			return null;
		else
			return (Receiving)result.next();
	}
	

}
