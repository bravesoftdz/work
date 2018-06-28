package com.mainretail.commun.model.purchase;

import java.util.ArrayList;

public class Receiving extends Purchase {

	private static final long serialVersionUID = 2842254662462366779L;
	public ArrayList items;
	
	public Receiving(){
		super();
		items = new ArrayList();
	}
	
	public void setItems(ArrayList items) {
		this.items = items;
	}
	
	public void addItem(ReceivingItem receivingItem){
		items.add(receivingItem);
	}
	
	public void removeItem(ReceivingItem receivingItem){
		items.remove(receivingItem);
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
