package com.mainretail.util;
import java.util.Hashtable;

import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;

import com.mainretail.handheld.User;

public interface InitialInfo {
	
	public void onSelect(Displayable d);
	
	public String getConfirmButtomName();
	
	public void initForm();
	
	public Display getDisplay();
	
	public Displayable getCaller();
	
	public void setInfo(String title, Display display, Displayable caller, String image);
	
	public void refresh();
	
	public void defaultValues();
	
	public void setObjects(Hashtable objects);
	
	public Hashtable getObjects();
	
	public void setUser(User user);
	
	public User getUser();
}