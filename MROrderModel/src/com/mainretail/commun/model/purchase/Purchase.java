package com.mainretail.commun.model.purchase;

import java.io.Serializable;
import java.util.Date;

public class Purchase implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3555938615663576121L;
	public int idpurchase;
	public int idstore;
	public int iduserprereceiving;
	public int idpo;
	public int idvendor;
	public String documenttype;
	public String documentnumber;
	public double freight;
	public double othercharges;
	public double subtotal;
	public Date dateprereceiving;
	public Date documentdate;
	public Date documentduedate;
	public Date datefinalreceiving;

}
