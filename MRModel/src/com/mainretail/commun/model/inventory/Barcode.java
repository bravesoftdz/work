package com.mainretail.commun.model.inventory;

import java.io.Serializable;

public class Barcode implements Serializable{
	private static final long serialVersionUID = 2925243624667056498L;
	
	public int idmodel;
	public String idbarcode;
	public int barcodeOrder;
	
	public Barcode(){		
	}
	
	public String toString(){
		return idbarcode;
	}
}
