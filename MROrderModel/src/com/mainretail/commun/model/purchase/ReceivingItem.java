package com.mainretail.commun.model.purchase;

import com.mainretail.commun.model.inventory.BasicModelItem;

public class ReceivingItem extends BasicModelItem{
	private static final long serialVersionUID = 350443385083064837L;

	public Integer idpoitem;
	public int idgroup;
	public String barcode;
	public double newcostprice;
	public double newsaleprice;
	public double newsuggretail;
	public double qty;
	public double qtyReceived;
	
	public double freightcost;
	public double othercost;
	
	public ReceivingItem(){
		super();
	}
	
}
