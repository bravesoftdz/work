package com.mainretail.handheld.purchase;

import java.util.Date;

import com.mainretail.handheld.Pessoa;

public class Purchase {
	
	public Pessoa vendor;
	
	public int idpurchase;
	public int idstore;
	public int iduserprereceiving;
	public int idpo;
	public String documenttype;
	public String documentnumber;
	public double freight;
	public double othercharges;
	public double subtotal;
	public Date dateprereceiving;
	public Date documentdate;
	public Date documentduedate;
	public Date datefinalreceiving;
	
		
	public Purchase(Pessoa vendor, int idpurchase, int idstore, int iduserprereceiving, int idpo, String documenttype, String documentnumber, double freight, double othercharges, double subtotal, Date dateprereceiving, Date documentdate, Date documentduedate, Date datefinalreceiving) {
		super();
		
		this.idpurchase = idpurchase;
		this.vendor = vendor;
		this.idstore = idstore;
		this.iduserprereceiving = iduserprereceiving;
		this.idpo = idpo;
		this.documenttype = documenttype;
		this.documentnumber = documentnumber;
		this.freight = freight;
		this.othercharges = othercharges;
		this.subtotal = subtotal;
		this.dateprereceiving = dateprereceiving;
		this.documentdate = documentdate;
		this.documentduedate = documentduedate;
		this.datefinalreceiving = datefinalreceiving;
		this.subtotal = subtotal;
	}

	public Purchase() {

	}

	public String toString()
	{
		return idpurchase + " " + vendor.toString() + " " + idstore + " " + iduserprereceiving + " " + idpo + " " + documenttype + " " + documentnumber + " " + freight + " " + othercharges  + " " + subtotal + " " + dateprereceiving + " " + documentdate + " " + documentduedate + " " + datefinalreceiving;
	}

}