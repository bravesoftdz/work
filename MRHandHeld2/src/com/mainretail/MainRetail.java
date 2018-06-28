package com.mainretail;

import java.io.File;
import java.util.Locale;

import softvar.FileUtil;

import com.mainretail.commun.model.Config;
import com.mainretail.commun.ui.MainForm;

public class MainRetail {
    public static void main(String[] args) {
    	/*
    	for(Enumeration en = System.getProperties().propertyNames(); en.hasMoreElements();){
    		String property = (String)en.nextElement();
    		String value = System.getProperties().getProperty(property);
    		System.out.println(property + " = " + value);
    	}
    	*/
    	
    	if (!System.getProperties().getProperty("os.name").equals("Windows XP"))
    		moveOldFiles();
    	
    	Locale currentLocale = Config.getInstance().getLocale();
    	
    	if (currentLocale != null)
    		Locale.setDefault(Config.getInstance().getLocale());
    	
    	/*
    	try{
	    	Shell shell = Shell.INSTANCE;
	    	int hwnd = shell.GetSafeHwnd();    	
	    	System.out.println(hwnd);
    	} catch(Throwable t){
    		t.printStackTrace();
    	}
    	*/
    	
    	
       	MainForm inst = new MainForm();
	    inst.setVisible(true);
    }
    
    private static void moveOldFiles(){
    	moveOldFile(Config.USER_DIR + Config.CONFIG_FILE, Config.APP_DIR + Config.CONFIG_FILE);
    	moveOldFile(Config.USER_DIR + Config.DATABASE_NAME, Config.APP_DIR + Config.DATABASE_NAME);
    }
    
    private static void moveOldFile(String source, String dest){
    	try{
    		File oldFile = new File(source);
    		if (oldFile.exists()){
    			File newFile = new File(dest);
    			FileUtil.copyFile(oldFile, newFile);
    			oldFile.delete();   			
    		}
    	} catch(Throwable t){
    		
    	}
    	
    }
    
}