package com.softvar.persistence.db4o;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Hashtable;

import com.db4o.Db4o;
import com.db4o.ObjectContainer;
import com.db4o.defragment.Defragment;
import com.db4o.defragment.DefragmentConfig;

/**
 * @author Carlos Lima
 *
 */
public class Connection {
	
	private static Connection instance = null;	
	private static ObjectContainer database = null;
	private static IDB4OConfig config; 
	
	private Connection(){
		
	}
	
	public void configure(IDB4OConfig newConfig){
		config = newConfig;
	}
	
	public void close(){
		System.out.println("Begin - Closing Database");
		if (database != null){
			database.close();
			database = null;
			System.out.println("Database Closed");
		}
		if (instance != null)
			instance = null;
		System.gc();
		
		System.out.println("End - Closing Database");		
	}
	
	public static Connection getInstance(){
		if (instance == null){			
			instance = new Connection();
		}
		return instance;
	}
	
	public ObjectContainer getDatabase() throws Exception {
		return getDatabase(config, true);
	}
	
	
	public ObjectContainer getDatabase(IDB4OConfig newConfig) throws Exception {
		config = newConfig;
		return getDatabase(newConfig, true);
	}
	
	
	public ObjectContainer getDatabase(IDB4OConfig newConfig, boolean activateIndexes) throws Exception {
		config = newConfig;
		if (config == null){
			throw new Exception("Null configuration");
		}
		if (database == null){			
			String fileName = config.getFileName();
			Db4o.configure().lockDatabaseFile(false);
			Db4o.configure().callConstructors(true);
			Db4o.configure().callbacks(false);
			//Db4o.configure().weakReferences(false);
			Db4o.configure().freespace().discardSmallerThan(Integer.MAX_VALUE);
			Db4o.configure().testConstructors(false);
			//Db4o.configure().detectSchemaChanges(false);
			//Db4o.configure().allowVersionUpdates(true);
			
			configureIndexes(activateIndexes);
			configureCascades();
			
			database = Db4o.openFile(fileName);
		}
		return database;
	}
	
	private void configureIndexes(boolean activate){
		Hashtable ht = config.getClassIndexes();

		for(Enumeration en = ht.keys(); en.hasMoreElements();){
			Class indexingClass = (Class)(en.nextElement());
			String fieldName = (String)(ht.get(indexingClass));
			Db4o.configure().objectClass(indexingClass).objectField(fieldName).indexed(activate);
		}
		
	}
	
	private void configureCascades(){
		for (int i = 0; i < config.getCascadeClasses().length; i++){
			Db4o.configure().objectClass(config.getCascadeClasses()[i]).cascadeOnUpdate(true);
			Db4o.configure().objectClass(config.getCascadeClasses()[i]).cascadeOnDelete(true);
		}
	}
	
	public boolean defrag(){
		boolean result = true;
		try {
			close();
			
			DefragmentConfig defConfig = new DefragmentConfig(config.getFileName());
			defConfig.forceBackupDelete(true);
			defConfig.db4oConfig(Db4o.configure());
			
			Defragment.defrag(defConfig);
			
		} catch (IOException e) {
			result = false;
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean deleteBackupFile(){
		String backupName = config.getFileName() + "." + DefragmentConfig.BACKUP_SUFFIX;
		return (new File(backupName)).delete();
	}


	public ObjectContainer getDatabase(boolean activateIndexes) throws Exception {
		return getDatabase(config, activateIndexes);
	}


	
}
