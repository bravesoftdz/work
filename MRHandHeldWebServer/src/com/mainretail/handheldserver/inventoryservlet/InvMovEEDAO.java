package com.mainretail.handheldserver.inventoryservlet;

import java.sql.SQLException;

import com.mainretail.handheld.inventory.InvMov;

public interface InvMovEEDAO {

	public void save(InvMov invmov)  throws SQLException;
}



