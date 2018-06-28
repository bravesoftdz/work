package com.mainretail.commun.model.inventory;

import java.io.Serializable;

public class ModelVerifyQty implements Serializable {
	private static final long serialVersionUID = -4486613581380207995L;
	
	public int idmodel;
	public String description;
	public double qty;
	public double qtyReceived;
}
