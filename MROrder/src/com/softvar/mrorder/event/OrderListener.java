package com.softvar.mrorder.event;

import com.softvar.model.order.Order;

public interface OrderListener {
	public void orderRemove(Order order);
	public void orderFinalize(Order order);
}
