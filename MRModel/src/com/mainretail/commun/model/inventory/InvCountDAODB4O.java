package com.mainretail.commun.model.inventory;

import java.util.Iterator;
import java.util.List;

import com.db4o.ObjectSet;
import com.db4o.query.Candidate;
import com.db4o.query.Evaluation;
import com.db4o.query.Query;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.IParentDAODB4O;

public class InvCountDAODB4O implements IInvCountDAO, IParentDAODB4O {

	public boolean countingExists(InvCount invCount) {
		return false;
	}

	public List listAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean save(Object obj) {
		try{
			InvCount invcount = (InvCount)obj;
			Connection.getInstance().getDatabase().delete(invcount);
			Connection.getInstance().getDatabase().set(invcount);
			Connection.getInstance().getDatabase().commit();			
			return true;
		}catch(Throwable t){
			t.printStackTrace();
			return false;
		}
	}

	public boolean delete(Object obj) {
		try{
			InvCount invcount = (InvCount)obj;
			Connection.getInstance().getDatabase().delete(invcount);
			Connection.getInstance().getDatabase().commit();			
			return true;
		}catch(Throwable t){
			return false;
		}
	}

	public void activateIndexes() {
		Query query = Connection.getInstance().getDatabase().query();
		query.constrain(InvCount.class);
		query.descend("idcount").constrain(new Integer(-1));
		query.execute();
	}

	public InvCount getOpenCounting(int countType) {
		Query query =  Connection.getInstance().getDatabase().query();
		query.constrain(InvCount.class);
		query.descend("counttype").constrain(new Integer(countType));
		ObjectSet objectSet = query.execute();
		
		if (objectSet.isEmpty())
			return null;
		else
			return (InvCount)objectSet.next();
	}

	public void deleteGarbageCount(InvCount invCount) {
		Query query =  Connection.getInstance().getDatabase().query();
		query.constrain(InvCount.class);
		/*
		query.descend("idcount").constrain(new Integer(invCount.idcount)).not();
		query.descend("countype").constrain(new Integer(invCount.counttype));
		*/
		
		final int counttype = invCount.counttype;
		final int idcount = invCount.idcount;
		
		query.constrain(new  Evaluation() {
			private static final long serialVersionUID = 1L;
			public void evaluate(Candidate candidate) {
				InvCount testing = (InvCount)candidate.getObject();
				candidate.include((testing.counttype == counttype) & (testing.idcount != idcount));
			}
		});
		
		ObjectSet objectSet = query.execute();
		
		
		if (!objectSet.isEmpty()){
			for (Iterator it = objectSet.iterator(); it.hasNext();){
				InvCount ivc =	(InvCount)it.next();
				delete(ivc);
			}
		}
	}

}


