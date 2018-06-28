package com.mainretail.commun.model.purchase;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class PO implements Serializable {
	private static final long serialVersionUID = 2842254662462366779L;
	
	public int idpo;
	public int idvendor;
	public int idstore;
	public int paydays;
	public int paymentetype;
	
	public double freight;
	public double charges;
	public double subtotal;
	
	public boolean aberto;	
	public boolean atendido;
	
	public Date datapedido;
	public Date estarrival;
	
	public String obs;

	
	
	private ArrayList items;
	
	public PO(){
		super();
		items = new ArrayList();
	}
	
	public void setItems(ArrayList items) {
		this.items = items;
	}
	
	public void addItem(POItem poitem){
		items.add(poitem);
	}
	
	public void removeItem(POItem poitem){
		items.remove(poitem);
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

	public ArrayList getItems() {
		return items;
	}
}
