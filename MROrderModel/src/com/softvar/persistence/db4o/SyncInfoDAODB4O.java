package com.softvar.persistence.db4o;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Query;
import com.softvar.model.ISyncInfoDAO;
import com.softvar.model.SyncInfo;


public class SyncInfoDAODB4O implements IParentDAODB4O, ISyncInfoDAO{

	public void activateIndexes() {
		// TODO Auto-generated method stub
		
	}

	public List listAll() {
		ArrayList retorno = new ArrayList();		
		try {
			ObjectSet objectSet;
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(SyncInfo.class);			
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

	public SyncInfo getSyncInfData(String className) {
		SyncInfo result = null;
		try {
			ObjectSet objectSet;
			Query query = Connection.getInstance().getDatabase().query();
			query.constrain(SyncInfo.class);
			query.descend("className").constrain(className);
			objectSet = query.execute();
			if (!objectSet.isEmpty())
				result = (SyncInfo)objectSet.next();
			else {
				result = new SyncInfo();
				result.className = className;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public void updateSyncDate(String className, Date updateDate) {
		SyncInfo syncInfo = getSyncInfData(className);
		syncInfo.syncDate = updateDate;
		save(syncInfo);
	}

	public List listAllByDate(Date minDate) {
		// TODO Auto-generated method stub
		return null;
	}

}
