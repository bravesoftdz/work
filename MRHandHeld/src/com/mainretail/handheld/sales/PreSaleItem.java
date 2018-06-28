package com.mainretail.handheld.sales;

import java.util.Date;

import com.mainretail.handheld.Model;

public class PreSaleItem {
	
	public Model model;
	public int idpresale;
	public int idcliente;
	public int idstore;
	public int iduser;
	public int idcomission;
	public int idpreinvmovexchange;
	public int idpreinventmov;
	public int iddepartment;
	public double qty;
	public double saleprice;
	public double costprice;
	public double discount;
	public boolean resetdiscount;
	public boolean manager;
	public boolean promo;
	public Date movdate;
	public Date presaledate;
	
	 
	
	
	
	public PreSaleItem(Model model, int idpresale, int idcliente, int idstore, int iduser, int idcomission, int idpreinvmovexchange, int idpreinventmov, int iddepartment, double qty, double saleprice, double costprice, double discount, boolean resetdiscount, boolean manager, boolean promo, Date movdate, Date presaledate) {
		super();
		
		this.idpresale = idpresale;
		this.model = model;
		this.idcliente = idcliente;
		this.idstore = idstore;
		this.iduser = iduser;
		this.idcomission = idcomission;
		this.idpreinvmovexchange = idpreinvmovexchange;
		this.idpreinventmov = idpreinventmov;
		this.iddepartment = iddepartment;
		this.qty = qty;
		this.saleprice = saleprice;
		this.costprice = costprice;
		this.discount = discount;
		this.resetdiscount = resetdiscount;
		this.manager = manager;
		this.promo = promo;
		this.movdate = movdate;
		this.presaledate = presaledate;			
	}

	public PreSaleItem() {

	}

	public String toString()
	{
		return idpresale + " " + model.toString() + " " + idcliente + " " + idstore + " " + iduser + " " + idcomission + " " + idpreinvmovexchange + " " + idpreinventmov + " " + iddepartment + " " + qty + " " + saleprice + " " + costprice + " " + discount + " " + resetdiscount + " " + manager + " " + promo + " " + movdate + " " + presaledate;
	}
	
	public PreSaleItem clone(){
		PreSaleItem result = new PreSaleItem();
		
		result.model = this.model;
		result.idpresale = this.idpresale;
		result.idcliente = this.idcliente;
		result.idstore = this.idstore;
		result.iduser = this.iduser;
		result.idcomission = this.idcomission;
		result.idpreinvmovexchange = this.idpreinvmovexchange;
		result.idpreinventmov = this.idpreinventmov;
		result.iddepartment = this.iddepartment;
		result.qty = this.qty;
		result.saleprice = this.saleprice;
		result.costprice = this.costprice;
		result.discount = this.discount;
		result.resetdiscount = this.resetdiscount;
		result.manager = this.manager;
		result.promo = this.promo;
		result.movdate = this.movdate;
		result.presaledate = this.presaledate;

		return result;
	}

}
