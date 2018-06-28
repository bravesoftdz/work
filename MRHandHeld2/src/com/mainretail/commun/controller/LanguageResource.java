package com.mainretail.commun.controller;

import java.util.Locale;
import java.util.ResourceBundle;

public class LanguageResource {

	private static LanguageResource instance;
	private static ResourceBundle messages;
	
	private LanguageResource(){
	}
	
	public static LanguageResource getInstance() {
		if (instance == null){
			instance = new LanguageResource();
			load();
		}
		return instance;
	}
	
	public static void load(){
        messages = ResourceBundle.getBundle("MessagesBundle", Locale.getDefault());
	}

	public String getText(String key){
		return messages.getString(key); 
	}
	
}
