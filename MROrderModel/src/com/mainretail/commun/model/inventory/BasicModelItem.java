package com.mainretail.commun.model.inventory;

import java.io.Serializable;

public class BasicModelItem implements Serializable {
	private static final long serialVersionUID = 5021508169566297149L;
	
	public int idmodel;
	public String description;
	public double costprice;
	public double qty;
	
	public BasicModelItem(){
		super();
	}
}
