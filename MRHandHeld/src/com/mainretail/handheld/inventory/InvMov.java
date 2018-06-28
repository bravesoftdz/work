package com.mainretail.handheld.inventory;

import java.util.Date;

public class InvMov {

	public int idinvmov;
	public int iduser;
	public int idstore;
	public int idinvmovtype;
	public int idmodel;
	public int documentid;
	public String barcode;
	public double qty;
	public Date movdate;
		
	public InvMov(int idinvmov, int iduser, int idstore, int idinvmovtype, int idmodel, int documentid, String barcode, double qty, Date movdate) {
		super();
		this.idinvmov = idinvmov;
		this.iduser = iduser;
		this.idstore = idstore;
		this.idinvmovtype = idinvmovtype; 
		this.idmodel = idmodel;
		this.documentid = documentid; 
		this.barcode = barcode;
		this.qty = qty;
		this.movdate = movdate;
	}

	public InvMov() {

	}

	public String toString()
	{
		return idinvmov + " " + iduser + " " + idstore + " " + idinvmovtype + " " + idmodel + " " + documentid + " " + barcode + " " + qty + " " + movdate;
	}
	
}

