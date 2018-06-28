package com.mainretail.handheld;

import javax.microedition.rms.RecordStoreException;

public class Config {

	
	private static final String SERVLET_CONTEXT = "/mrservlet";
	public static final String RS_CONFIG = "rsconfig";
	private static ConfigDAO configDAO;
	private static Config instance;
	
	 
	public String  urlHost = null;
	public String  upcSufix = null;
	public String store = null;
	public boolean saveLog = false;
	public int removeBarcodeDigit = 0;
	public String lastVerifyReceiving = "";
	
	
	private Config() {
		try {
			load(this);
			
			 /*
			urlHost = "192.168.1.10";
			upcSufix = "#";
			store = "1";
			
			
			if (this.urlHost.equals("")){
				
			}
		// */
			
			
		} catch (RecordStoreException e) {			
			e.printStackTrace();
		} 	
	}
	
	/** Implementacao do pattern Singleton */
	public static Config getInstance()
	{
		if (instance==null)
		{
			instance= new Config();
			
		}
		return instance;
		
	}
	
	/* TODO Coloque aqui outras configuracoes necessarias para o seu projeto */
	
	private static ConfigDAO getDAO() 
    {
		if (configDAO == null)
		{
			configDAO = ConfigDAO.getInstance(); 
		}
		return configDAO;
    }
	
	public void save() throws RecordStoreException
	{
		getDAO().save(this); 
	}
	
	public static void load(Config config) throws RecordStoreException
	{		
		getDAO().load(config);
	}

	public String getUrl(String servlet)
	{
		return "http://" + this.urlHost + ":8080" + SERVLET_CONTEXT+ servlet;		
	}

}