package com.mainretail.purchase.event;

public interface ReceivingEditionListener extends EditionListener {
	public void importPO();
	public void finish();
	public void save();
}
