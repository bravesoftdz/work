package com.mainretail.handheld;

import java.util.Vector;

import javax.microedition.rms.InvalidRecordIDException;
import javax.microedition.rms.RecordEnumeration;
import javax.microedition.rms.RecordStore;
import javax.microedition.rms.RecordStoreException;
import javax.microedition.rms.RecordStoreFullException;
import javax.microedition.rms.RecordStoreNotFoundException;
import javax.microedition.rms.RecordStoreNotOpenException;

import com.mainretail.util.ParentForm;


public abstract class ParentFormPersistent extends ParentForm {	
	private RecordStore dados;
	
	
	public ParentFormPersistent() {
		super();
		
	}
	
	public abstract String getRecosrdStoreName();
	
	public abstract Object StringToItem(String query);
	
	public void loadRecordStore(){
		
		System.gc();
		try {
			openRS();
					
		} catch (RecordStoreFullException e) {
			e.printStackTrace();
		} catch (RecordStoreNotFoundException e) {
			e.printStackTrace();
		} catch (RecordStoreException e) {
			e.printStackTrace();
		}
			
	}
	
	public Vector getRSVector() {
		Vector result = new Vector();
		try {
			for(RecordEnumeration re = dados.enumerateRecords(null, null, false); re.hasNextElement(); ){
				String query = new String(re.nextRecord());
				Object obj = StringToItem(query);
				query = null;
				result.addElement(obj);
				obj = null;
				System.gc();
			}
		} catch (RecordStoreNotOpenException e) {
			e.printStackTrace();
		} catch (InvalidRecordIDException e) {
			e.printStackTrace();
		} catch (RecordStoreException e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	
	public void removeAllRSItems() {

			unloadRecordStore();
			killRS();
			try {
				openRS();
			} catch (RecordStoreFullException e) {
				e.printStackTrace();
			} catch (RecordStoreNotFoundException e) {
				e.printStackTrace();
			} catch (RecordStoreException e) {
				e.printStackTrace();
			}
			System.gc();
	}
	
	private void killRS() {
		try {
			RecordStore.deleteRecordStore(getRecosrdStoreName());
		} catch (RecordStoreNotFoundException e) {
		} catch (RecordStoreException e) {
		}
	}

	public void discardRS() {
		unloadRecordStore();
		killRS();
		System.gc();
	}

	
	public abstract String ItemToString(Object obj);
	
	public void addRSItem(Object obj) {
		String query = ItemToString(obj);
		byte[] bytes = query.getBytes();
		try {
			dados.addRecord(bytes, 0, bytes.length);
			bytes = null;
		} catch (RecordStoreNotOpenException e) {
			e.printStackTrace();
		} catch (RecordStoreFullException e) {
			e.printStackTrace();
		} catch (RecordStoreException e) {
			e.printStackTrace();
		}				
	}
	
	public void removeRSItem(int pos) {
		try {
			int id = locateInRecordStore(pos);
			dados.deleteRecord(id);
		} catch (RecordStoreNotOpenException e) {
			e.printStackTrace();
		} catch (InvalidRecordIDException e) {
			e.printStackTrace();
		} catch (RecordStoreException e) {
			e.printStackTrace();
		}
	}
	
	public void setRSItem(int pos, Object obj) {
		try {
			int id = locateInRecordStore(pos);
			String query = ItemToString(obj);
			byte[] bytes = query.getBytes();		
			dados.setRecord(id, bytes, 0, bytes.length);
			query = null;
			bytes = null;
			System.gc();
		} catch (RecordStoreNotOpenException e) {
			e.printStackTrace();
		} catch (InvalidRecordIDException e) {
			e.printStackTrace();
		} catch (RecordStoreException e) {
			e.printStackTrace();
		}
	}
	
	public Object getRSItem(int pos) {
		Object obj = null;
		
		try {
			int id = locateInRecordStore(pos);
			
			String query = new String(dados.getRecord(id));
			obj = StringToItem(query);
			query = null;
						
			System.gc();
		} catch (RecordStoreNotOpenException e) {
			e.printStackTrace();
		} catch (InvalidRecordIDException e) {
			e.printStackTrace();
		} catch (RecordStoreException e) {
			e.printStackTrace();
		}
		return obj;
	}
	
	public int getRSNumRecords() {
		try {
			return dados.getNumRecords();
		} catch (RecordStoreNotOpenException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public boolean getRSIsEmpty() {
		return (getRSNumRecords() == 0);
	}

	
	private void openRS() throws RecordStoreFullException, RecordStoreNotFoundException, RecordStoreException {		
			dados = RecordStore.openRecordStore(getRecosrdStoreName(), true);
	}
	
	private void closeRS() throws RecordStoreNotOpenException, RecordStoreException{		
		dados.closeRecordStore();	
	}
	
	public void unloadRecordStore(){		
		try {			
			closeRS();
		} catch (RecordStoreNotOpenException e) {
			
		} catch (RecordStoreException e) {
			
		}	
	}
	
		
	
	private int locateInRecordStore(int pos) throws RecordStoreNotOpenException, InvalidRecordIDException, RecordStoreException {
		int i = 0;
		int retorno = -1;
		for(RecordEnumeration re = dados.enumerateRecords(null, null, false); re.hasNextElement();){
			retorno = re.nextRecordId();
			if (i == pos)
				break;
			i++;
		}
		return retorno;
	}	

}
