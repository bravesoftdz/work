package com.mainretail.commun.model;

import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.inventory.Model;

public class ServerParameterDAODB4O implements IServerParameterDAO, IParentDAODB4O {

	public Object getParameterValue(int index) {
		ServerParameter obj = getServerParameter(index);
		if (obj == null)
			return null;
		else
			return obj.srvvalue;
	}

	public ServerParameter getServerParameter(int index) {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(ServerParameter.class);
		Integer proto = new Integer(index);
		query.descend("idparam").constrain(proto);
		ServerParameter result = null;
		ObjectSet objectSet = query.execute();
		if (!objectSet.isEmpty())
			result = (ServerParameter)objectSet.next(); 
		return result;
	}

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

	public void activateIndexes() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(ServerParameter.class);
		query.descend("idparam").constrain(new Integer(-1));
		query.execute();
	}

}
