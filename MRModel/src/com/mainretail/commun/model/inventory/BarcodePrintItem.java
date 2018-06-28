package com.mainretail.commun.model.inventory;

import java.io.Serializable;

public class BarcodePrintItem implements Serializable{

	private static final long serialVersionUID = -6010601703322736345L;

	public String idbarcode;
	public int iduser;
	public int qty;
	
	public BarcodePrintItem(){
		super();
	}
}
