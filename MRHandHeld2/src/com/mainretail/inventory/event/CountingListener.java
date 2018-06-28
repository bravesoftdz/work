package com.mainretail.inventory.event;

public interface CountingListener {
	public void countFinalize(Object invCount);
	public void countRemove(Object invCount);
}
