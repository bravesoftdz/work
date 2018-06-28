package com.mainretail.handheld.purchase;

import java.util.Hashtable;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.ItemStateListener;
import javax.microedition.lcdui.Spacer;
import javax.microedition.lcdui.StringItem;
import javax.microedition.lcdui.TextField;

import com.mainretail.handheld.Config;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.handheld.ParentFormPersistent;
import com.mainretail.handheld.Pessoa;
import com.mainretail.handheld.debug.Log;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.Util;



public class FormReceiving extends ParentFormPersistent {
	private static final String SVLSEARCHBARCODE = "/searchbarcode";
	private static final String SVLPURCHASEINSERT = "/purchaseinsert";
	
	private Model model = null;
	private PurchaseItem purchaseItem = null;
	private Purchase purchase = null;
	
	private Command purchaseButtom = null;
	
	// Campos do PurchaseItem
	private TextField barcode;
	
	private TextField qty;
	private Spacer pricesseparator;
	private TextField newcostprice;
	private TextField newsaleprice;
	private TextField newsuggretail;
	private StringItem description;
	
	// Campos do Purchase
	private TextField vendorcode;
	private TextField purchasenumber;
	//private DateField purchasedate;
	//private DateField purchaseduedate;
	private TextField purchasetotal;
	private TextField freight;
	
	private EventInsertPurchase eventInsertPurchase;
	private EventSearchBarcode eventSearchBarcode;
	
	public FormReceiving() {
		super();
					
		qty = new TextField("Quantity", null, 10, TextField.DECIMAL);
		barcode = new TextField("Barcode", null, 15, TextField.ANY);
		description = new StringItem("", "");
		
		newcostprice = new TextField("Cost Price", null, 10, TextField.DECIMAL);
		newsaleprice = new TextField("Sale Price", null, 10, TextField.DECIMAL);
		newsuggretail = new TextField("Suggest Retail", null, 10, TextField.DECIMAL);
		
		vendorcode = new TextField("Vendor Code", null, 35, TextField.ANY);
		purchasenumber = new TextField("Document Number #", null, 10, TextField.ANY);
		//purchasedate = new DateField("Date", DateField.DATE_TIME, TimeZone.getTimeZone("GMT"));
		//purchaseduedate = new DateField("Due Date", DateField.DATE_TIME, TimeZone.getTimeZone("GMT"));
		purchasetotal = new TextField("Purchase Total", null, 10, TextField.DECIMAL);
		freight = new TextField("Freight", null, 5, TextField.DECIMAL);
		
		pricesseparator = new Spacer(5, 10);
		
		eventInsertPurchase = new EventInsertPurchase(this);
		eventSearchBarcode = new EventSearchBarcode(this);
		setAnonymousItemStateListener();
			
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
	
	public synchronized void refresh(){
		deleteAll();
		append(barcode);
		refreshBarcodeComponent(true);
		defaultValues();
		renameConfirmButtom("Search");
		renamepurchaseButtom("Save");
	}
	
	public synchronized void defaultValues(){
		qty.setString("");
		
		newcostprice.setString("");
		newsaleprice.setString("");
		newsuggretail.setString("");
		
		barcode.setString("");
		description.setText("");
		
		vendorcode.setString("");
		purchasenumber.setString("");
		purchasetotal.setString("");
		freight.setString("0.0");

		getDisplay().setCurrentItem(barcode);		
	}
	
	public void onSelect(Displayable d) {
		if (description.getText().trim().equals(""))
		{
			searchBarcode();
		}
		else
		{
			pushBarcode();
		}
	}
	
	public void initForm(){
		super.initForm();		
		renamepurchaseButtom("Save");
		loadRecordStore();
		refresh();
	}
	
	private void renameConfirmButtom(String newName){
		if (getConfirmButtom() != null){
			removeCommand(getConfirmButtom());
			setConfirmButtom(null);
		}
		setConfirmButtom(new Command(newName, Command.OK, 1));
		addCommand(getConfirmButtom());
	}
	
	private void renamepurchaseButtom(String newName){
		if (purchaseButtom != null){
			removeCommand(purchaseButtom);
			purchaseButtom = null;
		}
		purchaseButtom = new Command(newName, Command.OK, 2);
		addCommand(purchaseButtom);
	}
	
	public void processCommand(Command c, Displayable d) {
		switch (c.getCommandType()) {
			case Command.BACK:{
				if (purchaseButtom.getLabel().equals("Save"))
					if ((getItemIsShowing((Item)vendorcode) > -1))
						refresh();
					else
						if ((getItemIsShowing((Item)description) > -1))
							refresh();
						else
							onExit();
				else
					refresh();
				break;
			}
			case Command.OK:
			case Command.SCREEN:{
				switch (c.getPriority()){
					case 1:{
						onSelect(d);
						break;
					}
					case 2:{
						if (purchaseButtom.getLabel().equals("Save"))
							finalizePurchase();
						else
							sendPurchase();
						break;
					}
				}
				 
				break;
			}
		}
	}
	
	private void finalizePurchase(){
		if (description.getText() != ""){
			if (!pushBarcode()){
				return;
			}
		}
		
		if (getRSIsEmpty()){
			ErrorAlert.getInstance().showError(getDisplay(), this, "Cannot create an empty purchase");
			return;
		}
		
		showPurchaseFields();
	}
	
	private void sendPurchase(){
		if (validatePurchase()){
			
			purchase = new Purchase();
			
			Pessoa vendor = new Pessoa();
			vendor.usercode = vendorcode.getString();
			
			purchase.idstore = Integer.parseInt(Config.getInstance().store);
			purchase.iduserprereceiving = getUser().iduser;
		
			purchase.vendor = vendor;
			purchase.documentnumber = purchasenumber.getString();
			purchase.subtotal = Double.parseDouble(purchasetotal.getString());
			purchase.freight = Double.parseDouble(freight.getString());
			
			Hashtable htPurchaseItem = PurchaseItemService.vectorToHashtable(getRSVector());
			
			Hashtable ht = PurchaseService.toHashtable(purchase);
			
			ht = Util.joinHashtables(htPurchaseItem, ht);
			
			send(SVLPURCHASEINSERT, ht, eventInsertPurchase);
			//refresh();
		}
	}

	private boolean validatePurchase() {
		String msg = "";
		try{
			if (vendorcode.getString().trim().equals("")){
				msg = "You must fill Vendor Code field.";
			} else if (purchasenumber.getString().trim().equals("")){
				msg = "You must fill Purchase Number field.";
			} else if (purchasetotal.getString().trim().equals("")){
				msg = "You must fill Purchase Subtotal field.";
			} /*else if (freight.getString().trim().equals("")){
				msg = "You must fill Freight field.";
			}*/ 
		} catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);					
		
		return msg.equals("");
	}

	private synchronized void refreshBarcodeComponent(boolean enabled){		
		String barCodeText = null;
		
		try {
			Thread.sleep(50);
		} catch (InterruptedException e) {		
		}		
				
		
		setItemStateListener(null);		
		try
		{
			if (this.size() > 0)
				delete(0);
			
			int constraint = TextField.ANY;
		
			if (barcode != null){
				barCodeText = barcode.getString();
				barcode = null;
			}
			
			if (!enabled)
				constraint = constraint | TextField.UNEDITABLE;
			
			barcode = new TextField("Barcode", barCodeText, 15, constraint);			
			insert(0, barcode);					
		}
		finally{
			setAnonymousItemStateListener();
		}
		
	}
	
	
	private synchronized void searchBarcode(){
		PurchaseItem lastPurchaseItem = null;
		if (((lastPurchaseItem = searchFirstBarcode(barcode.getString())) != null)){
			model = lastPurchaseItem.model;
			append(description);
			description.setText(model.description);
			
			newcostprice.setString(String.valueOf(lastPurchaseItem.newcostprice));
			newsaleprice.setString(String.valueOf(lastPurchaseItem.newsaleprice));
			newsuggretail.setString(String.valueOf(lastPurchaseItem.newsuggretail));
			
			append(pricesseparator);
			append(qty);
			
			getDisplay().setCurrentItem(qty);
			
			showPriceBox();
			
			refreshBarcodeComponent(false);
			renameConfirmButtom("Add");
		}
		else
		{
			model = new Model();
			model.barcode = barcode.getString();
			model.qty = nullField(qty, 1);
			
			Hashtable ht = ModelService.toHashtable(model);
			send(SVLSEARCHBARCODE, ht, eventSearchBarcode);
		}		
	}
	
	private PurchaseItem searchFirstBarcode(String barcode){
		PurchaseItem retorno = null;
		int numRecords = getRSNumRecords();
		for(int i = 0; i < numRecords; i++){
			PurchaseItem pui = (PurchaseItem)getRSItem(i);
			if (pui.model.barcode.equals(barcode.trim())){
				retorno = pui;
				break;
			}
		}
		return retorno;
	}
	
	private void showPriceBox() {		
		append(newcostprice);
		append(newsaleprice);
		append(newsuggretail);
	}

	public void setObjects(Hashtable objects) {		
		super.setObjects(objects);
		//this.invcount = (InvCount)getObjects().get("INVCOUNT");
	}	
	
	public void endBarcodeScan(){
		onSelect(this);
	}
	
	private boolean pushBarcode(){
		if (validateItem()){
			purchaseItem = PurchaseItemService.productToPurchaseItem(model);
			purchaseItem.qty = nullField(qty, 1);
			purchaseItem.newcostprice = Double.parseDouble(newcostprice.getString());
			purchaseItem.newsaleprice = Double.parseDouble(newsaleprice.getString());
			purchaseItem.newsuggretail = Double.parseDouble(newsuggretail.getString());
			purchaseItem.barcode = model.barcode;
			addRSItem(purchaseItem);
			refresh();
			return true;
		}
		else
			return false;
	}
	
	private boolean validateItem(){
		String msg = "";
		
		try{
			//if (!qty.getString().trim().equals("") && (Double.parseDouble(qty.getString()) == 0)) {
			//	msg = "Quantity must be greater ZERO.";
			//}			
			if (newcostprice.getString().trim().equals("") || (Double.parseDouble(newcostprice.getString()) == 0) ) {
				msg = "Cost Price must be greater ZERO.";
			}
			else if (newsaleprice.getString().trim().equals("") || (Double.parseDouble(newsaleprice.getString()) == 0) ) {
				msg = "Sale Price must be greater ZERO.";
			}
			else if (newsuggretail.getString().trim().equals("")) {
				msg = "Sugg Price is empty.";
			}
		}
		catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);	
		
		return msg.equals("");
	}
	
	private class EventInsertPurchase implements HttpEventListener{
		
		private FormReceiving owner;
		
		public EventInsertPurchase(FormReceiving owner){
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
	
	private void showPurchaseFields(){
		deleteAll();
		
		append(vendorcode);
		append(purchasenumber);
		append(purchasetotal);
		purchasetotal.setString(String.valueOf(calcPurchaseSubTotal())); 
		append(freight);
		renamepurchaseButtom("Send");
		removeCommand(getConfirmButtom());
	} 
	
	private double calcPurchaseSubTotal() {
		double result = 0;
		try{
			int numRecords = getRSNumRecords();
			for(int i = 0; i < numRecords; i++){
				PurchaseItem pui = (PurchaseItem)getRSItem(i);
				result += (pui.newcostprice * pui.qty);
			}
		}catch(Throwable t){
			Log.getInstance().log(t.getMessage());
		}
		return Util.double4Digits(result);
	}

	private class EventSearchBarcode implements HttpEventListener{
		
		private FormReceiving owner;
		
		public EventSearchBarcode(FormReceiving owner){
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
						model.barcode = new String(barcode.getString());
						
						append(description);
						append(pricesseparator);
						append(qty);
						
						description.setText(model.description);
						getDisplay().setCurrent(owner);
						getDisplay().setCurrentItem(qty);
						
						showPriceBox();
						
						newcostprice.setString(String.valueOf(model.vendorcost));
						newsaleprice.setString(String.valueOf(model.sellingprice));
						newsuggretail.setString(String.valueOf(model.suggretail));
						
						refreshBarcodeComponent(false);
						renameConfirmButtom("Add");
						
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
					description.setText("");
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

	public String getRecosrdStoreName() {
		return "FormReceiving";
	}

	public Object StringToItem(String query) {
		return PurchaseItemService.StringToPurchaseItem(query);
	}

	public String ItemToString(Object obj) {
		return PurchaseItemService.PurchaseItemToString((PurchaseItem)obj);
	}
	
}
