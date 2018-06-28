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

import com.mainretail.handheld.BarcodeVerifyQty;
import com.mainretail.handheld.BarcodeVerifyQtyService;
import com.mainretail.handheld.Config;
import com.mainretail.handheld.ModelVerifyQtyService;
import com.mainretail.handheld.ParentFormPersistent;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.TextFieldObject;
import com.mainretail.util.Util;

public class FormVerifyReceiving extends ParentFormPersistent {
	
	RecordStore dados = null;

	private final static String SVLVALIDATRECEIVING = "/newvalidatereceiving";
	
	private TextField barcode = null;
	private TextField qty = null;
	private Spacer spacerBarcode = null;
	private ChoiceGroup lista = null;
			
	private Command deleteButtom = null;
	private Command findBarcodeButtom = null;
	
	private ValidateReceiving eventValidateReceiving;

	public FormVerifyReceiving() {
		super();
		
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
		
		barcode = new TextFieldObject("Barcode", null, 30, TextField.ANY, null);
		
		qty = new TextField("Qty", null, 10, TextField.DECIMAL);
		
		spacerBarcode = new Spacer(50, 5);
		
		findBarcodeButtom = new Command("Add", Command.OK, 2);
		deleteButtom = new Command("Delete", Command.OK, 3);
		
		renameConfirmButtom("Send");
		
		eventValidateReceiving = new ValidateReceiving(this);
		
		setAnonymousItemStateListener();
	}
	
	public void defaultValues() {
		barcode.setString("");
		qty.setString("");
	}
	
	public void refresh() {
		deleteAll();
		append(barcode);
		append(qty);	
		append(spacerBarcode);
		append(lista);
		defaultValues();
		selectButtoms();
	}
	
	public void initForm() {
		
		super.initForm();
		addCommand(findBarcodeButtom);	
		
		loadRecordStore();
		refreshComponentArray();
		
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
			BarcodeVerifyQty barcodeVerifyQty =(BarcodeVerifyQty)getRSItem(i);
			lista.append(barcodeVerifyQty.barcode + '\n' +
						String.valueOf(barcodeVerifyQty.qty) + '\n',
						null);
			barcodeVerifyQty = null;
			System.gc();
		}
		selectButtoms();
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
				if (getConfirmButtom().getLabel().equals("Send")) {
					sendValidateReceiving();
				}
				break;
			}
			case 2:{
				if (validatePOItem()) {
					
					BarcodeVerifyQty barcodeverifyqty = new BarcodeVerifyQty();
					barcodeverifyqty.barcode = barcode.getString();
					barcodeverifyqty.qty = nullField(qty, 1);
										
					addRSItem(barcodeverifyqty);
										
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
	
	
	private void sendValidateReceiving(){
				
		Hashtable htBarcodeItens = BarcodeVerifyQtyService.vectorToHashtable(getRSVector());
								
		Purchase purchase = (Purchase)getObjects().get("PURCHASE");	
			
		Hashtable ht = new Hashtable();
		ht = PurchaseService.toHashtable(purchase);
					
		ht = Util.joinHashtables(htBarcodeItens, ht);
			
		send(SVLVALIDATRECEIVING, ht, eventValidateReceiving);
		
	}
	
	
	private class ValidateReceiving implements HttpEventListener{
		
		private FormVerifyReceiving owner;
		
		public ValidateReceiving(FormVerifyReceiving owner){
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
						//owner.refreshComponentArray();
						
						Vector vetResponse = ModelVerifyQtyService.queryStringToVector(new String(connectionHC.getResponse()));
						if (vetResponse.isEmpty())
							owner.getDisplay().setCurrent(owner);
						else {
							Hashtable ht = new Hashtable();
							ht = Util.joinHashtables(getObjects(), ht);
							ht.put("VETCONF", vetResponse);						
							Object obj = FormLoader.loadForm(FormVerifyReceivingResult.class, getDisplay(), owner, ht, "Proccess Error", null);
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
	
	
	private boolean validatePOItem(){
		String msg = "";
		
		try{
			if (barcode.getString().trim().equals("")) {
				msg = "Barcode is empty.";
			} 
						
		}
		catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);	
		
		return msg.equals("");
		
	}
	
	private void renameConfirmButtom(String newName){
		if (getConfirmButtom() != null){
			removeCommand(getConfirmButtom());
			setConfirmButtom(null);
		}
		setConfirmButtom(new Command(newName, Command.OK, 1));
		addCommand(getConfirmButtom());
	}
	
	private void selectButtoms(){
		removeCommand(deleteButtom);
		renameConfirmButtom("Save");
		removeCommand(getConfirmButtom());
		
		if (!getRSIsEmpty()){
			addCommand(deleteButtom);
			renameConfirmButtom("Send");
		} else {
			renameConfirmButtom("Save");
		}
		
	}

	public Object StringToItem(String query) {
		return BarcodeVerifyQtyService.StringToBarcodeVerifyQty(query);
	}

	public String ItemToString(Object obj) {
		return BarcodeVerifyQtyService.BarcodeVerifyQtyToString((BarcodeVerifyQty)obj);
	}

	public String getRecosrdStoreName() {
		return "FormImportPurchaseItemList";
	}	

}
