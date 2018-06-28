package com.mainretail.commun.model.inventory;

import java.io.Serializable;

public class Model implements Serializable {
	private static final long serialVersionUID = 1154367164784821474L;
	public int idmodel;
	public int idcategory;
	public int idsubcategory;
	public int idgroup;
	public String description;
	public double vendorcost;
	public double sellingprice;
	
	public Model() {

	}
	
	public String toString(){
		return description;
	}
	
	
}