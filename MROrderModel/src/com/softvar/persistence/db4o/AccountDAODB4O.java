package com.softvar.persistence.db4o;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.softvar.model.order.Account;
import com.softvar.model.order.IAccountDAO;

public class AccountDAODB4O implements IParentDAODB4O, IAccountDAO {

	public AccountDAODB4O() {
		super();
		// TODO Auto-generated constructor stub
	}

	public List listAll() {
		ArrayList retorno = new ArrayList();
		
		try {
			ObjectSet objectSet;
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(Account.class);			
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
			query.constrain(Account.class);
			query.descend("idaccount").constrain(new Integer(((Account)obj).idaccount));
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
		try {
			query = Connection.getInstance().getDatabase().query();
			query.constrain(Account.class);
			query.descend("accountnum").constrain("");
			query.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Account getByAccountNum(String accountNum) {
		Account result = null;
		try {
			ObjectSet objectSet;
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(Account.class);
			query.descend("accountnum").constrain(accountNum);
			objectSet = query.execute();
			if (!objectSet.isEmpty())
				result = (Account)objectSet.next();
			
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
