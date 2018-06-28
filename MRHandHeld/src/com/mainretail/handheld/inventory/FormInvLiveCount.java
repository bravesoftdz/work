package com.mainretail.handheld.inventory;

import java.util.Hashtable;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.ItemStateListener;
import javax.microedition.lcdui.StringItem;
import javax.microedition.lcdui.TextField;

import com.mainretail.handheld.Config;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.ParentForm;
import com.mainretail.util.SendingForm2;
import com.mainretail.util.Util;

public class FormInvLiveCount extends ParentForm implements Runnable {
	
	private static final String SVLSEARCHBARCODE = "/searchbarcode";
	private static final String SVLINSERTLIVECOUNT = "/insertlivecount";
	
	private InvCount invcount;
	private TextField qty;
	private TextField barcode;
	private StringItem description;
	private StringItem dummy;
	
	private EventInsertLiveCount eventInsertLiveCount;
	private EventSearchBarcode eventSearchBarcode;
	private Model product;
	private Model model;
	
	public FormInvLiveCount() {
		super();
		
		qty = new TextField("Quantity", null, 10, TextField.DECIMAL);
		barcode = new TextField("Barcode", null, 30, TextField.ANY);
		description = new StringItem("", "");
		dummy = new StringItem("", "");
		
		product = new Model();
			
		eventInsertLiveCount = new EventInsertLiveCount(this);
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
	
	
	private void refreshBarcodeComponent(boolean enabled){
		
		if (!getDisplay().getCurrent().equals(this)) 
			getDisplay().setCurrent(this);
		
		this.setItemStateListener(null);
		
		
		int pos = getItemIsShowing(dummy);
		
		
		if (pos == -1) {
			insert(0, dummy);
			waitTaskReturn(50);			
		}
		
		getDisplay().setCurrentItem(dummy);
		
		pos = getItemIsShowing(barcode);
		
		
		if (pos != -1)
			delete(pos);
		
		
		int constraint = TextField.ANY;
		String barCodeText = null;
		
		
		if (barcode != null){
			//barCodeText = barcode.getString();
			if (model == null)
				barCodeText = barcode.getString();
			else
				barCodeText = model.barcode;
					
			barcode = null;
		}
		
		
		if (!enabled)
			constraint = constraint | TextField.UNEDITABLE;
		
		
		barcode = new TextField("Barcode", barCodeText, 20, constraint);
		
		
		insert(0, barcode);
		waitTaskReturn(50);
		
		if (enabled)
			getDisplay().setCurrentItem(barcode);
		else {
			if (getItemIsShowing(qty) == -1)
				append(qty);
			waitTaskReturn(50);
			
			getDisplay().setCurrentItem(qty);
		}
		
		
		pos = getItemIsShowing(dummy);
		if (pos >= 0)
			delete(pos);
		
		setAnonymousItemStateListener();
		
		System.gc();		
	}
	
	
	
	public void refresh(){
		description.setText("");
		getDisplay().setCurrent(this);
		
		int pos = getItemIsShowing(dummy);
		if (pos == -1) {
			insert(0, dummy);			
			waitTaskReturn(50);
		}		
		getDisplay().setCurrentItem(dummy);
		
		while((size() > 1)) {
			delete(1);
		}
				
		refreshBarcodeComponent(true);
		defaultValues();
	}
	
	public void defaultValues(){
		qty.setString("");
		barcode.setString("");
		description.setText("");
		getDisplay().setCurrentItem(barcode); 
	}
	
	public void onSelect(Displayable d) {
		if (description.getText().trim().equals(""))
		{
			// Procurar o Barcode
			searchBarcode();
		}
		else
		{
			//Salvar para o Banco
			InsertInvMov();
		}
	}
	
	public void initForm(){
		super.initForm();	
		refresh();
	}
	
	private void searchBarcode(){
		//Model product = new Model();
		product.barcode = barcode.getString();
		//product.qty = Double.parseDouble(qty.getString());
		product.description = null;
		product.model = null;
		
		
		Hashtable ht = ModelService.toHashtable(product);
		model = null;
		
		enviar(SVLSEARCHBARCODE, ht, eventSearchBarcode);
		
		
		append(description);
		//append(qty);
		
		
	}
	public void run() {
		searchBarcode();
	}
	
	public void endBarcodeScan(){
		onSelect(this);
	}
	
	private void InsertInvMov(){
		InvMov invmov = new InvMov();
		invmov.iduser = getUser().iduser;
		invmov.idstore = Integer.parseInt(Config.getInstance().store);
		invmov.idinvmovtype = 21;	
		invmov.idmodel = product.idmodel;
		invmov.documentid = 0;
		invmov.barcode = barcode.getString();
		invmov.qty = nullField(qty, 1);
		
		Hashtable ht = InvMovService.toHashtable(invmov);
		
		InvCountItem invcountitem = new InvCountItem();
		invcountitem.idcount = invcount.idcount;
		invcountitem.iduser = getUser().iduser;
		invcountitem.barcode = barcode.getString();
		invcountitem.qty = nullField(qty, 1);
		invcountitem.saleprice = 0;
		
		ht = InvCountItemService.toHashtable(invcountitem,ht);
		
		
		enviar(SVLINSERTLIVECOUNT, ht, eventInsertLiveCount);		
	}
	
	public void setObjects(Hashtable objects) {		
		super.setObjects(objects);
		this.invcount = (InvCount)getObjects().get("INVCOUNT");
	}
	
	
	private class EventInsertLiveCount implements HttpEventListener{
		private FormInvLiveCount owner;
		public EventInsertLiveCount(FormInvLiveCount owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{
					
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) {														
						qty.setString("");
						refresh();
					} else {
						
						String msg = connectionHC.getResponseMessage() ;
						if (msg == null)
						{
							msg = "";
						}
						refresh();
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
				
			} catch (Exception e) {
				refresh();
				ErrorAlert.getInstance().showError(getDisplay(), owner, e);			
			}			
			
		}		
		
	}
	
	
	private class EventSearchBarcode implements HttpEventListener{
		private FormInvLiveCount owner;
		public EventSearchBarcode(FormInvLiveCount owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				int responseCode = connectionHC.getResponseCode();
				
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{					
					
					if (responseCode == HttpConnection.HTTP_OK) 
					{														
						String resposta = new String(connectionHC.getResponse());						
						
						product = ModelService.toModel(Util.queryToHashtable(resposta));
						model = product;
						
						description.setText(product.description);			
						qty.setString("");			
						
						/*
						getDisplay().setCurrent(owner);
						getDisplay().setCurrentItem(qty);
						*/
						refreshBarcodeComponent(false);
					} else {
						String msg = connectionHC.getResponseMessage() ;						
						if (msg == null)
						{
							msg = "";
						}
						refresh();
						ErrorAlert.getInstance().showError(getDisplay(), owner,
								String.valueOf(responseCode)+ " " + msg);

					}
				}
				else if (status==HttpEventListener.STATUS_ERROR)
				{
					/*
					description.setText(connectionHC.getResponseMessage());
					refreshBarcodeComponent(false);
					ErrorAlert.getInstance().showError(getDisplay(), owner, erro);
					*/
					
					
					String msg = connectionHC.getResponseMessage() ;						
					if (msg == null)
					{
						msg = "";
					}
					refresh();
					ErrorAlert.getInstance().showError(getDisplay(), owner,
							String.valueOf(responseCode)+ " " + msg);					
				}
				else if (status==HttpEventListener.STATUS_CANCELLED)
				{				
					getDisplay().setCurrent(owner);			
				}
				
			} catch (Exception e) {
				ErrorAlert.getInstance().showError(getDisplay(), owner, e);			
			}			
			
		}		
		
	}
	
	private void enviar(String servlet, Hashtable ht, HttpEventListener listener) {
		try {
			//Hashtable parametros = ht;
			HttpConnectionHC httpConnectionHC = new HttpConnectionHC(Config.getInstance().getUrl(servlet), ht, HttpConnection.POST);
			SendingForm2 sendingForm = new SendingForm2(getDisplay(), this, httpConnectionHC, listener);
			sendingForm.start();
			getDisplay().setCurrent(sendingForm);
		} catch (Throwable e) {
			ErrorAlert.getInstance().showError(getDisplay(), this, e);
		}
		
	}	
	
}