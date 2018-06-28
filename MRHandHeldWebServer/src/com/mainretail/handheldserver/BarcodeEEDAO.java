package com.mainretail.handheldserver;

import java.sql.SQLException;

import com.mainretail.handheld.Barcode;

public interface BarcodeEEDAO {
	
	public Barcode searchBarcode(Barcode barcode) throws SQLException;
	public Barcode searchBarcode(String barcode) throws SQLException;

}
