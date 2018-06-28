package com.softvar.mrorder.event;

import java.util.Vector;

public interface OrderSynchListener {
	public void afterSynch(Vector ordersList);
}
