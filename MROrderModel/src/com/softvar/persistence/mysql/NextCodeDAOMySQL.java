package com.softvar.persistence.mysql;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;

import com.softvar.persistence.jdbc.INextCodeDAO;
import com.softvar.persistence.jdbc.SQLFunctions;
import com.softvar.util.StringUtils;

public class NextCodeDAOMySQL implements INextCodeDAO {
	private static NextCodeDAOMySQL instance;
	
	private NextCodeDAOMySQL(){
		
	}
	
	public static NextCodeDAOMySQL getInstance(){
		if (instance ==  null){
			instance = new NextCodeDAOMySQL(); 
		}
		return instance;
	}
	
	public int getNextCode(Connection con, Class clazz) throws SQLException {
		int result = 1;
		boolean createRow = false;
		
		String tabela = StringUtils.UnqualifyName(clazz.getName());
		String sql = "SELECT nextcode FROM sys_nextcode WHERE tablename = '" + tabela + "'";
		
		Statement stm = con.createStatement();
		try{
			ResultSet rs = stm.executeQuery(sql);
			try{
				if (rs.next())
					result = rs.getInt("nextcode");
				else
					createRow = true;
			}
			finally{
				rs.close();
				rs = null;
			}			
		}
		finally{
			stm.close();
			stm = null;
		}
		
		if (createRow) {

			Hashtable ht = new Hashtable();
			ht.put("tablename", tabela);
			ht.put("nextcode", new Integer(result + 1));

			sql = SQLFunctions.getInstance().hashTableToSQLInsert("sys_nextcode",
					ht);
			ht = null;

		} else
			sql = "UPDATE sys_nextcode SET nextcode = " + String.valueOf(result + 1) + " WHERE tablename = '" + tabela + "'";

		System.out.println(sql);	
		stm = con.createStatement();
		try {
			stm.execute(sql);
		} finally {
			stm.close();
			stm = null;
		}
		return result;
	}

}
