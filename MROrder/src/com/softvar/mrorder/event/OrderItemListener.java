package com.softvar.mrorder.event;

import com.softvar.model.order.OrderItem;

public interface OrderItemListener {
	public void itemChanged(OrderItem item, double oldQty);
	public void itemRemoved(OrderItem item);
	public void itemAdded(String barcode, double qty);
}
