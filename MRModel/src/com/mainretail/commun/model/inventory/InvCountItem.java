package com.mainretail.commun.model.inventory;

import java.util.Date;

public class InvCountItem extends BasicModelItem {
	private static final long serialVersionUID = 5535425466442367100L;
	
	public int idcountitem;
	public int idcount;
	public int iduser;
	public String barcode;
	public double saleprice;
	public Date countdate;
}
