package com.mainretail.commun.model;

import java.util.List;

public interface IParentDAO {
	
	public static final int DATABASE_MSSQL = 1;

	public static final int DATABASE_DB4O = 2;
	
	public static final String DATABASE_MSSQL_NAME = "MSSQL";

	public static final String DATABASE_DB4O_NAME = "DB4O";

	
	public List listAll();
	
	public boolean save(Object obj);
	
	public boolean delete(Object obj);	
}
