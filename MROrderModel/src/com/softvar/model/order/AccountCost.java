package com.softvar.model.order;

import java.io.Serializable;

public class AccountCost implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3157537518469675962L;
	public AccountCost() {
		super();
	}
	
	public int idproduct;
	public int idaccount;
	public double cost;

}
