package com.softvar.persistence;

import java.util.HashMap;

import com.softvar.util.StringUtils;


/**
 * @author Carlos Lima
 *
 */
public class DAOUtil {
	
	private static final String DAO_IDENTIFIER = "DAO";
	private static final String DAO_PATH = "com.softvar.persistence.";
	
	
	private static HashMap instanceList = new HashMap();
	
	public static IParentDAO getDAO(Class classe, int database){
		IParentDAO result = null;
		String dbName;
		
		switch (database){
		case IParentDAO.DATABASE_MSSQL:{
			dbName = IParentDAO.DATABASE_MSSQL_NAME;
			break;
		}
		case IParentDAO.DATABASE_DB4O:{
			dbName = IParentDAO.DATABASE_DB4O_NAME;
			break;
		}

		case IParentDAO.DATABASE_MYSQL:{
			dbName = IParentDAO.DATABASE_MYSQL_NAME;
			break;
		}
		
		default:
			dbName = "";
		}
		
		
		String className = DAO_PATH + dbName.toLowerCase() + "." + StringUtils.UnqualifyName(classe.getName()) + DAO_IDENTIFIER + dbName; 
		result = (IParentDAO)instanceList.get(className);
		if (result == null){
			try {
				Class daoClass = Class.forName(className);
				result = (IParentDAO) daoClass.newInstance(); 
				instanceList.put(className, result);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		return result;
	}
	
	
}