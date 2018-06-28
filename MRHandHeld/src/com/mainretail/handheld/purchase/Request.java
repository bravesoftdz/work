package com.mainretail.handheld.purchase;

import java.util.Date;

import com.mainretail.handheld.Model;

public class Request {
	
	public Model model;
	
	public int idrequest;
	public int userid;
	public int storeid;
	public int idpreinventorymov;
	public int idcotacao;
	public String type;	
	public String description;
	public double qtyreq;
	public double qtyordered;
	public boolean cotado;
	public Date daterequest;
	public Date delaydate;
	
	public Request() {

	}

	public String toString()
	{
		return idrequest + " " + model.toString() + " " + userid + " " + storeid + " " + idpreinventorymov + " " + idcotacao + " " + type + " " + description + " "  + qtyreq + " " + qtyordered + " " + cotado + " " + daterequest + " " + delaydate;
	}


}
