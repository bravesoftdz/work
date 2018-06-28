package com.mainretail.commun.model.purchase;

import java.util.List;
import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.IParentDAODB4O;

public class PODAODB4O implements IPODAO, IParentDAODB4O {

	public List listAll() {
		ObjectSet cont = Connection.getInstance().getDatabase().query(PO.class);
		java.util.ArrayList lista = new java.util.ArrayList();
		lista.addAll(cont);
		return lista;
	}

	public boolean save(Object obj) {
		try{
			PO po = (PO)obj;
			/*
			for(ListIterator it = po.getItems().listIterator(); it.hasNext();){
				POItem poitem = (POItem)it.next(); 
				Connection.getInstance().getDatabase().set(poitem);
			}
			Connection.getInstance().getDatabase().set(po.getItems());
			*/
			Connection.getInstance().getDatabase().delete(po);
			Connection.getInstance().getDatabase().set(po);
			Connection.getInstance().getDatabase().commit();
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public boolean delete(Object obj) {
		try{
			PO po = (PO)obj;
			/*
			for(ListIterator it = po.getItems().listIterator(); it.hasNext();){
				POItem poitem = (POItem)it.next(); 
				Connection.getInstance().getDatabase().delete(poitem);
			}
			*/
			Connection.getInstance().getDatabase().delete(po);
			Connection.getInstance().getDatabase().commit();
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public void activateIndexes() {
		// TODO Auto-generated method stub

	}

	
	public PO getActivePO() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(PO.class);
		ObjectSet result = query.execute();
		if (result.isEmpty())
			return null;
		else
			return (PO)result.next();
	}

}
