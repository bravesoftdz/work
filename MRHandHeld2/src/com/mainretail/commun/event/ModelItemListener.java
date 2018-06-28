package com.mainretail.commun.event;

public interface ModelItemListener {
	public void itemAdded(Object model, String barcode, double qty);
	public void itemRemoved(Object item);
	public void itemChanged(Object item, double oldQty);
	public void barcodeNotFound(String barcode, double qty);
}
