package com.mainretail.handheld.purchase;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.Pessoa;

public class PurchaseItem {
	
	public Model model;
	public Pessoa vendor;
	public int idpurchaseitem;
	public int idpurchase;	
	public int idpoitem;
	public String barcode;
	public double newcostprice;
	public double newsaleprice;
	public double newsuggretail;
	public double qty;
	public double costprice;
	public double freightcost;
	public double othercost; 
	
	public PurchaseItem(Model model, Pessoa vendor, int idpurchaseitem, int idpurchase, int idpoitem, String barcode, double newcostprice, double newsaleprice, double newsuggretail, double qty, double costprice, double freightcost, double othercost) {
		super();
		
		this.idpurchaseitem = idpurchaseitem;
		this.idpurchase = idpurchase;
		this.model = model;
		this.vendor = vendor;
		this.idpoitem = idpoitem;
		this.barcode = barcode;
		this.newcostprice = newcostprice;
		this.newsaleprice = newsaleprice;
		this.newsuggretail = newsuggretail;
		this.qty = qty;
		this.costprice = costprice;
		this.freightcost = freightcost;
		this.othercost = othercost;
			
	}

	public PurchaseItem() {
		model = new Model();
	}

	public String toString()
	{
		return idpurchaseitem + " " + vendor.toString() + " " + idpurchase + " " + model.toString() + " " + idpoitem + " " + barcode + " " + newcostprice + " " + newsaleprice + " " + newsuggretail + " " + qty + " " + costprice + " " + freightcost + " " + othercost;
	}

}
