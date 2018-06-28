package com.mainretail.handheldserver;

import java.sql.SQLException;

import com.mainretail.handheld.Model;
 
public interface ModelEEDAO {

	public void save(Model product)  throws SQLException;
		
	public Model findByBarCode(String barcode) throws SQLException;
	
	
}