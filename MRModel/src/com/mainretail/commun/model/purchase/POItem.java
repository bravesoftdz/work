package com.mainretail.commun.model.purchase;

import java.util.Date;

import com.mainretail.commun.model.inventory.BasicModelItem;

public class POItem extends BasicModelItem {

	private static final long serialVersionUID = -2421959221715112045L;
	
	public int idpoitem;
	public int inventmovtypeid;
	public int storeid;
	public int idpessoa;
	public int iduser;
	
	
	public int documentid;
	public String barcode;
	public double costprice;
	public double saleprice;
	public double suggretail;
	
	public double qtyrealmov;
	public Date movdate;
	public Date dateestimatedmov;
	public Date daterealmov;
	
	public POItem(){
		super();
	}
}
