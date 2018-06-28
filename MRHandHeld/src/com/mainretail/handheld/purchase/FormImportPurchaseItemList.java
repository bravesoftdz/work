package com.mainretail.handheld.purchase;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.ItemStateListener;
import javax.microedition.lcdui.Spacer;
import javax.microedition.lcdui.TextField;
import javax.microedition.rms.RecordStoreException;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.Config;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelVerifyQty;
import com.mainretail.handheld.ModelVerifyQtyService;
import com.mainretail.handheld.ParentFormPersistent;
import com.mainretail.util.FormLoader;
import com.mainretail.util.TextFieldObject;
import com.mainretail.util.Util;

public class FormImportPurchaseItemList extends ParentFormPersistent {
	
	//private Vector vetModelVerifyQty = null;
	private Vector vetBarcode = null;
	private Vector vetConference = null;
	
	private TextFieldObject barcode = null;
	private Spacer spacerBarcode = null;
	
	private Command editButtom = null;
	private Command findBarcodeButtom = null;
	
	private ChoiceGroup lista = null;
	
	private String rsName = null;
	
	public FormImportPurchaseItemList() {
		super();
		
		barcode = new TextFieldObject("Barcode", null, 30, TextField.ANY, null);
		spacerBarcode = new Spacer(50, 5);
		editButtom = new Command("Edit", Command.OK, 2);
		findBarcodeButtom = new Command("Find", Command.OK, 4);
		
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
			
		setAnonymousItemStateListener();
	}
	
	public void defaultValues() {		
	}

	public void initForm() {
		super.initForm();
		loadRecordStore();
		refreshComponentArray();
	}
	
	private void selectButtoms(boolean finalization){
		removeCommand(editButtom);		
		removeCommand(findBarcodeButtom);
		removeCommand(getConfirmButtom());
		
		if (finalization) {
			
		}			
		else {			
			addCommand(findBarcodeButtom);
			addCommand(editButtom);
			renameConfirmButtom("Result");
		}
		
		/*
		if (finalization) {
			renameConfirmButtom("Send");			
		} else {			
			if (!vetModelVerifyQty.isEmpty()){
				addCommand(editButtom);
				renameConfirmButtom("Save");
			}
			
		}
		*/
		renameBackButtom("Back");
	}
	
	public void beforeExit() {
		//vetModelVerifyQty.removeAllElements();
		//discardRS();
		unloadRecordStore();
		
		vetBarcode.removeAllElements();		
		//vetModelVerifyQty = null;
		vetBarcode = null;		
	}
	
	public void setObjects(Hashtable objects) {
		super.setObjects(objects);
		//purchase = (Purchase)getObjects().get("PURCHASE"); 
		rsName = (String)getObjects().get("RSMVQ"); 
		//vetModelVerifyQty = (Vector)getObjects().get("VETMVQ");
		vetBarcode = (Vector)getObjects().get("VETBCD");
	}	
	
	public void refresh() {
		deleteAll();
		append(barcode);
		append(spacerBarcode);
		
		barcode.setString("");
				
		append(lista);
		selectButtoms(false);
	}
	
	private void renameConfirmButtom(String newName){
		if (getConfirmButtom() != null){
			removeCommand(getConfirmButtom());
			setConfirmButtom(null);
		}
		setConfirmButtom(new Command(newName, Command.OK, 1));
		addCommand(getConfirmButtom());
	}
	
	private void renameBackButtom(String newName){
		if (getBackButtom() != null){
			removeCommand(getBackButtom());
			setBackButtom(null);
		}
		setBackButtom(new Command("Back", Command.BACK, 1));
		addCommand(getBackButtom());
	}
	
	
	public void processCommand(Command c, Displayable d) {
		switch (c.getCommandType()) {
			case Command.BACK:{
				if (getConfirmButtom().getLabel().equals("Result")) {
					onExit();
				} else {
					refresh();
				}
				
				break;
			}
			case Command.OK:
			case Command.SCREEN:{
				
				int i = lista.getSelectedIndex();
				ModelVerifyQty mvq = null;
				if (i >= 0) {
					mvq = (ModelVerifyQty)getRSItem(i);				
				}
				
				switch (c.getPriority()){
					case 0:{
						
					}
					case 1:{
						showConference();
						/*
						if (getConfirmButtom().getLabel().equals("Save")) {
							showConference();
						} else {
							//sendPurchase();
						}
						*/
						break;
					}
					case 2:{
						if (mvq != null){
							callEditForm(mvq, i);
						}
						break;
					}					
					case 4:{
						
						if (!barcode.getString().trim().equals("")) {
							endBarcodeScan();	
						}	
						
						break;
					}
				} 
				break;
			}
		}
		
	}

	public void onSelect(Displayable d) {
		
	}
	
	private void setAlertAddBarcode(final ModelVerifyQty mqv, final int index) {
		
		Alert alert = new Alert("Alert", "Barcode does not exist in this Purchase.", null, AlertType.WARNING);
		alert.setTimeout(Alert.FOREVER);
		
		getDisplay().setCurrent(alert);
		
		CommandListener cmdLstnr = new CommandListener(){			
			public void commandAction(Command c, Displayable d) {
				barcode.setString("");
				callEditForm(mqv, index);
			}
		};
		
		alert.setCommandListener(cmdLstnr);
	}
	
	private void setAnonymousItemStateListener(){
		this.setItemStateListener(new 
				ItemStateListener(){
					public void itemStateChanged(Item item) {		
						if (item instanceof TextField) {
							TextField textFiled = (TextField)item; 
							int i = textFiled.getString().indexOf(Config.getInstance().upcSufix);
							if (i > 0){
								textFiled.setString(textFiled.getString().substring(0, i));
								endBarcodeScan();
							}
						}
					}
				}
			);
	}
	
	public void endBarcodeScan(){
		ModelVerifyQty mqv = null;
		int i = searchFirstModelVerifyQty(barcode.getString());
		if (i != -1)
		  mqv = (ModelVerifyQty)getRSItem(i);
		
		if (mqv == null) {
			mqv = new ModelVerifyQty();
			
			mqv.model = new Model();
			mqv.model.model = "Not Found";
			mqv.model.description = "Not Found";
			mqv.qty = 0;
			mqv.qtyVerified = 0;
			addRSItem(mqv);
			
			Barcode bcd = new Barcode();
			bcd.model = mqv.model;
			bcd.idbarcode = barcode.getString();
			vetBarcode.addElement(bcd);
			
			setAlertAddBarcode(mqv, getRSNumRecords() - 1);
		} else {
			if (mqv.qty == 0) {
				setAlertAddBarcode(mqv, i);
			}
			else
				callEditForm(mqv, i);
		}
		
		
	}
	
	public void callEditForm(ModelVerifyQty mqv, int mqvIndex) {
		Hashtable ht = new Hashtable();
		ht = Util.joinHashtables(getObjects(), ht);
		ht.put("MVQ", mqv);
		ht.put("MVQIDX", new Integer(mqvIndex));
		FormLoader.loadForm(FormEditModelQtyVerify.class, getDisplay(), this, ht, "Verify Item", null);		
	}
	
	private Barcode searchFirstBarcode(String barcode) {
		Barcode retorno = null;
		
		for(Enumeration en = vetBarcode.elements(); en.hasMoreElements();) {
			Barcode bcd =  (Barcode)en.nextElement();
			
			if (bcd.idbarcode.trim().equals(barcode.trim())) {
				retorno = bcd;
				break;
			}
		}
		
		if (retorno == null) {
			int barcodeType = Config.getInstance().removeBarcodeDigit;
			if ((barcodeType != 0) && (barcode.length() > 2)){
			String barcode2 = Util.fixBarcodeDigits(barcode.trim(), barcodeType);
			
			for(Enumeration en = vetBarcode.elements(); en.hasMoreElements();) {
				Barcode bcd =  (Barcode)en.nextElement();
				
				if (bcd.idbarcode.trim().equals(barcode2.trim())) {
					retorno = bcd;
					break;
				}
			}
				
			}
		}
		
		return retorno;
	}
	
	private int searchFirstModelVerifyQty(String barcode){
		int retorno = -1;
		Barcode bcd = searchFirstBarcode(barcode);
			
		if (bcd != null) {
			int numrecords = getRSNumRecords();
			for (int i = 0; i < numrecords;i++){
				ModelVerifyQty mvq = (ModelVerifyQty)getRSItem(i);
				if (mvq.model.idmodel == bcd.model.idmodel) {
					retorno = i;
					break;
				}					
			}
		}
		
		
		return retorno;
	}
	
	public void refreshComponentArray(){
		refresh();
		
		lista.deleteAll();
		
		int numrecords = getRSNumRecords();
		for (int i = 0; i < numrecords;i++){
			ModelVerifyQty mvq = (ModelVerifyQty)getRSItem(i);
			
			lista.append(mvq.model.model + '\n' + '\n' +
					"Qty Purchase: " + String.valueOf(mvq.qty) + '\n' +
					"Qty Received: " + String.valueOf(mvq.qtyVerified) + '\n' +
					"Difference: " + String.valueOf(mvq.qty - mvq.qtyVerified) + '\n'+ '\n' + '\n',
					null);	
		}
	}	
		
	
	private void showConference(){
		//refreshComponentArray();
		boolean isConferenceOK = getConferenceResult();
		removeAllRSItems();
		refreshComponentArray();
		
		if (isConferenceOK) {			
			Alert alert = new Alert("Alert", "Verify OK.", null, AlertType.INFO);
			alert.setTimeout(Alert.FOREVER);
			Config.getInstance().lastVerifyReceiving = "";
			try {
				Config.getInstance().save();
			} catch (RecordStoreException e) {
				e.printStackTrace();
			}			
			getDisplay().setCurrent(alert, getCaller());
		}			
		else{
			Hashtable ht = new Hashtable();
			ht.put("VETCONF", vetConference);
			//vetConference.removeAllElements();
			vetConference = null;

			FormLoader.loadForm(FormQtyVerifyResult.class, getDisplay(), getCaller(), ht, "Inconsistent Info", null);
		}
	}
	
	private boolean getConferenceResult() {
		boolean retorno = true;
		vetConference = new Vector();
		int numrecords = getRSNumRecords();
		for (int i = 0; i < numrecords;i++){
			ModelVerifyQty mvq = (ModelVerifyQty)getRSItem(i);
			if (mvq.qty != mvq.qtyVerified) {
				retorno = false;
				vetConference.addElement(mvq);
			}
			mvq = null;
		}
		discardRS();
		System.gc();
		return retorno;
	}

	public String getRecosrdStoreName() {
		return rsName;
	}

	public Object StringToItem(String query) {
		return ModelVerifyQtyService.StringToModelVerifyQty(query);
	}

	public String ItemToString(Object obj) {
		return ModelVerifyQtyService.ModelVerifyQtyToString((ModelVerifyQty)obj);
	}
	
}


