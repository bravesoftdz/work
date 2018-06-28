package com.mainretail.handheld.purchase;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.io.HttpConnection;
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

import com.mainretail.handheld.Config;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.handheld.Pessoa;
import com.mainretail.handheld.debug.Log;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.ParentForm;
import com.mainretail.util.TextFieldObject;
import com.mainretail.util.Util;

public class FormPurchaseItemList extends ParentForm {
	private final static String SVLPURCHASEINSERT = "/purchaseinsert";
	private static final String SVLSEARCHBARCODE = "/searchbarcode";
	
	private Purchase purchase = null;
	private Model model = null;
	private Vector vetPurchaseItem = null;
	
	private TextFieldObject barcode = null;
	private Spacer spacerBarcode = null;
	
	private Command deleteButtom = null;
	private Command editButtom = null;
	private Command findBarcodeButtom = null;
	
	private Command yesAdditemButtom = null;
	private Command noAdditemButtom = null;
	
	//	 Campos do Purchase
	private TextField purchasenumber;
	private TextField purchasetotal;
	private TextField freight;
	
	private ChoiceGroup lista = null;
	
	private EventInsertPurchase eventInsertPurchase;
	private EventSearchBarcode eventSearchBarcode;
	
	public FormPurchaseItemList() {
		super();
		
		barcode = new TextFieldObject("Barcode", null, 30, TextField.ANY, null);
		spacerBarcode = new Spacer(50, 5);
		editButtom = new Command("Edit", Command.OK, 2);
		deleteButtom = new Command("Delete", Command.OK, 3);
		findBarcodeButtom = new Command("Find", Command.OK, 4);
		
		yesAdditemButtom = new Command("Yes", Command.OK, 1);
		noAdditemButtom = new Command("No", Command.CANCEL, 2);
		
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
		
        // Campos do Purchase
		purchasenumber = new TextField("Document Number #", null, 10, TextField.ANY);
		purchasetotal = new TextField("Purchase Total", null, 10, TextField.DECIMAL);
		freight = new TextField("Freight", null, 10, TextField.DECIMAL);
		
		eventInsertPurchase = new EventInsertPurchase(this);
		eventSearchBarcode = new EventSearchBarcode(this);
		setAnonymousItemStateListener();
	}
	
	public void defaultValues() {		
	}

	public void initForm() {
		super.initForm();		
		refreshComponentArray();
	}
	
	private void selectButtoms(boolean finalization){
		removeCommand(editButtom);		
		removeCommand(deleteButtom);
		removeCommand(findBarcodeButtom);
		removeCommand(getConfirmButtom());

		if (finalization) {
			renameConfirmButtom("Send");			
		} else {
			
			if (!vetPurchaseItem.isEmpty()){
				addCommand(editButtom);
				addCommand(deleteButtom);
				renameConfirmButtom("Save");
			}
			addCommand(findBarcodeButtom);
		}
		renameBackButtom("Back");
	}
	
	public void setObjects(Hashtable objects) {
		super.setObjects(objects);
		purchase = (Purchase)getObjects().get("PURCHASE"); 
		vetPurchaseItem = (Vector)getObjects().get("VETPUI");
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
				if (getConfirmButtom().getLabel().equals("Save")) {
					onExit();
				} else {
					refresh();
				}
				
				break;
			}
			case Command.OK:
			case Command.SCREEN:{
				
				int i = lista.getSelectedIndex();
				PurchaseItem pui = null;
				if (i >= 0) {
					pui = (PurchaseItem)vetPurchaseItem.elementAt(i);				
				}
				
				switch (c.getPriority()){
					case 0:{
						
					}
					case 1:{
						if (getConfirmButtom().getLabel().equals("Save")) {
							showPurchaseFields();
						} else {
							sendPurchase();
						}
						
						break;
					}
					case 2:{
						if (pui != null){
							Hashtable ht = new Hashtable();
							ht = Util.joinHashtables(getObjects(), ht);
							ht.put("PUI", pui);
							FormLoader.loadForm(FormEditPurchaseItem.class, getDisplay(), this, ht, "Edit Purchase Item", null);
						}
						break;
					}
					case 3:{
						if (pui != null){
							vetPurchaseItem.removeElementAt(i);
							refreshComponentArray();
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
	
	private void setAlertAddBarcode() {
		
		Alert alert = new Alert("Alert","Barcode does not exist in this PO. Add?", null, AlertType.CONFIRMATION);
		alert.setTimeout(Alert.FOREVER);
		
		alert.addCommand(yesAdditemButtom);
		alert.addCommand(noAdditemButtom);
		
		getDisplay().setCurrent(alert);
		
		final FormPurchaseItemList owner = this;
		
		CommandListener cmdLstnr = new CommandListener(){			
			public void commandAction(Command c, Displayable d) {
				if (c == yesAdditemButtom) {
					
					model = new Model();
					model.barcode = barcode.getString();
					model.qty = 1;
					
					Hashtable ht = ModelService.toHashtable(model);
					send(SVLSEARCHBARCODE, ht, eventSearchBarcode);
					
				} else if (c == noAdditemButtom) {
					
					barcode.setString("");
					owner.getDisplay().setCurrent(owner);
					
				}
				
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
		PurchaseItem pui = searchFirstBarcode(barcode.getString());
			
		if (pui != null) {
			Hashtable ht = new Hashtable();
			ht = Util.joinHashtables(getObjects(), ht);
			ht.put("PUI", pui);
			FormLoader.loadForm(FormEditPurchaseItem.class, getDisplay(), this, ht, "Edit Purchase Item", null);
		} else {
			setAlertAddBarcode();
		}
	}
	
	private PurchaseItem searchFirstBarcode(String barcode){
		PurchaseItem retorno = null;
		for(Enumeration en = vetPurchaseItem.elements(); en.hasMoreElements();){
			PurchaseItem pui = (PurchaseItem)en.nextElement();
			if (pui.model.barcode != null) {
				if (pui.model.barcode.trim().equals(barcode.trim())){
					retorno = pui;
					break;
				}	
			}
		}
		return retorno;
	}
	
	public void refreshComponentArray(){
		refresh();
		
		lista.deleteAll();
		
		for (Enumeration en = vetPurchaseItem.elements(); en.hasMoreElements();){
			PurchaseItem purchaseItem =(PurchaseItem)en.nextElement();
			lista.append(purchaseItem.model.description + '\n' + '\n' +
						"Qty: " + String.valueOf(purchaseItem.qty) + '\n' +
						"Cost Price: " + String.valueOf(purchaseItem.newcostprice) + '\n' +
						"Sale Price: " + String.valueOf(purchaseItem.newsaleprice) + '\n' +
						"Sugg Retail: " + String.valueOf(purchaseItem.newsuggretail) + '\n'+ '\n' + '\n',
						null);
		
		}
	}
	
	private class EventInsertPurchase implements HttpEventListener{
		
		private FormPurchaseItemList owner;
		
		public EventInsertPurchase(FormPurchaseItemList owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{
						vetPurchaseItem.removeAllElements();
						getDisplay().setCurrent(getCaller());
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

	private void sendPurchase(){
		if (validatePurchase()){
		
			Pessoa vendor = new Pessoa();
			vendor.usercode = purchase.vendor.usercode;
			
			purchase = new Purchase();
			
			purchase.idstore = Integer.parseInt(Config.getInstance().store);
			purchase.iduserprereceiving = getUser().iduser;
		
			purchase.vendor = vendor;
			purchase.documentnumber = purchasenumber.getString();
			purchase.subtotal = Double.parseDouble(purchasetotal.getString());
			purchase.freight = Double.parseDouble(freight.getString());
			
			Hashtable htPurchaseItem = PurchaseItemService.vectorToHashtable(vetPurchaseItem);
			
			Hashtable ht = PurchaseService.toHashtable(purchase);
			
			ht = Util.joinHashtables(htPurchaseItem, ht);
			
			send(SVLPURCHASEINSERT, ht, eventInsertPurchase);
		}
	}
	
	private boolean validatePurchase() {
		String msg = "";
		try{
			if (purchasenumber.getString().trim().equals("")){
				msg = "You must fill Purchase Number field.";
			} else if (purchasetotal.getString().trim().equals("")){
				msg = "You must fill Purchase Subtotal field.";
			} 
		} catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);					
		
		return msg.equals("");
	}
	
	private void showPurchaseFields(){
		deleteAll();
		
		append(purchasenumber);
		append(purchasetotal);
		append(freight);
		purchasetotal.setString(String.valueOf(calcPurchaseSubTotal()));		
		selectButtoms(true);
	} 
	
	private double calcPurchaseSubTotal() {
		long result = 0;
		try{
			for (Enumeration en = vetPurchaseItem.elements(); en.hasMoreElements();){
				PurchaseItem pui = (PurchaseItem)en.nextElement();
				result += (pui.newcostprice * pui.qty);
			}
		}catch(Throwable t){
			Log.getInstance().log(t.getMessage());
		}
				
		return (double)result;
	}
	
	private class EventSearchBarcode implements HttpEventListener{
		
		private FormPurchaseItemList owner;
		
		public EventSearchBarcode(FormPurchaseItemList owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED)
				{					
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{														
						String resposta = new String(connectionHC.getResponse());
						
						model = ModelService.toModel(Util.queryToHashtable(resposta));
						model.barcode = barcode.getString();
						
						PurchaseItem pui = PurchaseItemService.productToPurchaseItem(model);
						
						pui.qty = 1;
						pui.newcostprice = model.vendorcost; 
						pui.newsaleprice = model.sellingprice;
						pui.newsuggretail =	model.suggretail;	
						
						vetPurchaseItem.addElement(pui);
						
						Hashtable ht = new Hashtable();
						ht = Util.joinHashtables(getObjects(), ht);
						ht.put("PUI", pui);
						FormLoader.loadForm(FormEditPurchaseItem.class, getDisplay(), owner, ht, "Edit Purchase Item", null);
																	
									
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
					barcode.setString("");	
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
	
}
