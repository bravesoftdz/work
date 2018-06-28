package com.mainretail.commun.model.purchase;

import java.util.ArrayList;

import com.mainretail.commun.model.inventory.ModelVerifyQty;

public class VerifyReceiving extends Purchase {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1258996252626048832L;
	public ArrayList items;
	
	public VerifyReceiving(){
		super();
		items = new ArrayList();
	}
	
	public void setItems(ArrayList items) {
		this.items = items;
	}
	
	public void addItem(ModelVerifyQty modelVerifyQty){
		items.add(modelVerifyQty);
	}
	
	public void removeItem(ModelVerifyQty modelVerifyQty){
		items.remove(modelVerifyQty);
	}
	
	public void removeItem(int index){
		items.remove(index);
	}
	
	public int getItemCount(){
		return items.size();
	}
	
	public void clear(){
		items.clear();
	}
}
