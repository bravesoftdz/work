package com.mainretail.commun.model.inventory;

import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.IParentDAODB4O;

public class BarcodePrintListDAODB4O implements IParentDAODB4O, IBarcodePrintListDAO {

	public void activateIndexes() {
	}

	public List listAll() {
		return null;
	}

	public boolean save(Object obj) {
		try{
			BarcodePrintList barcodePrintList = (BarcodePrintList)obj;
			Connection.getInstance().getDatabase().delete(barcodePrintList);
			Connection.getInstance().getDatabase().set(barcodePrintList);
			Connection.getInstance().getDatabase().commit();			
			return true;
		}catch(Throwable t){
			t.printStackTrace();
			return false;
		}
	}

	public boolean delete(Object obj) {
		try{
			BarcodePrintList barcodePrintList = (BarcodePrintList)obj;
			Connection.getInstance().getDatabase().delete(barcodePrintList);
			Connection.getInstance().getDatabase().commit();			
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public BarcodePrintList getOpenBarcodePrintList() {
		Query query =  Connection.getInstance().getDatabase().query();
		query.constrain(BarcodePrintList.class);
		ObjectSet objectSet = query.execute();
		
		if (objectSet.isEmpty())
			return null;
		else
			return (BarcodePrintList)objectSet.next();
	}


}
