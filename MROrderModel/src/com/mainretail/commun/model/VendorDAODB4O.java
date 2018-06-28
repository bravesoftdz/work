package com.mainretail.commun.model;

import java.util.List;

import com.db4o.ObjectSet;

public class VendorDAODB4O implements IVendorDAO, IParentDAODB4O {

	public List listAll() {
		ObjectSet cont = Connection.getInstance().getDatabase().query(Vendor.class);
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
			Connection.getInstance().getDatabase().ext().purge(obj);
		}catch(Throwable t){
			return false;
		}
		return true;
	}

	public void activateIndexes() {
		
	}

}
