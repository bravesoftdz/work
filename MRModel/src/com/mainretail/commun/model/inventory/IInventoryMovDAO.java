package com.mainretail.commun.model.inventory;

import com.mainretail.commun.model.IParentDAO;

public interface IInventoryMovDAO extends IParentDAO {
	public boolean saveAsItem(InventoryMov obj, Object connection);
}
