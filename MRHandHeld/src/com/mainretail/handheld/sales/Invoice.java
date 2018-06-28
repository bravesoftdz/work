package com.mainretail.handheld.sales;

import java.util.Date;

public class Invoice {
	
	public static int DELIVER_TYPE_ONHAND = 1;
	
	public int idpresale;
	public int idcustomer; 
	public int idtouristgroup; 
	public int idmedia; 
	public int iddelivertype; 
	public int idothercommission; 
	public int idstore;
	public String firstname; 
	public String lastname;
	public String salecode;
	public String zip;
	public String note; 
	public boolean layaway; 
	public boolean printnotes;
	public Date presaledate; 
	
	public Invoice(int idpresale, int idcustomer, int idtouristgroup, int idmedia, int iddelivertype, int idothercommission, int idstore, String firstname, String lastname, String salecode, String zip, String note, boolean layaway, boolean printnotes, Date presaledate) {
		super();
		
		this.idpresale = idpresale;
		this.idcustomer = idcustomer; 
		this.idtouristgroup = idtouristgroup; 
		this.idmedia = idmedia; 
		this.iddelivertype = iddelivertype; 
		this.idothercommission = idothercommission; 
		this.idstore = idstore;
		this.firstname = firstname; 
		this.lastname = lastname;
		this.salecode = salecode;
		this.zip = zip;
		this.note = note; 
		this.layaway = layaway; 
		this.printnotes = printnotes;
		this.presaledate = presaledate; 
	}	
	public Invoice() {

	}

	public String toString()
	{
		return idpresale + " " + idcustomer + " " + idtouristgroup + " " + idmedia + " " + iddelivertype + " " + idothercommission + " " + idstore + " " + firstname + " " + lastname + " " + salecode + " " + zip + " " + note + " " + layaway + " " + presaledate;
	}

}
