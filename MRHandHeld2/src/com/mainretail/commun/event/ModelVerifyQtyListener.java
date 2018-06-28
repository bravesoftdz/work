package com.mainretail.commun.event;

import com.mainretail.commun.model.inventory.ModelVerifyQty;

public interface ModelVerifyQtyListener {
	public void itemAdded(ModelVerifyQty modelVerifyQty, Double qtyAdded);
}
