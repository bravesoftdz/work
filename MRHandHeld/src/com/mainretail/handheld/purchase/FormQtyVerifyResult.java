package com.mainretail.handheld.purchase;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Displayable;
import javax.microedition.rms.RecordStoreException;

import com.mainretail.handheld.Config;
import com.mainretail.handheld.ModelVerifyQty;

public class FormQtyVerifyResult extends com.mainretail.util.ParentForm {
	
	private Vector vetModelVerifyQty = null;
	private ChoiceGroup lista = null;
	
	
	public FormQtyVerifyResult() {
		super();
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
	}

	public void onSelect(Displayable d) {
		getDisplay().setCurrent(getCaller());
	}
	
	public void refreshComponentArray(){
		refresh();		
		lista.deleteAll();
		
		for (Enumeration en = vetModelVerifyQty.elements(); en.hasMoreElements();){
			ModelVerifyQty mvq =(ModelVerifyQty)en.nextElement();
			
			lista.append(mvq.model.model + '\n' + '\n' +
					"Qty Purchase: " + String.valueOf(mvq.qty) + '\n' +
					"Qty Received: " + String.valueOf(mvq.qtyVerified) + '\n' +
					"Difference: " + String.valueOf(mvq.qty - mvq.qtyVerified) + '\n'+ '\n' + '\n',
					null);	
		}
	}

	public void initForm() {
		super.initForm();
		removeCommand(getConfirmButtom());
		refreshComponentArray();
		Config.getInstance().lastVerifyReceiving = "";
		try {
			Config.getInstance().save();
		} catch (RecordStoreException e) {
			e.printStackTrace();
		}
	}

	public void refresh() {
		deleteAll();
		append(lista);
	}

	public void setObjects(Hashtable objects) {
		super.setObjects(objects);
		vetModelVerifyQty = (Vector)getObjects().get("VETCONF");
	}
	
	public void beforeExit() {
		lista.deleteAll();
		vetModelVerifyQty.removeAllElements();
		vetModelVerifyQty = null;
	}

}
