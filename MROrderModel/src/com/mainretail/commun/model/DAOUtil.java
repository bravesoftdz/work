package com.mainretail.commun.model;

import java.util.HashMap;

public class DAOUtil {
	
	private static final String DAO_IDENTIFIER = "DAO";	
	private static HashMap instanceList = new HashMap();
	
	public static IParentDAO getDAO(Class classe, int database){
		IParentDAO result = null;
		String dbName;
		if (database == IParentDAO.DATABASE_MSSQL)
			dbName = IParentDAO.DATABASE_MSSQL_NAME;
		else
			dbName = IParentDAO.DATABASE_DB4O_NAME;
		String className = classe.getName() + DAO_IDENTIFIER + dbName; 
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
