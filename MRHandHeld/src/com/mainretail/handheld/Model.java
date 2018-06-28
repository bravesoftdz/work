package com.mainretail.handheld;

public class Model {

	public int idmodel;
	public int idgroup;
	public String model;	
	public String barcode;
	public String description;
	public double vendorcost;
	public double sellingprice;
	public double suggretail;
	public double qty; 
	
	public Model(int idmodel, int idgroup, String model, String barcode, String description, double qty, double vendorcost, double sellingprice,  double suggretail) {
		super();
		this.idmodel = idmodel;
		this.idgroup = idgroup;
		this.model = model;
		this.barcode= barcode;
		this.description = description;
		this.qty = qty;
		this.vendorcost = vendorcost;
		this.sellingprice = sellingprice;
		this.suggretail = suggretail;		
	}

	public Model() {

	}

	public String toString()
	{
		return idmodel + " " + model + " "+ description +  " " + barcode + " " + qty + " " + idgroup +	" " + vendorcost + " "	+ sellingprice + " " + suggretail;
	}
}