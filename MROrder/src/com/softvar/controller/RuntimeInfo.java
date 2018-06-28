package com.softvar.controller;

import com.softvar.model.Customer;


public class RuntimeInfo {
	
	public static RuntimeInfo instance;
	
	public Customer customer;

	private RuntimeInfo(){
	}
	
	public static RuntimeInfo getInstance(){
		if (instance == null)
			instance = new RuntimeInfo();
		return instance;
	}
}
