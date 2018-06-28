package com.mainretail.inventory.event;

public interface BarcodePrintListListener {
	public void countFinalize(Object invCount);
	public void countRemove(Object invCount);
}
