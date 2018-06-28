package com.mainretail.commun.model;

import java.io.Serializable;

public class User implements Serializable {

	private static final long serialVersionUID = -6845049360448600467L;
	private static final int USER_TYPE_ADIM = 1;
	
	public String username;
	public String pw;
	public int iduser;
	public int idcommission;
	public int idusertype;
	
	public User() {
		
	}
	
	public boolean isAdministrator(){
		return (idusertype == USER_TYPE_ADIM);
	}

}
