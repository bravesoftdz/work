package com.mainretail.commun.controller;

import com.mainretail.commun.model.User;

public class RuntimeInfo {
	
	public static RuntimeInfo instance;
	
	public User user;

	private RuntimeInfo(){
	}
	
	public static RuntimeInfo getInstance(){
		if (instance == null)
			instance = new RuntimeInfo();
		return instance;
	}
}
