package com.mainretail.handheldserver.inventoryservlet;

import java.sql.SQLException;

import com.mainretail.handheld.inventory.InvCountItem;

public interface InvCountItemEEDAO {

	public void save(InvCountItem invcountitem)  throws SQLException;
}
