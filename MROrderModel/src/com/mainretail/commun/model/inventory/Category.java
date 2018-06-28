package com.mainretail.commun.model.inventory;

import java.io.Serializable;

public class Category implements Serializable {	
	private static final long serialVersionUID = 7660542638038136550L;
	
	public static final int LEVEL_CATEGORY = 1;
	public static final int LEVEL_SUBCATEGORY = 2;
	public static final int LEVEL_GROUP = 3;
	
	public int id;
	public int type;
	public String category;
	public int order;
	
	public Category(){
		
	}
	
	public String toString(){
		return category;
	}
}
