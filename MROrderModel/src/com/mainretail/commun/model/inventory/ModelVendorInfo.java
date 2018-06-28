package com.mainretail.commun.model.inventory;

public class ModelVendorInfo {
	public int idmodel;
	public int idvendor;
	public double minQty;
	public double caseQty;
	
	public ModelVendorInfo(int idmodel, int idvendor) {
		super();
		this.idmodel = idmodel;
		this.idvendor = idvendor;
	}
	
	public ModelVendorInfo(){
		super();
	}
}
