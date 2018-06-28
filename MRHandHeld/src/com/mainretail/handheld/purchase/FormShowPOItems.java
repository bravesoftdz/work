package com.mainretail.handheld.purchase;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.StringItem;

import com.mainretail.util.ParentForm;

public class FormShowPOItems extends ParentForm {

	private Vector vetPOItem;
	private ChoiceGroup lista = null;
	
	public FormShowPOItems() {
		super();
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
	}
	
	
	public void setObjects(Hashtable objects) {
		super.setObjects(objects);
		vetPOItem = (Vector)getObjects().get("VETPOI");		
	}
	
	public void refresh() {
		append(new StringItem(null, "The folowing barcodes cold not be processed"));
		for (Enumeration en = vetPOItem.elements(); en.hasMoreElements();){
			POItem poItem =(POItem)en.nextElement();
			lista.append(poItem.model.barcode + '\n' + '\n' +
						String.valueOf(poItem.qty) + " x " + String.valueOf(poItem.costprice) + 
						'\n' + '\n' + '\n',
						null);		
		}
		vetPOItem = null;
		append(lista);
	}
	
	public void initForm() {
		super.initForm();
		removeCommand(getConfirmButtom());
		refresh();
	}

	public void onSelect(Displayable d) {
	}

}
