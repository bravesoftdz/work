package com.mainretail.commun.model.inventory;

import java.io.Serializable;
import java.util.ArrayList;

public class InvCount implements Serializable {
	private static final long serialVersionUID = 4088818169940085276L;
	
	
	public static final int INV_COUNT_CYCLE = 1;
	public static final int INV_COUNT_PHYSICAL = 2;
	public static final int INV_COUNT_LIVE = 3;
	public static final int INV_COUNT_STARTUP = 4;
	
	public int idcount;
	public int idstore;
	public int counttype;
	
	public ArrayList items;
	
	public InvCount(){
		super();
		items = new ArrayList();
	}
	
	public void setItems(ArrayList items) {
		this.items = items;
	}
	
	public void addItem(InvCountItem invCountItem){
		items.add(invCountItem);
	}
	
	public void removeItem(InvCountItem invCountItem){
		items.remove(invCountItem);
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
