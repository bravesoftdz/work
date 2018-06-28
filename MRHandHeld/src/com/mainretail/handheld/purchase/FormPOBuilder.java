package com.mainretail.handheld.purchase;

import java.util.Date;
import java.util.Hashtable;
import java.util.TimeZone;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.DateField;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.ItemStateListener;
import javax.microedition.lcdui.Spacer;
import javax.microedition.lcdui.TextField;

import com.mainretail.handheld.Config;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.handheld.ParentFormPersistent;
import com.mainretail.handheld.Pessoa;
import com.mainretail.handheld.debug.Log;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.TextFieldObject;
import com.mainretail.util.Util;

public class FormPOBuilder extends ParentFormPersistent{

	private final static String SVLPOINSERT = "/poinsert";
	private static final String SVLSEARCHBARCODE = "/searchbarcodepo";
	
	private PO po = null;
	
	private TextField barcode = null;
	private Spacer spacerBarcode = null;
	
	private Command deleteButtom = null;
	private Command editButtom = null;
	private Command findBarcodeButtom = null;
	
	
	//	 Campos do PO
	private TextField vendorcode;
	private DateField estimatedarrive;
	private TextField pototal;
	private TextField paydays;
	private TextField obs;
	
	private ChoiceGroup lista = null;
	
	private EventInsertPO eventInsertPO;
	private EventSearchBarcode eventSearchBarcode;
	
	public FormPOBuilder() {
		super();
		
		po = new PO(); 
		
		barcode = new TextFieldObject("Barcode", null, 30, TextField.ANY, null);
		spacerBarcode = new Spacer(50, 5);
		
		
		vendorcode = new TextField("Vendor Code", null, 35, TextField.ANY);
		estimatedarrive = new DateField("Date", DateField.DATE_TIME, TimeZone.getTimeZone("GMT"));		
		paydays = new TextField("Pay in", null, 5, TextField.NUMERIC);
		pototal = new TextField("Purchase Total", null, 10, TextField.DECIMAL);
		obs = new TextField("Note", null, 255, TextField.ANY);				
		
		editButtom = new Command("Edit", Command.OK, 2);
		deleteButtom = new Command("Delete", Command.OK, 3);
		findBarcodeButtom = new Command("Find", Command.OK, 4);
		
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
		
		
		eventInsertPO = new EventInsertPO(this);
		eventSearchBarcode = new EventSearchBarcode(this);
		setAnonymousItemStateListener();
	}
	
	public void defaultValues() {
		barcode.setString("");
		vendorcode.setString("");
		estimatedarrive.setDate(new Date());		
		paydays.setString("7");
		pototal.setString(String.valueOf(calcPOSubTotal()));
		obs.setString("");				
	}

	public void initForm() {
		super.initForm();		
		loadRecordStore();
		refreshComponentArray();
	}
	
	private void selectButtoms(boolean finalization){
		removeCommand(editButtom);		
		removeCommand(deleteButtom);
		removeCommand(findBarcodeButtom);
		renameConfirmButtom("Save");
		removeCommand(getConfirmButtom());
		
		

		if (finalization) {
			renameConfirmButtom("Send");			
		} else {
			
			if (!getRSIsEmpty()){
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
					refreshComponentArray();
				}
				
				break;
			}
			case Command.OK:
			case Command.SCREEN:{
				
				int i = lista.getSelectedIndex();
				POItem poi = null;
				if (i >= 0) {
					poi = (POItem)getRSItem(i);				
				}
				
				switch (c.getPriority()){
					case 0:{
						
					}
					case 1:{
						if (getConfirmButtom().getLabel().equals("Save")) {
							showPOFields();
						} else {
							sendPO();
						}
						
						break;
					}
					case 2:{
						if (poi != null){
							Hashtable ht = new Hashtable();
							ht = Util.joinHashtables(getObjects(), ht);
							ht.put("POI", poi);
							ht.put("ISINSERT", new Boolean(false));							
							FormLoader.loadForm(FormEditPOItem.class, getDisplay(), this, ht, "Edit PO Item", null);
							ht = null;
							System.gc();
						}
						break;
					}
					case 3:{
						if (poi != null){
							removeRSItem(i);
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
		POItem poi = searchFirstBarcode(barcode.getString());
			
		if (poi != null) {
			
			Hashtable ht = new Hashtable();
			ht = Util.joinHashtables(getObjects(), ht);
			ht.put("POI", poi.clone());
			ht.put("ISINSERT", new Boolean(true));			
			FormLoader.loadForm(FormEditPOItem.class, getDisplay(), this, ht, "Insert PO Item", null);
			
		} else {
			Model model = new Model();
			model.barcode = barcode.getString();
			model.qty = 1;
			
			Hashtable ht = ModelService.toHashtable(model);
			send(SVLSEARCHBARCODE, ht, eventSearchBarcode);
		}
	}
	
	private POItem searchFirstBarcode(String barcode){
		POItem retorno = null;
		int numRecords = getRSNumRecords();
		for(int i = 0; i< numRecords; i++){
			POItem poi = (POItem)getRSItem(i);
			if (poi.model.barcode != null) {
				if (poi.model.barcode.equals(barcode.trim())){
					retorno = poi;
					break;
				}	
			}
		}
		return retorno;
	}
	
	public void refreshComponentArray(){
		refresh();
		lista.deleteAll();
		
		int numRecords = getRSNumRecords();
		for(int i = 0; i< numRecords; i++){
			POItem poi = (POItem)getRSItem(i);
			lista.append(poi.model.description + '\n' + '\n' +
						String.valueOf(poi.qty) + " x " + String.valueOf(poi.costprice) + 
						'\n' + '\n' + '\n',
						null);
			poi = null;
		}
		selectButtoms(false);
		getDisplay().setCurrentItem(barcode);		
	}
	
	private class EventInsertPO implements HttpEventListener{
		
		private FormPOBuilder owner;
		
		public EventInsertPO(FormPOBuilder owner){
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
						/*
						po = InvoiceService.toInvoice(Util.queryToHashtable(new String(connectionHC.getResponse())));
						vetPOItem.removeAllElements();
						Alert alert = new Alert("Sale sent", "Your sale code number is " + po.salecode, null, AlertType.INFO);
						alert.setTimeout(Alert.FOREVER);
						owner.refreshComponentArray();
						owner.getDisplay().setCurrent(alert, owner);
						*/
																		
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

	private void sendPO(){
		if (validatePO()){
			po = new PO();
			
			po.vendor = new Pessoa();
			po.vendor.usercode = vendorcode.getString();
			
			po.estarrival = estimatedarrive.getDate();
			po.obs = obs.getString();
			po.idstore = Integer.parseInt(Config.getInstance().store);
			po.paydays = Integer.parseInt(paydays.getString());
		
			Hashtable htPOItem = POItemService.vectorToHashtable(getRSVector());
			
			Hashtable ht = POService.toHashtable(po);
			
			ht = Util.joinHashtables(htPOItem, ht);
			
			send(SVLPOINSERT, ht, eventInsertPO);
		}
	}
	
	private boolean validatePO() {
		String msg = "";
		try{
			if (vendorcode.getString().trim().equals("")){
				msg = "You must fill Vendor Code field.";			
			} else if (pototal.getString().trim().equals("") || (Double.parseDouble(pototal.getString()) == 0) ){
				msg = "You must fill PO Total field.";
			//} else if (paydays.getString().trim().equals("") || (Double.parseDouble(paydays.getString()) == 0) ) {
			//	msg = "Pay in must be greater ZERO.";
			}
			 
		} catch(Throwable t){
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
		append(estimatedarrive);
		append(pototal);
		append(paydays);
		append(obs);
		selectButtoms(true);
		getDisplay().setCurrentItem(vendorcode);
	} 
	
	private double calcPOSubTotal() {
		double result = 0;
		try{			
			int numRecords = getRSNumRecords();
			for(int i = 0; i< numRecords; i++){
				POItem poi = (POItem)getRSItem(i);
				result += (poi.costprice * poi.qty);
			}
		}catch(Throwable t){
			Log.getInstance().log(t.getMessage());
		}
				
		return Util.double4Digits(result);
	}
	
	private class EventSearchBarcode implements HttpEventListener{
		
		private FormPOBuilder owner;
		
		public EventSearchBarcode(FormPOBuilder owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED)
				{					
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{
						Hashtable ht;
						boolean modelExists = false;
						String resposta = new String(connectionHC.getResponse());
						ht = Util.queryToHashtable(resposta);
						if (ht.containsKey("modelexists")){
							modelExists = Util.stringToBoolean((String)ht.get("modelexists")); 
						}						
						
						Model model = ModelService.toModel(ht);
						model.barcode = new String(barcode.getString());
						
						POItem poi = POItemService.productToPOItem(model);
						
						fillAdditionalPOIInfo(poi);
						
						Alert alert = null;
						if (modelExists) {
							alert = new Alert("Information", "Model already in a Purchase Order", null, AlertType.WARNING);
							alert.setTimeout(Alert.FOREVER);
						}
						
						ht = new Hashtable();
						ht = Util.joinHashtables(getObjects(), ht);
						ht.put("POI", poi);
						ht.put("ISINSERT", new Boolean(true));			
						Object obj = FormLoader.loadForm(FormEditPOItem.class, getDisplay(), owner, ht, "Insert PO Item", null, alert);
						if (modelExists) {
							getDisplay().setCurrent(alert, (Displayable)obj);
						}
						else
							getDisplay().setCurrent((Displayable)obj);
						
					} else {
						refreshComponentArray();
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
					refreshComponentArray();
					
					ErrorAlert.getInstance().showError(getDisplay(), owner, erro);
				}
				else if (status==HttpEventListener.STATUS_CANCELLED)
				{
					refreshComponentArray();
					getDisplay().setCurrent(owner);			
				}
				
			} catch (Throwable e) {
				ErrorAlert.getInstance().showError(getDisplay(), owner, e);			
			}
			
		}		
		
	}


	private void fillAdditionalPOIInfo(POItem poi){
		poi.barcode = poi.model.barcode;
		poi.userid = getUser().iduser;
		poi.costprice = poi.model.vendorcost; 
		poi.saleprice = poi.model.sellingprice;
		poi.qty = 1;
	}

	public String getRecosrdStoreName() {
		return "FormPOBuilder";
	}

	public Object StringToItem(String query) {
		return POItemService.StringToPOItem(query);
	}

	public String ItemToString(Object obj) {
		return POItemService.POItemToString((POItem)obj);
	}

	public ChoiceGroup getLista() {
		return lista;
	}

}
