package com.mainretail.commun.model;

import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;




public class UserDAODB4O implements IUserDAO, IParentDAODB4O {
	
	public User validateUser(String pw) {
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(User.class);
			query.descend("pw").constrain(pw);
			ObjectSet result = query.execute();
			
			if (! result.isEmpty()){
				return (User) result.next();
			} else {
				return null;
			}
			
	}

	public List listAll() {
		ObjectSet cont = Connection.getInstance().getDatabase().query(User.class);
		java.util.ArrayList lista = new java.util.ArrayList();
		lista.addAll(cont);
		return lista;
	}

	public boolean save(Object obj) {
		try{
			Connection.getInstance().getDatabase().set(obj);
			Connection.getInstance().getDatabase().ext().purge(obj);
			Connection.getInstance().getDatabase().deactivate(obj, 5);
		}catch(Throwable t){
			return false;
		}
		return true;
	}

	public boolean delete(Object obj) {
		try{
			Connection.getInstance().getDatabase().delete(obj);
		}catch(Throwable t){
			return false;
		}
		return true;
	}

	public void activateIndexes() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(User.class);
		query.descend("username").constrain("");
		query.execute();
	}


}
