package com.mainretail.commun.model.purchase;

import com.mainretail.commun.model.IParentDAO;

public interface IReceivingDAO extends IParentDAO {
	public Receiving importPO(String idPO);
	public Receiving getActiveReceiving();
}
