package com.mainretail.commun.model.inventory;

import com.mainretail.commun.model.IParentDAO;

public interface IBarcodeDAO extends IParentDAO {
	public Barcode getBarcode(String idbarcode);
}
