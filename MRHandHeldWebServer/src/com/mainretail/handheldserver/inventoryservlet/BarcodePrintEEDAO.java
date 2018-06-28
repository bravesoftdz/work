package com.mainretail.handheldserver.inventoryservlet;

import java.sql.SQLException;

import com.mainretail.handheld.inventory.BarcodePrint;

public interface BarcodePrintEEDAO {
	
	public boolean save(BarcodePrint barcodeprint) throws SQLException;

}
