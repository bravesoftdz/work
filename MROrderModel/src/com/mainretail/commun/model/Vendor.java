package com.mainretail.commun.model;

import java.io.Serializable;

public class Vendor implements Serializable{
	
	private static final long serialVersionUID = -837547464979386336L;

	public int idvendor;
	public String vendor;

	public String toString(){
		return vendor;
	}
	
}
