package com.mainretail.commun.model.inventory;

import com.mainretail.commun.model.IParentDAO;

public interface IFrozeCountDAO extends IParentDAO {
	public boolean saveAsItem(Object connection, FrozeCount obj);
}
