package com.mainretail.util;

import java.util.Hashtable;

import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;

public class FormLoader {

	public static Object loadForm(Class formClass, Display display, Displayable caller, Hashtable objects, String title, String image){
		return loadForm(formClass, display, caller, objects, title, image, null);					
	}
	
	public static Object loadForm(Class formClass, Display display, Displayable caller, Hashtable objects, String title, String image, Alert alert){
		InitialInfo form = null;
		Object formObject = null;
		try {		
			formObject =  createForm(formClass);							 
			try {
				
				if (formObject instanceof InitialInfo) {
					form = (InitialInfo)formObject;
					
					form.setObjects(objects);
					
					form.setInfo(title, display, caller, image);
					
					if (form instanceof Displayable)
						if (alert == null) 
							display.setCurrent((Displayable)form);
						else
							display.setCurrent(alert, (Displayable)form);
					
				}
			}catch(Exception e){
				e.printStackTrace();
			}				
		}
		finally {
			form = null;
		}
		
		return formObject;
		
	}
	
	private static Object createForm(Class formClass){
		Object object = null;
				
		try {
			
			//Class classeForm = Class.forName(formClassName);

			object =  formClass.newInstance();
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return object;
	}
	
}
