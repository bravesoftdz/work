package com.softvar.persistence.jdbc;

import java.sql.*;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import com.softvar.util.StringUtils;

public class SQLFunctions {

		private static SQLFunctions instance;
		
		public static SQLFunctions getInstance()
		{
			if (instance == null)
			{
				instance = new SQLFunctions(); 
			}
			return instance;		
		}

		public int getNextCode(java.sql.Connection con, String tablefield) throws SQLException {		
			
			CallableStatement spNextCode = null;
			int LastCode = 0; 
			
			try {
				spNextCode = con.prepareCall("{call sp_Sis_GetNextCode(?, ?)}");			
				spNextCode.setString(1, tablefield);			
				spNextCode.registerOutParameter(2, Types.INTEGER);
				spNextCode.execute();
				LastCode = spNextCode.getInt(2);
			}
			finally {
				JDBCConnectionFunctions.getInstance().closeConnection(null, spNextCode, null);	
			}
			
			return LastCode;
		}
		
		public String hashTableToSQLInsert(String tableName, Hashtable ht) throws SQLException{
			String result = "INSERT INTO " + tableName + " (";
			
			for(Enumeration en = ht.keys(); en.hasMoreElements();){		
				result += (String)en.nextElement();
				if (en.hasMoreElements())
					result += ", ";
			}
			
			result += ") ";
			
			String key;
			Object obj;
			
			result += "VALUES (";
			
			for(Enumeration en = ht.keys(); en.hasMoreElements();){
				key = (String)en.nextElement();
				obj = ht.get(key);
				result += objectTOSQLString(obj);			
				if (en.hasMoreElements())
					result += ", ";
			}
			result += ")";
			
			return result;
		}
		
		public String hashTableToSQLProcedure(String procedureName, Hashtable ht) throws SQLException{
			String result = "call " + procedureName + " ";
			
			String key;
			Object obj;
			
			for(Enumeration en = ht.keys(); en.hasMoreElements();){
				key = (String)en.nextElement();
				obj = ht.get(key);
				result += objectTOSQLString(obj);
				if (en.hasMoreElements())
					result +=  " , ";
			}
			
			System.out.println("Codigo de execu��o da procedure:");
			System.out.println(result);
			
			return result;
		}
		
		private String objectTOSQLString(Object obj) throws SQLException {
			String result = null;
			
			if ( (obj == null) || ((obj instanceof String) && ((String)obj).equals("")) ) 
				result = "null";
			else if (obj instanceof String) {
				result = stringToSQLString((String) obj);				
			} else if (obj instanceof Date) {
				result = dateToSQLString((Date) obj);
			} else if (obj instanceof Integer) {
					result = integerToSQLString((Integer) obj);
			} else if (obj instanceof Double) {
					result = doubleToSQLString((Double) obj);
			} else if (obj instanceof Boolean) {
				result = booleanToSQLString((Boolean) obj);
			} else if (obj instanceof SQLDatabaseFunction) {
				result = sqlFunctionStringToString((SQLDatabaseFunction) obj);
			} else 
			  throw new SQLException("Invalid class in hashTableToSQLInsert");
			
			return result;
		}
		
		private String booleanToSQLString(Boolean b) {
			if (b.booleanValue()) 
				return "1";
			else
				return "0";
		}

		private String stringToSQLString(String s){
			return "'" +  s + "'";
		}
		
		private String sqlFunctionStringToString(SQLDatabaseFunction s){
			return s.getFunction();
		}
		
		private String dateToSQLString(Date d){
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return "'" + df.format(d) + "'";
			//return "CONVERT(datetime, " + "'" + df.format(d) + "'" + ", 20)";
			/*
			DateFormat dateFormatter = DateFormat.getDateInstance(DateFormat.DEFAULT);
			return "'" + dateFormatter.format(d) + "'";
			*/
		}
		
		private String integerToSQLString(Integer i){
			return StringUtils.replaceAll(i.toString(),",","");  
		}
		
		private String doubleToSQLString(Double d){
			return StringUtils.replaceAll(NumberFormat.getInstance(Locale.US).format(d),",","");
		}
		
		public Timestamp sqlNow(){
			return new Timestamp((new java.util.Date()).getTime());
		} 
			
	}	


