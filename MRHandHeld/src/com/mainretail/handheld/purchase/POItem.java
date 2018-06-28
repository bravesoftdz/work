package com.mainretail.handheld.purchase;

import java.util.Date;

import com.mainretail.handheld.Model;

public class POItem {
	
	public Model model;
	public int idpoitem;
	public int inventmovtypeid;
	public int storeid;
	public int idpessoa;
	public int userid;
	public int documentid;
	public String barcode;
	public double costprice;
	public double saleprice;
	public double suggretail;
	public double qty;
	public double qtyrealmov;
	public Date movdate;
	public Date dateestimatedmov;
	public Date daterealmov;
	
	
	/*public POItem(Model model, int idpoitem, int inventmovtypeid, int storeid, int idpessoa, int userid, int idcotacao, int idpreinventorymovparent, int documentid, int idparentpack, int idmodelservice, int idpreinvmovexchange, int exchangeinvoice, String barcode, String marked,  double costprice, double saleprice, double discount, double suggretail, double desiredmarkup, double qty, double qtyrealmov, double qtyexceeded, double qtyexchanged, Date movdate, Date dateestimatedmov, Date daterealmov) {
		super();
		
		this.idpoitem = idpoitem;
		this.model = model;
		this.inventmovtypeid = inventmovtypeid;
		this.storeid = storeid; 
		this.idpessoa = idpessoa;
		this.userid = userid;
		this.idcotacao = idcotacao;
		this.idpreinventorymovparent = idpreinventorymovparent;
		this.documentid = documentid;
		this.idparentpack = idparentpack;
		this.idmodelservice = idmodelservice;
		this.idpreinvmovexchange = idpreinvmovexchange;
		this.exchangeinvoice = exchangeinvoice;
		this.barcode = barcode;
		this.marked = marked;
		this.costprice = costprice;
		this.saleprice = saleprice;
		this.discount = discount;
		this.suggretail = suggretail;
		this.desiredmarkup = desiredmarkup;
		this.qty = qty;
		this.qtyrealmov = qtyrealmov;
		this.qtyexceeded = qtyexceeded;
		this.qtyexchanged = qtyexchanged;
		this.movdate = movdate;
		this.dateestimatedmov = dateestimatedmov;
		this.daterealmov = daterealmov;			
	}*/

	public POItem() {

	}

	public String toString()
	{
		return idpoitem + " " + inventmovtypeid + " " + storeid + " " + model.toString() + " " + idpessoa + " " + userid + " " + documentid + " " + barcode + " " + costprice + " " + saleprice + " " + suggretail + " " + qty + " " + qtyrealmov + " " + movdate + " " + dateestimatedmov + " " + daterealmov;
	}
	
	public POItem clone() {
		POItem result = new POItem();
		result.model = this.model;
		result.idpoitem = this.idpoitem;
		result.inventmovtypeid = this.inventmovtypeid;
		result.storeid = this.storeid;
		result.idpessoa = this.idpessoa;
		result.userid = this.userid;
		result.documentid = this.documentid;
		result.barcode = this.barcode;
		result.costprice = this.costprice;
		result.saleprice = this.saleprice;
		result.suggretail = this.suggretail;
		result.qty = this.qty;
		result.qtyrealmov = this.qtyrealmov;
		result.movdate = this.movdate;
		result.dateestimatedmov = this.dateestimatedmov;
		result.daterealmov = this.daterealmov;
		return result;
	}

}

