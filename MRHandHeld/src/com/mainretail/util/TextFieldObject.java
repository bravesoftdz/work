package com.mainretail.util;

import javax.microedition.lcdui.TextField;

public class TextFieldObject extends TextField implements ItemObject{
	private Object object;

	public TextFieldObject(String arg0, String arg1, int arg2, int arg3, Object object) {
		super(arg0, arg1, arg2, arg3);
		this.object = object;
	}

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}
	
}
