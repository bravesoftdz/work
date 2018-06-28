package com.mainretail.commun.model.inventory;

import com.mainretail.commun.model.IParentDAO;

public interface IBarcodePrintListDAO extends IParentDAO {
	public BarcodePrintList getOpenBarcodePrintList();
}
