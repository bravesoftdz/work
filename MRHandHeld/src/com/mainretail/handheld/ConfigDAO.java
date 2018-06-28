package com.mainretail.handheld;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import javax.microedition.rms.RecordStore;
import javax.microedition.rms.RecordStoreException;
import javax.microedition.rms.RecordStoreNotFoundException;


public class ConfigDAO {
	private static ConfigDAO instance;
	private RecordStore rs;
	public static final String RS_CONFIG = "rsconfig";
	public static final String MR_VENDOR = "MainRetail";
	public static final String MR_SUITE = "MainRetail - HandHeld";

	private ConfigDAO() 
	{}

	public static ConfigDAO getInstance() 
	{
		if (instance==null)
		{
			instance= new ConfigDAO();
		}
		return instance;
	
	}
	private RecordStore getRecordStore() throws RecordStoreException 
	{
		if (rs == null)
		{
			try{
				rs = RecordStore.openRecordStore(RS_CONFIG, MR_VENDOR, MR_SUITE);
			}catch(RecordStoreNotFoundException rnf){
				rs = RecordStore.openRecordStore(RS_CONFIG, true, RecordStore.AUTHMODE_PRIVATE, true);				
			}catch(SecurityException rnf){
				rs = RecordStore.openRecordStore(RS_CONFIG, true, RecordStore.AUTHMODE_PRIVATE, true);				
			}
		}
	
		return rs;
	}
	public void closeRecordStore() throws RecordStoreException 
	{
		if (rs != null)
		{
			rs.closeRecordStore() ;
			rs = null;
		}
	}
	
	public void save(Config config) throws RecordStoreException 
	{
		ByteArrayOutputStream bOut = null;
		DataOutputStream oStrm = null ;
		
		try {	
			bOut = new ByteArrayOutputStream();
			oStrm = new DataOutputStream( bOut );
			byte[] date;
			oStrm.writeUTF(config.urlHost);	
			oStrm.writeUTF(config.upcSufix);
			oStrm.writeUTF(config.store);
			oStrm.writeBoolean(config.saveLog);
			oStrm.writeUTF(config.lastVerifyReceiving);
			oStrm.flush();
			date = bOut.toByteArray();
			
			if (getRecordStore().getNumRecords() == 0)
				getRecordStore().addRecord(date, 0, date.length);
			else				
				getRecordStore().setRecord(1, date, 0, date.length);
			
		} catch (IOException i)
		{
			throw new RecordStoreException(i.getMessage());
		}
		finally {
			try {
				if (oStrm!=null)
					oStrm.close();
				if (bOut!=null)
					bOut.close();
			}
			catch (IOException e)
			{}
		
		}
	
	}
	
	public void load(byte[] recDate, Config config) throws RecordStoreException
	{
		ByteArrayInputStream bStrm=null;
		DataInputStream iStrm = null;
		try {
			bStrm=new ByteArrayInputStream(recDate);
			iStrm = new DataInputStream(bStrm);
			config.urlHost = iStrm.readUTF();
			config.upcSufix = iStrm.readUTF(); 
			config.store = iStrm.readUTF();
			config.saveLog = iStrm.readBoolean();
			try {
				config.lastVerifyReceiving = iStrm.readUTF();
			}
			catch(IOException t) {
				t.printStackTrace();
			}
		}
		catch (IOException i)
		{
			throw new RecordStoreException(i.getMessage());
		}
		finally {
			try {
				if (bStrm!=null)
					bStrm.close();
				if (iStrm!=null)
					iStrm.close();
			}
			catch (IOException e)
			{}
		}
			
		
	}
	
	public void load(Config config) throws RecordStoreException  
	{
		byte[] recDate = null;
		
		try{	
			
			if (config==null) {
				System.out.println("config NULL");		
			}
		
		recDate = getRecordStore().getRecord(1);
		load(recDate, config);
		
		}catch(Exception e) {
			e.printStackTrace();
		}		
		
	}	
}