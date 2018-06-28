package com.mainretail.handheld.sales;

import java.util.Hashtable;

import javax.microedition.lcdui.Display;
import javax.microedition.midlet.MIDlet;

import com.mainretail.util.FormLoader;
import com.mainretail.util.ParentMenu;
import com.mainretail.util.Util;

public class SalesMenu extends ParentMenu {
	public SalesMenu(String title, Display display, MIDlet caller, Class[] forms, String[] titles, String[] images) {
		super(title, display, caller, forms, titles, images);
	}
	
	public void onValidateForm() {
		populateInfoTable();
		int i = this.getSelectedIndex();
		Hashtable ht = new Hashtable();
		ht = Util.joinHashtables(ht, getInfoTable());
		FormLoader.loadForm(getForms()[i], getDisplay(), this, ht, getTitles()[i], getImages()[i]);	
	}
}
