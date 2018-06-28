package com.mainretail.handheld.sales;

import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
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
import com.mainretail.handheld.PanelGrid;
import com.mainretail.handheld.PanelQty;
import com.mainretail.handheld.debug.Log;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.ParentForm;
import com.mainretail.util.TextFieldObject;
import com.mainretail.util.Util;

public class FormFastSale extends ParentForm {

	private final static String SVLSALEINSERT = "/saleinsert";
	private static final String SVLSEARCHBARCODE = "/searchbarcode";
	
	private Invoice invoice = null;
	private Vector vetPreSaleItem = null;
	
	private TextField barcode = null;
	private Spacer spacerBarcode = null;
	
	private Command findBarcodeButtom = null;

	private PanelGrid panelgrid;
	private PanelQty panelQty;
	
	//	 Campos do PreSale
	private StringItem subtotal;
	
	private EventInsertPreSale eventInsertPreSale;
	private EventSearchBarcode eventSearchBarcode;
	
	public FormFastSale() {
		super();
		
		invoice = new Invoice(); 
		vetPreSaleItem = new Vector();
		
		barcode = new TextFieldObject("Barcode", null, 30, TextField.ANY, null);
		spacerBarcode = new Spacer(60, 5);
		findBarcodeButtom = new Command("Find", Command.OK, 4);
		
        // Campos do PreSale
		subtotal = new StringItem("Presale Subtotal", null);
		startPanelGrid();
		
		panelQty = new PanelQty();
		eventInsertPreSale = new EventInsertPreSale(this);
		eventSearchBarcode = new EventSearchBarcode(this);
		setAnonymousItemStateListener();
	}
	
	private void startPanelGrid(){
		
		String[] titles = new String[3];
		titles[0] = "Description";
		titles[1] = "Qty";
		titles[2] = "Tot";
			
		int[] colSize = new int[3];
		colSize[0] = 200;
		colSize[1] = 30;
		colSize[2] = 30;

		panelgrid = new PanelGrid(titles, colSize);	
		
		panelgrid.getBtnDelete().setActionListener(this);
		panelgrid.getBtnEdit().setActionListener(this);
	}
	
	public void defaultValues() {		
	}

	public void initForm() {
		super.initForm();		
		refreshComponentArray();
	}
	
	private void selectButtoms(boolean finalization){
		removeCommand(findBarcodeButtom);
		renameConfirmButtom("Save");
		removeCommand(getConfirmButtom());
		
		

		if (finalization) {
			renameConfirmButtom("Send");			
		} else {
			
			if (!vetPreSaleItem.isEmpty()){
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
		append(panelQty.getPanelQty());
		append(panelQty.getButtonLess());
		append(panelQty.getButtonPluss());
		append(panelQty.getButton10());
		append(panelQty.getButtonClr());
		append(barcode);
		append(subtotal);
		append(spacerBarcode);
		
		append(panelgrid.getBtnPrior());
		append(panelgrid.getBtnNext());
		append(panelgrid.getBtnDelete());
		append(panelgrid.getBtnEdit());
		append(panelgrid.getPanelGrid());
		
		barcode.setString("");
		panelQty.setQty(1);
				
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
		PreSaleItem psi = searchFirstBarcode(barcode.getString());
		
		if (psi != null) {
			psi = psi.clone();
			psi.qty = panelQty.getQty();
			vetPreSaleItem.insertElementAt(psi, 0);
			refreshComponentArray();
			/*
			Hashtable ht = new Hashtable();
			ht = Util.joinHashtables(getObjects(), ht);
			ht.put("PSI", psi.clone());
			ht.put("ISINSERT", new Boolean(true));
			
			FormLoader.loadForm(FormEditPreSaleItem.class, getDisplay(), this, ht, "Insert Presale Item", null);
			*/
		} else {
			Model model = new Model();
			model.barcode = barcode.getString();
			model.qty = panelQty.getQty();
			
			Hashtable ht = ModelService.toHashtable(model);
			send(SVLSEARCHBARCODE, ht, eventSearchBarcode);
		}
	}
	
	private PreSaleItem searchFirstBarcode(String barcode){
		PreSaleItem retorno = null;
		for(Enumeration en = vetPreSaleItem.elements(); en.hasMoreElements();){
			PreSaleItem psi = (PreSaleItem)en.nextElement();
			if (psi.model.barcode != null) {
				if (psi.model.barcode.equals(barcode.trim())){
					retorno = psi;
					break;
				}	
			}
		}
		return retorno;
	}
	
	public void refreshComponentArray(){
		refresh();
		subtotal.setText(String.valueOf(calcPreSaleSubTotal()));
		
		panelgrid.deleteRows(0, panelgrid.getGridModel().getRows());

		selectButtoms(false);
		
		panelgrid.getGridModel().setRows(0);
		
		String description; 
		
		for (Enumeration en = vetPreSaleItem.elements(); en.hasMoreElements();){
			  PreSaleItem preSaleItem =(PreSaleItem)en.nextElement();
			  description = preSaleItem.model.description;
			  
			  if (description.length() > 18) 
				description = description.substring(0,18) + "...";
			  
			  String[] values = new String[3];
			  
			  values[0] = description;
			  values[1] = String.valueOf(preSaleItem.qty);
			  values[2] = String.valueOf(Util.double4Digits(preSaleItem.saleprice*preSaleItem.qty));
			  
			  panelgrid.insertRow(values);
			  
		}
		
		
		getDisplay().setCurrentItem(barcode);	
	}
	
	private class EventInsertPreSale implements HttpEventListener{
		
		private FormFastSale owner;
		
		public EventInsertPreSale(FormFastSale owner){
			this.owner = owner;
		}

		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{
						invoice = InvoiceService.toInvoice(Util.queryToHashtable(new String(connectionHC.getResponse())));
						vetPreSaleItem.removeAllElements();
						Alert alert = new Alert("Sale sent", "Your sale code number is " + invoice.salecode, null, AlertType.INFO);
						alert.setTimeout(Alert.FOREVER);
						owner.refreshComponentArray();
						owner.getDisplay().setCurrent(alert, owner);
																		
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

	private void sendPreSale(){
		if (validatePreSale()){
		
			invoice = new Invoice();
			
			invoice.iddelivertype = Invoice.DELIVER_TYPE_ONHAND;
			invoice.layaway = false;
			invoice.idstore = Integer.parseInt(Config.getInstance().store);
			invoice.firstname = null;
			invoice.lastname = null;
			invoice.zip = null;
			invoice.idcustomer = 1;
			invoice.zip = null;
			invoice.idothercommission = 0;
			invoice.idmedia = 20;
			invoice.idtouristgroup = 0;
			invoice.note = null;
			invoice.printnotes = false;
		
			Hashtable htPreSaleItem = PreSaleItemService.vectorToHashtable(vetPreSaleItem);
			
			Hashtable ht = InvoiceService.toHashtable(invoice);
			
			ht = Util.joinHashtables(htPreSaleItem, ht);
			
			send(SVLSALEINSERT, ht, eventInsertPreSale);
		}
	}
	
	private boolean validatePreSale() {
		String msg = "";
		try{
			
			/*
			if (vendorcode.getString().trim().equals("")){
				msg = "You must fill Vendor Code field.";
			} else if (purchasenumber.getString().trim().equals("")){
				msg = "You must fill Purchase Number field.";
			} else if (subtotal.getString().trim().equals("")){
				msg = "You must fill Purchase Subtotal field.";
			} else if (freight.getString().trim().equals("")){
				msg = "You must fill Freight field.";
			}
			*/ 
		} catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);					
		
		return msg.equals("");
	}
	
	private void showPreSaleFields(){
		deleteAll();
		subtotal.setText(String.valueOf(calcPreSaleSubTotal()));
		append(subtotal);						
		selectButtoms(true);
	} 
	
	private double calcPreSaleSubTotal() {
		double result = 0;
		try{
			for (Enumeration en = vetPreSaleItem.elements(); en.hasMoreElements();){
				PreSaleItem psi = (PreSaleItem)en.nextElement();
				result += (psi.saleprice * psi.qty);
			}
		}catch(Throwable t){
			Log.getInstance().log(t.getMessage());
		}
				
		return Util.double4Digits(result);
	}
	
	private class EventSearchBarcode implements HttpEventListener{
		
		private FormFastSale owner;
		
		public EventSearchBarcode(FormFastSale owner){
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
						
						Model model = ModelService.toModel(Util.queryToHashtable(resposta));
						model.barcode = barcode.getString();
						
						PreSaleItem psi = PreSaleItemService.productToPreSaleItem(model);
						
						psi.qty = panelQty.getQty();
						
						fillAdditionalPSIInfo(psi);
						
						vetPreSaleItem.insertElementAt(psi, 0);
						
						refreshComponentArray();
						
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

	public Vector getVetPreSaleItem() {
		return vetPreSaleItem;
	}
	
	private void fillAdditionalPSIInfo(PreSaleItem psi){		
		psi.idcliente = 1;		
		psi.idstore = Integer.parseInt(Config.getInstance().store);
		psi.discount = 0;
		psi.iduser = getUser().iduser;
		psi.idcomission = getUser().comissionid;
		psi.movdate = new Date();
		psi.presaledate = psi.movdate;
		psi.resetdiscount = false;
		psi.manager = false;
		psi.promo = false;
		
		psi.costprice = psi.model.vendorcost; 
		psi.saleprice = psi.model.sellingprice;
	}

	public void editSaleItem(PreSaleItem psi){
		if (psi != null){
			Hashtable ht = new Hashtable();
			ht = Util.joinHashtables(getObjects(), ht);
			ht.put("PSI", psi);
			ht.put("ISINSERT", new Boolean(false));							
			FormLoader.loadForm(FormEditPreSaleItem.class, getDisplay(), this, ht, "Edit Presale Item", null);
		}
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
				
				switch (c.getPriority()){
					case 0:{
						
					}
					case 1:{
						if (getConfirmButtom().getLabel().equals("Save")) {
							showPreSaleFields();
						} else {
							sendPreSale();
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
	
	public void lwActionListenerCallback(Object src, Object data) {
		int i = panelgrid.getGrid().getSelectedIndex();
		PreSaleItem psi = null;
		if (i >= 0) {
			psi = (PreSaleItem)vetPreSaleItem.elementAt(i);				
		}
		
		if (src == panelgrid.getBtnDelete()){
			if (psi != null){
				vetPreSaleItem.removeElementAt(i);
				refreshComponentArray();
			}
		} else if (src == panelgrid.getBtnEdit()){
			editSaleItem(psi);
		}
	}
	
}
