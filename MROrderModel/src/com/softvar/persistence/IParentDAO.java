package com.softvar.persistence;

import java.util.Date;
import java.util.List;

public interface IParentDAO {
	
	public static final int DATABASE_MSSQL = 1;
	public static final int DATABASE_DB4O = 2;
	public static final int DATABASE_MYSQL = 3;
	
	public static final String DATABASE_MSSQL_NAME = "MSSQL";
	public static final String DATABASE_DB4O_NAME = "DB4O";	
	public static final String DATABASE_MYSQL_NAME = "MySQL";	
	
	
	public List listAll();
	
	public boolean save(Object obj);
	
	public boolean delete(Object obj);
	
	public List listAllByDate(Date minDate);
}
