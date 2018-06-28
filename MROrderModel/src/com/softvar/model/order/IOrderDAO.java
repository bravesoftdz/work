package com.softvar.model.order;

import java.util.ArrayList;
import java.util.List;

public interface IOrderDAO {
	public Order getOpenOrder();
	public ArrayList getFinalizedOrders();
	public Order get(Order order);
	public List getItemView(Order order);
}
