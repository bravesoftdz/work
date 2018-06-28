package com.mainretail.commun.model;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Locale;


public class Config implements Serializable {
	private static final long serialVersionUID = -2820531548757475564L;
	
	public static final String APP_DIR = "\\mr\\";//System.getProperties().getProperty("user.dir") + "\\";
	public static final String CONFIG_FILE = "mainretail.cfg";
	public static final String DATABASE_NAME = "mainretaildb.yap";
	public static final String USER_DIR = System.getProperties().getProperty("user.dir");
	
	// Atributos
	private String databaseName = APP_DIR + DATABASE_NAME;
	private String host = "";
	private int transfSaleNum = 1;
	
	private String configFileName = APP_DIR + CONFIG_FILE; 
	
	private int IDStore;
	private boolean adminExit;
	private String ScannPrefix = "#";
	private Locale locale;
	private int gridNumLines = 1;
	
	private Config(){
		
	}
	
	private static Config instance = null;
	
	public static Config getInstance() {
		if (instance == null){
			instance = new Config();
			instance.load();
		}
		
		return instance;
	}
	
	public void load(){
		try {
			FileInputStream fis = new FileInputStream(getConfigFileName());
			ObjectInputStream ois = new ObjectInputStream(fis);
			instance = (Config) ois.readObject();
		} catch (FileNotFoundException e) {
			System.out.println("Config File not Found: " + CONFIG_FILE);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public void save(){
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(getConfigFileName(), false);
			ObjectOutputStream oos = new ObjectOutputStream(fos);
			oos.writeObject(instance);
			oos.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String getDatabaseName() {
		
		if (!databaseName.trim().equals(""))
			return databaseName;
		else
			return APP_DIR + DATABASE_NAME;
	}

	public void setDatabaseName(String databaseName) {
		this.databaseName = databaseName;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public int getTransfSaleNum() {
		return transfSaleNum;
	}

	public void setTransfSaleNum(int transfSaleNum) {
		this.transfSaleNum = transfSaleNum;
	}

	public int getIDStore() {
		return IDStore;
	}

	public void setIDStore(int store) {
		IDStore = store;
	}

	public String getScannPrefix() {
		return ScannPrefix;
	}

	public void setScannPrefix(String scannPrefix) {
		ScannPrefix = scannPrefix;
	}

	public Locale getLocale() {
		return locale;
	}

	public void setLocale(Locale language) {
		this.locale = language;
	}

	public boolean getIsAdminExit() {
		return adminExit;
	}

	public void setAdminExit(boolean adminExit) {
		this.adminExit = adminExit;
	}

	public int getGridNumLines() {
		if (gridNumLines != 0)
			return gridNumLines;
		else
			return 1;
	}

	public void setGridNumLines(int gridNumLines) {
		this.gridNumLines = gridNumLines;
	}
	
	public String getConfigFileName() {
		
		if (!configFileName.trim().equals(""))
			return configFileName;
		else
			return APP_DIR + CONFIG_FILE;
	}


	
}
