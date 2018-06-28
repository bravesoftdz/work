package com.mainretail.handheld;

import java.util.Date;

public class Barcode {
	
	public Model model;
	
	public String idbarcode;
	public Date data;
	
	public Barcode() {

	}

	public String toString()
	{
		return idbarcode + " " + model.toString() + " "+ data;
	}

}
