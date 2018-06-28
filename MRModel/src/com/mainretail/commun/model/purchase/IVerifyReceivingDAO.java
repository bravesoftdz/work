package com.mainretail.commun.model.purchase;

import com.mainretail.commun.model.IParentDAO;
import com.mainretail.commun.model.inventory.ModelVerifyQty;

public interface IVerifyReceivingDAO extends IParentDAO {
	public VerifyReceiving getPurchase(String documentNumber);
	public VerifyReceiving getPurchase(int idpurchase);
	public VerifyReceiving getActiveVerifyreceiving();
	public ModelVerifyQty getItem(int idpurchase, int idmodel);
}
