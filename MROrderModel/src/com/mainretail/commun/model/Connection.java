package com.mainretail.commun.model;

import java.io.File;
import java.io.IOException;

import com.db4o.Db4o;
import com.db4o.ObjectContainer;
import com.db4o.defragment.Defragment;
import com.db4o.defragment.DefragmentConfig;
import com.mainretail.commun.model.inventory.Barcode;
import com.mainretail.commun.model.inventory.BarcodePrintList;
import com.mainretail.commun.model.inventory.Category;
import com.mainretail.commun.model.inventory.InvCount;
import com.mainretail.commun.model.inventory.Model;
import com.mainretail.commun.model.purchase.PO;
import com.mainretail.commun.model.purchase.Receiving;
import com.mainretail.commun.model.purchase.ReceivingItem;
import com.mainretail.commun.model.purchase.VerifyReceiving;
import com.mainretail.commun.model.sale.Sale;
import com.mainretail.commun.model.Config;

public class Connection {
	
	private static Connection instance = null;	
	private static ObjectContainer database = null;
	
	private static final Class[] CASCADE_CLASSES = {Sale.class, VerifyReceiving.class, Receiving.class, PO.class, InvCount.class, BarcodePrintList.class};
	
	private Connection(){
		
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
	
	public ObjectContainer getDatabase() {
		return getDatabase(true);
	}
	

	public ObjectContainer getDatabase(boolean activateIndexes) {
		if (database == null){			
			String fileName = Config.getInstance().getDatabaseName();
			Db4o.configure().lockDatabaseFile(true);
			Db4o.configure().callConstructors(true);
			Db4o.configure().callbacks(false);
			//Db4o.configure().weakReferences(false);
			//Db4o.configure().freespace().discardSmallerThan(Integer.MAX_VALUE);
			Db4o.configure().testConstructors(false);
			//Db4o.configure().detectSchemaChanges(false);
			//Db4o.configure().allowVersionUpdates(true);
			Db4o.configure().flushFileBuffers(true);
			Db4o.configure().activationDepth(3);
			
			configureIndexes(activateIndexes);
			
			for (int i = 0; i < CASCADE_CLASSES.length; i++){
				Db4o.configure().objectClass(CASCADE_CLASSES[i]).cascadeOnUpdate(true);
				Db4o.configure().objectClass(CASCADE_CLASSES[i]).cascadeOnDelete(true);
				Db4o.configure().objectClass(CASCADE_CLASSES[i]).cascadeOnActivate(true);
			}
			database = Db4o.openFile(fileName);
		}
		return database;
	}
	
	private void configureIndexes(boolean activate){
		
		// Model 
		Db4o.configure().objectClass(Model.class).objectField("idcategory").indexed(activate);
		Db4o.configure().objectClass(Model.class).objectField("idsubcategory").indexed(activate);
		Db4o.configure().objectClass(Model.class).objectField("idgroup").indexed(activate);
		Db4o.configure().objectClass(Model.class).objectField("idmodel").indexed(activate);
		
		// Category
		Db4o.configure().objectClass(Category.class).objectField("id").indexed(activate);
		Db4o.configure().objectClass(Category.class).objectField("type").indexed(activate);
		Db4o.configure().objectClass(Category.class).objectField("order").indexed(activate);
		
		
		// Sale
		Db4o.configure().objectClass(Sale.class).objectField("idstore").indexed(activate);
		Db4o.configure().objectClass(Sale.class).objectField("saleDate").indexed(activate);
		
		// Barcode
		Db4o.configure().objectClass(Barcode.class).objectField("idbarcode").indexed(activate);
		
		//User
		Db4o.configure().objectClass(User.class).objectField("pw").indexed(activate);
		
		// VerifyReceivingItem
		Db4o.configure().objectClass(ReceivingItem.class).objectField("idmodel").indexed(activate);
		
	}
	
	public boolean defrag(){
		boolean result = true;
		try {
			close();
			
			DefragmentConfig defConfig = new DefragmentConfig(Config.getInstance().getDatabaseName());
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
		String backupName = Config.getInstance().getDatabaseName() + "." + DefragmentConfig.BACKUP_SUFFIX;
		return (new File(backupName)).delete();
	}

}
