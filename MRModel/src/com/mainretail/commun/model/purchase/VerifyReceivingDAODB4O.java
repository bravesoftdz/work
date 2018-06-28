package com.mainretail.commun.model.purchase;

import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.IParentDAODB4O;
import com.mainretail.commun.model.inventory.Model;
import com.mainretail.commun.model.inventory.ModelVerifyQty;

public class VerifyReceivingDAODB4O implements
		IVerifyReceivingDAO, IParentDAODB4O {

	public List listAll() {
		ObjectSet cont = Connection.getInstance().getDatabase().query(Model.class);
		java.util.ArrayList lista = new java.util.ArrayList();
		lista.addAll(cont);
		return lista;
	}

	public boolean save(Object obj) {
		try{
			VerifyReceiving verifyReceiving = (VerifyReceiving)obj;
			Connection.getInstance().getDatabase().delete(verifyReceiving);
			Connection.getInstance().getDatabase().set(verifyReceiving);
			Connection.getInstance().getDatabase().commit();			
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public boolean delete(Object obj) {
		try{
			VerifyReceiving verifyReceiving = (VerifyReceiving)obj;
			Connection.getInstance().getDatabase().delete(verifyReceiving);
			Connection.getInstance().getDatabase().commit();
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public void activateIndexes() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(VerifyReceiving.class);
		query.descend("idpurchase").constrain(new Integer(-1));
		query.execute();
	}

	public VerifyReceiving getPurchase(String documentNumber) {
		return null;
	}

	public VerifyReceiving getPurchase(int idpurchase) {
		return null;
	}

	public VerifyReceiving getActiveVerifyreceiving() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(VerifyReceiving.class);
		//query.descend("idpurchase").constrain(new Integer(idpurchase));
		ObjectSet result = query.execute();
		if (result.isEmpty())
			return null;
		else
			return (VerifyReceiving)result.next();
	}

	public ModelVerifyQty getItem(int idpurchase, int idmodel) {
		
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(VerifyReceiving.class);
		query.descend("idpurchase").constrain(new Integer(idpurchase));
		query.descend("items").constrain(ModelVerifyQty.class);
		query.descend("idmodel").constrain(new Integer(idmodel));
		ObjectSet result = query.execute();
		
		if (result.isEmpty())
			return null;
		else
			return (ModelVerifyQty)result.next();
	}

}
