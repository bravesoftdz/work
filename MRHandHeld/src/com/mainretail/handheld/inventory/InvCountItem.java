package com.mainretail.handheld.inventory;

import java.util.Date;

public class InvCountItem {

	public int idcountitem;
	public int idcount;
	public int iduser;
	public String barcode;
	public double qty;
	public double saleprice;
	public Date countdate;
	public int idmodel;

	public InvCountItem(int idcountitem, int idcount, int iduser, int idmodel, String barcode, double qty, double saleprice, Date countdate) {
		super();
		this.idcountitem = idcountitem;
		this.idcount = idcount;
		this.iduser = iduser;
		this.idmodel = idmodel;
		this.barcode = barcode;
		this.qty = qty;
		this.saleprice = saleprice;
		this.countdate = countdate;
	}

	public InvCountItem() {

	}

	public String toString()
	{
		return idcountitem + " " + idcount + " " + iduser + " " + idmodel + " " + barcode + " " + qty + " " + saleprice + " " + countdate;
	}
}