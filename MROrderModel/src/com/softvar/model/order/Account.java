package com.softvar.model.order;

import java.io.Serializable;

public class Account implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1046727842707262984L;
	public Account() {
		super();
	}
	
	

	public int idaccount;
	public String accountnum;
	public String accountname;
	
	
	public boolean equals(Object other) {
		if (other == null){
			return false; 
		}
		else if (other instanceof Account ){
			if (((Account)other).idaccount == this.idaccount){
				return true;				
			} else {
				return false;
			}
		} else 
			return false;
	}
}
