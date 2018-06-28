package com.mainretail.handheld.inventory;

import com.mainretail.handheld.Model;

public class FrozeCount {
	
	public Model model;
	public int idcount;
	public double qty;
	
	public FrozeCount() {
    	
    }
    
    public String toString() {
    	return idcount + " " + model.toString() + " " + qty;
    }

}
