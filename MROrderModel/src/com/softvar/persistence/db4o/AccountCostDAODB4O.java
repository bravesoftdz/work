package com.softvar.persistence.db4o;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.softvar.model.order.Account;
import com.softvar.model.order.AccountCost;
import com.softvar.model.order.IAccountCostDAO;

public class AccountCostDAODB4O implements IParentDAODB4O, IAccountCostDAO {

	public AccountCostDAODB4O() {
		super();
		// TODO Auto-generated constructor stub
	}

	public List listAll() {
		ArrayList retorno = new ArrayList();		
		try {
			ObjectSet objectSet;
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(AccountCost.class);			
			objectSet = query.execute();
			retorno.addAll(objectSet);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retorno;
	}

	public boolean save(Object obj) {
		try{
			Connection.getInstance().getDatabase().set(obj);
			Connection.getInstance().getDatabase().ext().purge(obj);
			Connection.getInstance().getDatabase().deactivate(obj, 5);
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

	public List listByAccount(Account account) {
		ArrayList retorno = new ArrayList();
		if (account != null)
			try {
				ObjectSet objectSet;
				Query query = Connection.getInstance().getDatabase().query();
				query.constrain(AccountCost.class);
				query.descend("idproduct").orderAscending();
				query.descend("idaccount").constrain(new Integer(account.idaccount));
				objectSet = query.execute();
				retorno.addAll(objectSet);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return retorno;
	}

	public void activateIndexes() {
		Query query;
		try{
			query = Connection.getInstance().getDatabase().query();
			query.constrain(AccountCost.class);
			query.descend("idaccount").constrain(new Integer(-1));		
			query.execute();
		} catch (Exception e) {
		e.printStackTrace();
		}
		
	}

	public List listByAccounts(Account[] accounts) {
		// TODO Auto-generated method stub
		return null;
	}

	public AccountCost getAccountCost(int idaccount, int idproduct) {
		AccountCost retorno = null;
		
		try {
			Query query = Connection.getInstance().getDatabase().query();
		
			query.constrain(AccountCost.class);
			query.descend("idaccount").constrain(new Integer(idaccount));
			query.descend("idproduct").constrain(new Integer(idproduct));
			ObjectSet objectSet = query.execute();
			if (!objectSet.isEmpty())
				retorno = (AccountCost)objectSet.next();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return retorno;
		}

	public List listAllByDate(Date minDate) {
		// TODO Auto-generated method stub
		return null;
	}

}
