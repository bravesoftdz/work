package com.softvar.mrorder;

import java.util.Hashtable;

import com.softvar.mrorder.controller.Config;
import com.softvar.persistence.db4o.IDB4OConfig;


public class DB4OConfig implements IDB4OConfig {
	
	//private static final String DATABASE_NAME = "MROrder.yap";
	
	private static DB4OConfig instance;
	
	private DB4OConfig(){
		
	}
	
	public static DB4OConfig getInstace(){
		if (instance == null)
			instance = new DB4OConfig();
		return instance;
	}

	public Class[] getCascadeClasses() {
		return new Class[]{
				com.softvar.model.order.Order.class
		};
	}

	public String getFileName() {
		return Config.getInstance().getDatabaseName();
	}

	public Hashtable getClassIndexes() {
		Hashtable result = new Hashtable();
		result.put(com.softvar.model.order.Order.class, "idorder");
		result.put(com.softvar.model.order.Order.class, "idcustomer");
		result.put(com.softvar.model.order.Product.class, "idproduct");
		result.put(com.softvar.model.order.Product.class, "UPC");
		result.put(com.softvar.model.order.AccountCost.class, "idaccount");
		result.put(com.softvar.model.order.AccountCost.class, "idproduct");
		return result;
	}

}
