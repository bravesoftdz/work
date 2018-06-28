package com.mainretail.commun.controller;

import java.io.EOFException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Iterator;
import java.util.List;

import com.mainretail.commun.event.ConnectionManagerListener;
import com.mainretail.commun.model.Connection;
import com.mainretail.commun.model.DAOUtil;
import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.IParentDAODB4O;
import com.mainretail.commun.synch.SynchHeader;
import com.mainretail.commun.ui.SynchEvent;
import com.mainretail.commun.ui.SynchListener;

public class SyncManager extends Thread implements ConnectionManagerListener{
	
	private static String SYNCH_SERVLET = "synchservlet";
	
	
	private Class[] synchClasses;


	private int responseCode;
	private String responseMessage;
	private String urlPath;
	
	private SynchListener synchListener;
	
	public void run() {		
		send();
	}
	

	public void send(){
		ConnectionManager manager = new ConnectionManager();
		manager.setConnectionManagerListener(this);
		manager.setUrlPath(urlPath);		
		manager.setServlet(SYNCH_SERVLET);
		manager.send();
	}
	
	
	public void clearDatabaseTable(Class classForEmpty){
		IParentDAO dao = DAOUtil.getDAO(classForEmpty, IParentDAO.DATABASE_DB4O);
		
		List lista = dao.listAll();
		
		for(Iterator it = lista.iterator(); it.hasNext();){
			dao.delete(it.next());
		}
		lista = null;
		System.gc();
	}
	
	
	public void readAllObjects(ObjectInputStream ois) throws ClassNotFoundException, IOException {		
		Object obj;
		
		Connection.getInstance().close();
		Connection.getInstance().getDatabase(false);
		
		for (int i = 0; i < synchClasses.length; i++)
		  clearDatabaseTable(synchClasses[i]);
		
		try{
		while ((obj = ois.readObject()) != null){
			if (obj instanceof SynchHeader){
				
				System.out.println("Free memory BEFORE Synch "+((SynchHeader)obj).objectClass+": "+Runtime.getRuntime().freeMemory());
				readObjectList(ois, (SynchHeader)obj);
				System.out.println("Free memory AFTER Synch "+((SynchHeader)obj).objectClass+": "+Runtime.getRuntime().freeMemory());
				obj = null;
				System.gc();
				System.out.println("Free memory GC call:  "+Runtime.getRuntime().freeMemory());
				
			}
		}
		}catch(EOFException e){
			
		}
		
		obj = null;
		
		System.gc();
		
			
		Connection.getInstance().close();
		Connection.getInstance().getDatabase(true);
		
		for (int i = 0; i < synchClasses.length; i++){
			if (synchListener != null)
				synchListener.update(SynchEvent.SYNCH_HANDLE_DATA, synchClasses[i]);
			refreshIndex(synchClasses[i]);
		}
		
		Connection.getInstance().close();
		Connection.getInstance().getDatabase(true);
		
		/*
		if (synchListener != null)
			synchListener.update(SynchEvent.SYNCH_DEFRAG, null);
		
		if (Connection.getInstance().defrag()){
			if (synchListener != null)
				synchListener.update(SynchEvent.SYNCH_REMOVE_BACKUP, null);
			Connection.getInstance().deleteBackupFile();
		}
		*/
		
		if (synchListener != null)	
			synchListener.update(SynchEvent.SYNCH_FINISH, null);	
	}


	private void readObjectList(ObjectInputStream ois, SynchHeader header) throws ClassNotFoundException, IOException {
		if (synchListener != null)
			synchListener.update(SynchEvent.SYNCH_INITIALIZATION, header);
		for (int i = 0; i < header.objectCount; i++){
			if (synchListener != null)
				synchListener.update(SynchEvent.SYNCH_POSITION, null);
			Object objectToSave = ois.readObject(); 
			saveObject(objectToSave);
			objectToSave = null;
			//System.gc();
		}
	}

	private void saveObject(Object objectToSave) {
		DAOUtil.getDAO(objectToSave.getClass(), IParentDAO.DATABASE_DB4O).save(objectToSave);
	}



	public Class[] getSynchClasses() {
		return synchClasses;
	}


	public void setSynchClasses(Class[] synchClasses) {
		this.synchClasses = synchClasses;
	}


	public String getResponseMessage() {
		return responseMessage;
	}


	public int getResponseCode() {
		return responseCode;
	}


	public void removeSynchListener() {
		synchListener = null;
	}


	public void setSynchListener(SynchListener synchEvent) {
		this.synchListener = synchEvent;
	}


	public String getUrlPath() {
		return urlPath;
	}


	public void setUrlPath(String urlPath) {
		this.urlPath = urlPath;
	}


	public void dataOutput(ObjectOutputStream oos) {
		try {
			oos.writeObject(synchClasses);
		} catch (IOException e) {
			synchListener.update(SynchEvent.SYNCH_EXCEPTION, e);
		}
	}


	public void dataInput(ObjectInputStream ois){
		try {
			readAllObjects(ois);
		} catch (ClassNotFoundException e) {
			synchListener.update(SynchEvent.SYNCH_EXCEPTION, e);
		} catch (IOException e) {
			synchListener.update(SynchEvent.SYNCH_EXCEPTION, e);		
		}		
	}


	public void httpError(int errorCode, String errorMsg) {
		Object[] errorObj = new Object[]{new Integer(errorCode), new String(errorMsg)};
		synchListener.update(SynchEvent.SYNCH_ERROR, errorObj);
	}


	public void connectionException(Exception e) {
		synchListener.update(SynchEvent.SYNCH_EXCEPTION, e);
	}


	public void refreshIndex(Class classe) {
		for (int i = 0; i < synchClasses.length; i++){
			  IParentDAODB4O dao = (IParentDAODB4O)(DAOUtil.getDAO(classe, IParentDAO.DATABASE_DB4O));
			  dao.activateIndexes();
		}
		
	}
	
	
}



