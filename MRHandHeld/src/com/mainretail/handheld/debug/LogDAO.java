
package com.mainretail.handheld.debug;

import java.util.Vector;

import javax.microedition.rms.RecordEnumeration;
import javax.microedition.rms.RecordStore;
import javax.microedition.rms.RecordStoreException;


public class LogDAO {

	private static LogDAO instance;
	private RecordStore rs;
	public static final String NOME_RECORDSTORE="log";
	
	private LogDAO()
	{}
	public static LogDAO getInstance()
	{
		if (instance==null)
		{
			instance= new LogDAO();
			
		}
		return instance;
	
	}
	
	private RecordStore getRecordStore() throws SystemException 
	{
		if (rs==null)
		{
			try {
				
				rs = RecordStore.openRecordStore(NOME_RECORDSTORE,true );
				
			} catch (Exception e) {
				throw new SystemException(e.getMessage());
			}
	
		}
	
		return rs;
	}
	
	public void closeRecordStore() throws SystemException 
	{
		if (rs!=null)
		{
			try {
				rs.closeRecordStore() ;
			} catch (Exception e) {
				
				throw new SystemException(e.getMessage());
			} 
			rs=null;
		}
	}
	
	
	public void log(String message) throws SystemException 
	{
		
		try {
			
			byte[] date = message.getBytes();
			getRecordStore().addRecord( date, 0, date.length);

		}
		
		catch (Exception e)
		{
			throw new SystemException(e.getMessage());
		}
	
	}

	public void clean() throws SystemException
	{
		try {
			     getRecordStore().closeRecordStore() ;
			     RecordStore.deleteRecordStore( NOME_RECORDSTORE);
			}
			catch (RecordStoreException e)
			{
				throw new SystemException(e.getMessage());
			}
	
	}
	public Vector consult() throws SystemException
	{
		Vector retorno = new Vector();
		try {
			
			RecordEnumeration en = getRecordStore().enumerateRecords(null,null,false);
	
			while (en.hasNextElement())
			{
				byte[] date = en.nextRecord() ;
				
				retorno.addElement(new String(date));
			}
		}	
		catch (RecordStoreException e)
		{
			throw new SystemException(e.getMessage());
		}

		return retorno;
	}
	
	
}
