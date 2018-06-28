package com.mainretail.handheld;

public class BarcodeVerifyQty {
	
	public String barcode;
	public double qty;	
	
	public BarcodeVerifyQty() {
		super();
	}
		
	public String toString() {
		return barcode + String.valueOf(qty);
	}

	
}

