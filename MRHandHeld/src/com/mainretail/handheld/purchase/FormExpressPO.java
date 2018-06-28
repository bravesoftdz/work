package com.mainretail.handheld.purchase;

import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.ItemStateListener;
import javax.microedition.lcdui.Spacer;
import javax.microedition.lcdui.TextField;
import javax.microedition.rms.RecordStore;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.Config;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ParentFormPersistent;
import com.mainretail.handheld.Pessoa;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.TextFieldObject;
import com.mainretail.util.Util;

public class FormExpressPO extends ParentFormPersistent {
	
	RecordStore dados = null;

	private final static String SVLPOINSERT = "/poinsert";
	private final static String RS_NAME = "FormExpressPO";
	
	private TextField barcode = null;
	private TextField qty = null;
	private Spacer spacerBarcode = null;
	private ChoiceGroup lista = null;
	
	
	private TextField vendorcode;
	//private TextField pototal;
	//private TextField paydays;
	//private TextField obs;

	
	private Command deleteButtom = null;
	private Command findBarcodeButtom = null;
	
	private EventInsertPO eventInsertPO;

	public FormExpressPO() {
		super();
		
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
		
		barcode = new TextFieldObject("Barcode", null, 30, TextField.ANY, null);
		
		qty = new TextField("Qty", null, 10, TextField.DECIMAL);
		
		spacerBarcode = new Spacer(50, 5);
		
		vendorcode = new TextField("Vendor Code", null, 35, TextField.ANY);	
		//paydays = new TextField("Pay in", null, 5, TextField.NUMERIC);
		//pototal = new TextField("Purchase Total", null, 10, TextField.DECIMAL);
		//obs = new TextField("Note", null, 255, TextField.ANY);				
		
		
				
		findBarcodeButtom = new Command("Add", Command.OK, 2);
		deleteButtom = new Command("Delete", Command.OK, 3);
		
		eventInsertPO = new EventInsertPO(this);
		

		
		setAnonymousItemStateListener();
	}
	
	public void defaultValues() {
		qty.setString("");
		barcode.setString("");
				
		vendorcode.setString("");
		//pototal.setString("");
		//paydays.setString("");
		//obs.setString("");

	}
	
	public void refresh() {
		deleteAll();
		append(qty);
		append(barcode);
			
		append(spacerBarcode);
		append(lista);
		defaultValues();
		selectButtoms(false);
	}
	
	public void initForm() {
		
		super.initForm();
		addCommand(findBarcodeButtom);	
		
		loadRecordStore();
		refreshComponentArray();
		//refresh();		
	}


	public void onSelect(Displayable d) {
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
		getDisplay().setCurrentItem(qty);
	}
	
	public void refreshComponentArray(){
		refresh();
		lista.deleteAll();
		int numrecords = getRSNumRecords();
		for (int i = 0; i < numrecords;i++){
			POItem POItem =(POItem)getRSItem(i);
			lista.append(POItem.barcode + '\n' + '\n' +
						String.valueOf(POItem.qty) + " x " + String.valueOf(POItem.costprice) + 
						'\n' + '\n' + '\n',
						null);
			POItem = null;
			System.gc();
		}
		selectButtoms(false);
		getDisplay().setCurrentItem(barcode);		
	}

	public void commandAction(Command c, Displayable d) {
		switch (c.getCommandType()) {
		case Command.BACK:{
			if (getConfirmButtom().getLabel().equals("Save")) {
				onExit();
			} else {
				refreshComponentArray();
			}
			break;
		}
		case Command.OK:
		case Command.SCREEN:{
			int i = lista.getSelectedIndex();			
			switch (c.getPriority()) {
			case 1:{				
				if (getConfirmButtom().getLabel().equals("Save")) {
					showPOFields();
				} else {
					sendPO();
				}
				break;
			}
			case 2:{
				if (validatePOItem()) {
					Model model = new Model();
					model.barcode = barcode.getString();
					
					Barcode objbarcode = new Barcode();
					objbarcode.model = model;
					objbarcode.idbarcode = model.barcode;
					
					POItem poItem = POItemService.toPOItem(objbarcode);
					
					poItem.userid = getUser().iduser;
					poItem.storeid = Integer.parseInt(Config.getInstance().store);
					
					poItem.qty = nullField(qty, 1);
					
					addRSItem(poItem);
										
					refreshComponentArray();
				}

				break;
			}
			case 3:{
				if (i >= 0) {
					removeRSItem(i);
					refreshComponentArray();
				}

				break;
			}
			}
			 
			break;
		}
		
		}

	}
	
	
	private void sendPO(){
		if (validatePO()){
			PO po = new PO();
			
			po.vendor = new Pessoa();
			po.vendor.usercode = vendorcode.getString();
		
			//po.obs = obs.getString();
			po.idstore = Integer.parseInt(Config.getInstance().store);
			//po.paydays = Integer.parseInt(paydays.getString());
		
			Hashtable htPOItem = POItemService.vectorToHashtable(getRSVector());
			
			Hashtable ht = POService.toHashtable(po);
			
			ht = Util.joinHashtables(htPOItem, ht);
			
			send(SVLPOINSERT, ht, eventInsertPO);
		}
	}
	
	
	private class EventInsertPO implements HttpEventListener{
		
		private FormExpressPO owner;
		
		public EventInsertPO(FormExpressPO owner){
			this.owner = owner;
		}

		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{
						removeAllRSItems();
						owner.refreshComponentArray();
						
						Vector vetResponse = POItemService.queryStringToVector(new String(connectionHC.getResponse()));
						if (vetResponse.isEmpty())
							owner.getDisplay().setCurrent(owner);
						else {
							Hashtable ht = new Hashtable();
							ht = Util.joinHashtables(getObjects(), ht);
							ht.put("VETPOI", vetResponse);						
							Object obj = FormLoader.loadForm(FormShowPOItems.class, getDisplay(), owner, ht, "Proccess Error", null);
							getDisplay().setCurrent((Displayable)obj);
						}
																		
					} else {
						
						String msg = connectionHC.getResponseMessage() ;
						if (msg == null)
						{
							msg = "";
						}
						
						ErrorAlert.getInstance().showError(getDisplay(), owner,
								String.valueOf(responseCode)+ " " + msg);					
					}
				}
				else if (status==HttpEventListener.STATUS_ERROR)
				{
					ErrorAlert.getInstance().showError(getDisplay(), owner, erro);
				}
				else if (status==HttpEventListener.STATUS_CANCELLED)
				{				
					getDisplay().setCurrent(owner);			
				}
				
			} catch (Throwable e) {
				
				ErrorAlert.getInstance().showError(getDisplay(), owner, e);			
			}						
		}

	
	}
	
	
	private boolean validatePO() {
		String msg = "";
		try{
			if (vendorcode.getString().trim().equals("")){
				msg = "You must fill Vendor Code field.";			
			} /*else if (pototal.getString().trim().equals("") || (Double.parseDouble(pototal.getString()) == 0) ){
				msg = "You must fill PO Total field.";
			} else if (paydays.getString().trim().equals("") || (Double.parseDouble(paydays.getString()) == 0) ) {
				msg = "Pay in must be greater ZERO.";
			}*/
			 
		} catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);					
		
		return msg.equals("");
	}

	
	private boolean validatePOItem(){
		String msg = "";
		
		try{
			if (barcode.getString().trim().equals("")) {
				msg = "Barcode is empty.";
			} 
			//else if (!qty.getString().trim().equals("") && (Double.parseDouble(qty.getString()) == 0)) {
			//	msg = "Quantity must be greater ZERO.";
			//}			
		}
		catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);	
		
		return msg.equals("");
		
	}
	
	private void showPOFields(){
		deleteAll();
		defaultValues();
		append(vendorcode);
		//append(pototal);
		//append(paydays);
		//append(obs);
		selectButtoms(true);
		getDisplay().setCurrentItem(vendorcode);
	}
	
	private void renameConfirmButtom(String newName){
		if (getConfirmButtom() != null){
			removeCommand(getConfirmButtom());
			setConfirmButtom(null);
		}
		setConfirmButtom(new Command(newName, Command.OK, 1));
		addCommand(getConfirmButtom());
	}
	
	private void selectButtoms(boolean finalization){
		removeCommand(deleteButtom);
		removeCommand(findBarcodeButtom);
		renameConfirmButtom("Save");
		removeCommand(getConfirmButtom());
		

		if (finalization) {
			renameConfirmButtom("Send");			
		} else {
			
			if (!getRSIsEmpty()){
				addCommand(deleteButtom);
				renameConfirmButtom("Save");
			}
			addCommand(findBarcodeButtom);
		}
	}

	public String getRecosrdStoreName() {
		return RS_NAME;
	}

	public Object StringToItem(String query) {
		return POItemService.StringToPOItem(query);
	}

	public String ItemToString(Object obj) {
		return POItemService.POItemToString((POItem)obj);
	}
	


}