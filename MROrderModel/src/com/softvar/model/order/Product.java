package com.softvar.model.order;

import java.io.Serializable;

public class Product implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 52788798974155782L;
	public Product() {
		super();
	}
	
	public int idproduct;
	public String UPC;
	public String description;
	
	public boolean equals(Object other) {
		if (other == null){
			return false; 
		}
		else if (other instanceof Product ){
			if (((Product)other).idproduct == this.idproduct){
				return true;				
			} else {
				return false;
			}
		} else 
			return false;
	}
	
}
