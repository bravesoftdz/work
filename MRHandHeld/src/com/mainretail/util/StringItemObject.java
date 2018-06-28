package com.mainretail.util;

import javax.microedition.lcdui.StringItem;

public class StringItemObject extends StringItem implements ItemObject {
	
	public StringItemObject(String arg0, String arg1, Object object) {
		super(arg0, arg1);
		this.object = object;
	}
	
	public StringItemObject(String arg0, String arg1, int arg2, Object object) {
		super(arg0, arg1, arg2);
		this.object = object;
	}

	private Object object;
	
	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}

}
