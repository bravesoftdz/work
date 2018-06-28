package com.mainretail.commun.model.purchase;

import com.mainretail.commun.model.IParentDAO;

public interface IPODAO extends IParentDAO {
	public PO getActivePO();
}
