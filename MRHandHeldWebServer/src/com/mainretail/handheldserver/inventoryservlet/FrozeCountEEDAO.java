package com.mainretail.handheldserver.inventoryservlet;

import java.sql.SQLException;

import com.mainretail.handheld.inventory.FrozeCount;

public interface FrozeCountEEDAO {
	
	public boolean save(FrozeCount frozecount) throws SQLException;

}
