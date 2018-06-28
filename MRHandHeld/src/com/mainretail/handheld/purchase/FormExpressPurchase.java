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

public class FormExpressPurchase extends ParentFormPersistent {
	
private final static String SVLPURCHASEINSERT = "/purchaseinsert";

private static final String RS_NAME = "FormExpressPurchase";
	
	private TextField barcode = null;
	private TextField qty = null;
	private Spacer spacerBarcode = null;
	private ChoiceGroup lista = null;
	
	
	private TextField vendorcode;
	private TextField purchasenumber;
	//private TextField purchasetotal;
	//private TextField freight;

	
	private Command deleteButtom = null;
	private Command findBarcodeButtom = null;
	
	private EventInsertPurchase eventInsertPurchase;


	public FormExpressPurchase() {
		super();
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
		
		barcode = new TextFieldObject("Barcode", null, 30, TextField.ANY, null);
		
		qty = new TextField("Qty", null, 10, TextField.DECIMAL);
		
		spacerBarcode = new Spacer(50, 5);
		
		vendorcode = new TextField("Vendor Code", null, 35, TextField.ANY);
		
		//vendorcode = new TextField("Vendor Code", null, 5, TextField.NUMERIC);
		purchasenumber = new TextField("Document Number #", null, 5, TextField.ANY);
		//purchasetotal = new TextField("Purchase Total", null, 5, TextField.DECIMAL);
		//freight = new TextField("Freight", null, 5, TextField.DECIMAL);

				
		findBarcodeButtom = new Command("Add", Command.OK, 2);
		deleteButtom = new Command("Delete", Command.OK, 3);
		
		eventInsertPurchase = new EventInsertPurchase(this);
		
	
		setAnonymousItemStateListener();
	}
	
	public void defaultValues() {
		qty.setString("");
		barcode.setString("");
				
		vendorcode.setString("");
		purchasenumber.setString("");
		//purchasetotal.setString("");
		//freight.setString("0.0");

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
		int numRecords = getRSNumRecords();
		for (int i = 0; i < numRecords; i++) {
			PurchaseItem purchaseItem =(PurchaseItem)getRSItem(i);
			lista.append(purchaseItem.barcode + '\n' + '\n' +
						String.valueOf(purchaseItem.qty) + " x " + String.valueOf(purchaseItem.costprice) + 
						'\n' + '\n' + '\n',
						null);		
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
					showPurchaseFields();
				} else {
					sendPurchase();
				}
				break;
			}
			case 2:{
				if (validatePurchaseItem()) {
					Model model = new Model();
					model.barcode = barcode.getString();
					
					Barcode objbarcode = new Barcode();
					objbarcode.model = model;
					objbarcode.idbarcode = model.barcode;
					
					PurchaseItem purchaseItem = PurchaseItemService.toPurchaseItem(objbarcode);			
					purchaseItem = PurchaseItemService.productToPurchaseItem(model);
					purchaseItem.qty = nullField(qty, 1);
					purchaseItem.barcode = model.barcode;
					
					addRSItem(purchaseItem);
					
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
	
	private void sendPurchase(){
		if (validatePurchase()){
			Purchase purchase = new Purchase();
			
			purchase.vendor = new Pessoa();
			purchase.vendor.usercode = vendorcode.getString();
		

			purchase.documentnumber = purchasenumber.getString();
			//purchase.subtotal = Double.parseDouble(purchasetotal.getString());
			//purchase.freight = Double.parseDouble(freight.getString());
			purchase.idstore = Integer.parseInt(Config.getInstance().store);
			purchase.iduserprereceiving = getUser().iduser;
			
			
			Hashtable htPurchaseItem = PurchaseItemService.vectorToHashtable(getRSVector());
			
			Hashtable ht = PurchaseService.toHashtable(purchase);
			
			ht = Util.joinHashtables(htPurchaseItem, ht);
			
			send(SVLPURCHASEINSERT, ht, eventInsertPurchase);
		}
	}
	
	
	private class EventInsertPurchase implements HttpEventListener{
		
		private FormExpressPurchase owner;
		
		public EventInsertPurchase(FormExpressPurchase owner){
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
						
						Vector vetResponse = PurchaseItemService.queryStringToVector(new String(connectionHC.getResponse()));
						if (vetResponse.isEmpty())
							owner.getDisplay().setCurrent(owner);
						else {
							Hashtable ht = new Hashtable();
							ht = Util.joinHashtables(getObjects(), ht);
							ht.put("VETPUI", vetResponse);
							Object obj = FormLoader.loadForm(FormShowPurchaseItems.class, getDisplay(), owner, ht, "Proccess Error", null);
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
	
	private boolean validatePurchase() {
		String msg = "";
		try{
			if (vendorcode.getString().trim().equals("")){
				msg = "You must fill Vendor Code field.";
			} /*else if (purchasenumber.getString().trim().equals("")){
				msg = "You must fill Purchase Number field.";
			} else if (purchasetotal.getString().trim().equals("")){
				msg = "You must fill Purchase Subtotal field.";
			} else if (freight.getString().trim().equals("")){
				msg = "You must fill Freight field.";
			} */				
		} catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);					
		
		return msg.equals("");
	}

	
	private boolean validatePurchaseItem(){
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
	
	private void showPurchaseFields(){
		deleteAll();
		defaultValues();
		append(vendorcode);
		append(purchasenumber);
		//append(purchasetotal);
		//append(freight);
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
		return PurchaseItemService.StringToPurchaseItem(query);
	}

	public String ItemToString(Object obj) {
		return PurchaseItemService.PurchaseItemToString((PurchaseItem)obj);
	}
	

}
