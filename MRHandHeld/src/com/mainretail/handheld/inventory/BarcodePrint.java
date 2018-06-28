package com.mainretail.handheld.inventory;

import java.util.Date;

import com.mainretail.handheld.Barcode;

public class BarcodePrint {
	
	public Barcode barcode;
	
    public int qtd;
    public int iduser; 
    public Date date;
    
    public BarcodePrint() {
    	
    }
    
    public String toString() {
    	return barcode.toString() + " " + qtd + " " + iduser + " " + date;
    }

}
