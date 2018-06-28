package com.mainretail.handheld;

public class ModelVerifyQty {
	
	public Model model;
	public double qty;
	public double qtyVerified;	
	
	public ModelVerifyQty() {
		super();
	}
		
	public String toString() {
		return model.toString() + String.valueOf(qty) + String.valueOf(qtyVerified);
	}

}
