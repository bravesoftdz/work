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

public class FormInvPhysicalCount extends ParentForm implements Runnable {
	
	private static final String SVLSEARCHBARCODE = "/searchbarcode";
	private static final String SVLINSERTBARCODE = "/insertbarcode";
	
	private InvCount invcount;
	private TextField qty;
	private TextField barcode;
	private StringItem description;
	private StringItem dummy;
	private Model model;
	
	private EventInsertBarcode eventInsertBarcode;
	private EventSearchBarcode eventSearchBarcode;
	
	public FormInvPhysicalCount() {
		super();
		
		qty = new TextField("Quantity", null, 10, TextField.DECIMAL);
		barcode = new TextField("Barcode", null, 30, TextField.ANY);
		description = new StringItem("", "");
		dummy = new StringItem("", "");
		
		eventInsertBarcode = new EventInsertBarcode(this);
		eventSearchBarcode = new EventSearchBarcode(this);
		
		setAnonymousItemStateListener();
		model = null;
	}
	
	private synchronized void refreshBarcodeComponent(boolean enabled) {
		
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
			InsertBarcode();
		}
	}
	
	public void initForm(){
		super.initForm();	
		refresh();
	}
	
	private void searchBarcode(){
		model = null;
		Model product = new Model();
		product.barcode = barcode.getString();
		product.qty = nullField(qty, 1);
		
		Hashtable ht = ModelService.toHashtable(product);
		
		append(description);
		//append(qty);

		
		enviar(SVLSEARCHBARCODE, ht, eventSearchBarcode);

		//append(description);
		//append(qty);

		
	}
	public void run() {
		searchBarcode();
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
		onSelect(this);
	}
	
	private void InsertBarcode(){
		InvCountItem invcountitem = new InvCountItem();
		
		invcountitem.idcount = invcount.idcount;
		invcountitem.iduser = getUser().iduser;
		invcountitem.barcode = barcode.getString();
		invcountitem.qty = nullField(qty, 1);
		invcountitem.saleprice = 0;
		
		Hashtable ht = InvCountItemService.toHashtable(invcountitem);
		
		enviar(SVLINSERTBARCODE, ht, eventInsertBarcode);		
	}
	public void setObjects(Hashtable objects) {		
		super.setObjects(objects);
		this.invcount = (InvCount)getObjects().get("INVCOUNT");
	}
	
	
	private class EventInsertBarcode implements HttpEventListener{
		private FormInvPhysicalCount owner;
		public EventInsertBarcode(FormInvPhysicalCount owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED ) {
					
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK)	{						
						qty.setString("");
						refresh();						
					} else {
						
						String msg = connectionHC.getResponseMessage() ;
						if (msg == null){
							msg = "";
						}
						refresh();
						ErrorAlert.getInstance().showError(getDisplay(), owner,
								String.valueOf(responseCode)+ " " + msg);					
					}
				}
				else if (status==HttpEventListener.STATUS_ERROR) {
					
					ErrorAlert.getInstance().showError(getDisplay(), owner, erro);
									
				}
				else if (status==HttpEventListener.STATUS_CANCELLED) {
					getDisplay().setCurrent(owner);				
				}
				
			} catch (Exception e) {
				refresh();
				ErrorAlert.getInstance().showError(getDisplay(), owner, e);			
			}
			finally {			
				
				//getDisplay().setCurrent(owner);
				//owner.refresh();
				
			}
			
		}		
		
	}
	
	
	private class EventSearchBarcode implements HttpEventListener{
		private FormInvPhysicalCount owner;
		public EventSearchBarcode(FormInvPhysicalCount owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{
					
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{
						
						String resposta = new String(connectionHC.getResponse());
						
						Model product = ModelService.toModel(Util.queryToHashtable(resposta));
						
						model = product;
						
						description.setText(product.description);			
						qty.setString("");			

						refreshBarcodeComponent(false);
						
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
					description.setText(connectionHC.getResponseMessage());
									
					refreshBarcodeComponent(false);
					ErrorAlert.getInstance().showError(getDisplay(), owner, erro);
					
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