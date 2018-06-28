package com.softvar.mrorder.controller;

import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.zip.InflaterInputStream;

import com.softvar.controller.ConnectionManager;
import com.softvar.controller.event.ConnectionManagerListener;
import com.softvar.controller.event.SynchEvent;
import com.softvar.controller.event.SynchListener;
import com.softvar.model.order.Account;
import com.softvar.model.order.AccountCost;
import com.softvar.persistence.DAOUtil;
import com.softvar.persistence.IParentDAO;
import com.softvar.persistence.db4o.Connection;
import com.softvar.persistence.db4o.IParentDAODB4O;
import com.softvar.synch.SynchHeader;


public class AccountCostSynchManager extends Thread implements ConnectionManagerListener{
	
	private static String SYNCH_SERVLET = "accountcostsynchservlet";
	
	
	private Account[] accountObjects;


	private int responseCode;
	private String responseMessage;
	private String urlPath;
	
	private SynchListener synchListener;


	private String application;
	
	public void run() {		
		send();
	}
	

	public void send(){
		ConnectionManager manager = new ConnectionManager();
		manager.setConnectionManagerListener(this);
		manager.setUrlPath(urlPath);		
		manager.setServlet(SYNCH_SERVLET);
		manager.setApplication(application);
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
	
	
	public void readAllObjects(ObjectInputStream ois) throws Exception {		
		Object obj;
		
		Connection.getInstance().close();
		
		try{
			Connection.getInstance().getDatabase(false);
		} catch(Exception e){
			
		}
		
		clearDatabaseTable(AccountCost.class);
		
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
		
		
		if (synchListener != null)
			synchListener.update(SynchEvent.SYNCH_HANDLE_DATA, AccountCost.class);
			refreshIndex(AccountCost.class);
		
		
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



	public Account[] getAccountObjects() {
		return accountObjects;
	}


	public void setAccountObjects(Account[] synchClasses) {
		this.accountObjects = synchClasses;
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
			oos.writeObject(accountObjects);
		} catch (IOException e) {
			synchListener.update(SynchEvent.SYNCH_EXCEPTION, e);
		}
	}


	public void dataInput(InputStream iis){
	
		try {
			File f = new File("data.zip");
			if (f.exists())
				f.delete();
			
			FileOutputStream fos = new FileOutputStream(f);
			try{
				byte[] b = new byte[65536];
				int lidos = -1;
				while (true){
					if ((lidos= iis.read(b)) == -1)
						break;
					fos.write(b, 0, lidos);					
				}
				fos.flush();
				
							
			}finally{
				fos.close();
			}
			
		} catch (Exception e) {
			synchListener.update(SynchEvent.SYNCH_EXCEPTION, e);
		}		
		
		try {
			//readAllObjects(ois);	
		} catch (Exception e) {
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
		for (int i = 0; i < accountObjects.length; i++){
			  IParentDAODB4O dao = (IParentDAODB4O)(DAOUtil.getDAO(classe, IParentDAO.DATABASE_DB4O));
			  dao.activateIndexes();
		}
		
	}


	public String getApplication() {
		return application;
	}


	public void setApplication(String application) {
		this.application = application;
	}


	public void proccesData() {
		try {
			ObjectInputStream ois = new ObjectInputStream(new InflaterInputStream(new FileInputStream("data.zip")));
			readAllObjects(ois);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
}