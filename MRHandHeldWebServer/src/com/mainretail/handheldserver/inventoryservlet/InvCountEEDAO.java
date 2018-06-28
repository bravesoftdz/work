package com.mainretail.handheldserver.inventoryservlet;

import java.sql.SQLException;

import com.mainretail.handheld.inventory.InvCount;
 
public interface InvCountEEDAO {

	public InvCount find(int idstore, int counttype) throws SQLException;
}