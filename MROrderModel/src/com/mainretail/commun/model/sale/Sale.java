package com.mainretail.commun.model.sale;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

import com.mainretail.commun.model.User;

public class Sale implements Serializable {
	private static final long serialVersionUID = -2863509907372763855L;
	
	public int idstore; 
	public Date saleDate;
	public ArrayList items;
	public boolean finalized;
	public int iduser;
	public int idcommission;
	public String salecode;
	
	public Sale() {
		super();
		items = new ArrayList();
	}
	
	public Sale(int idstore, Date date, User user) {
		items = new ArrayList();
		this.idstore = idstore;
		this.saleDate = date;
		this.iduser = user.iduser;
		this.idcommission = user.idcommission;
	}

	public ArrayList getItems() {
		return items;
	}
	
	public void setItems(ArrayList items) {
		this.items = items;
	}
	
	public void addItem(SaleItem saleItem){
		items.add(saleItem);
	}
	
	public void removeItem(SaleItem saleItem){
		items.remove(saleItem);
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
	
	public double getSaleTotal(){
		double total = 0;
		for(int i = 0; i < items.size(); i++)
			total = total + ((SaleItem)(items.get(i))).qty * ((SaleItem)(items.get(i))).salePrice;
		return total;
	}
	
	public void finalize(){
		
	}
	
	/*
	public boolean equals(Object obj){
		if (obj == this)
			return true;
		else 
			if (obj instanceof Sale){
				Sale otherSale = (Sale)obj;
				if ((this.idstore == otherSale.idstore) && (this.saleDate == otherSale.saleDate))
					return true;
				else
					return false;
			}
			else
				return false;
	}*/
}
