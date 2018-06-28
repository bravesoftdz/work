package com.mainretail.sales.event;

public interface SaleListener {
	public void saleFinalize(Object sale);
	public void saleRemove(Object sale);
}
