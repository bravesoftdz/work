package com.mainretail.commun.model.inventory;

import java.io.Serializable;
import java.util.ArrayList;

public class BarcodePrintList implements Serializable{
	private static final long serialVersionUID = 7617236212518232551L;

	public ArrayList items;
	
	public BarcodePrintList(){
		super();
		items = new ArrayList();
	}
	
	public void setItems(ArrayList items) {
		this.items = items;
	}
	
	public void addItem(BarcodePrintItem barcodePrintItem){
		items.add(barcodePrintItem);
	}
	
	public void removeItem(BarcodePrintItem barcodePrintItem){
		items.remove(barcodePrintItem);
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
