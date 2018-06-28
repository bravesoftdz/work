package com.mainretail.handheld.inventory;

import java.util.Hashtable;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.ItemStateListener;
import javax.microedition.lcdui.StringItem;
import javax.microedition.lcdui.TextField;

import com.mainretail.handheld.Config;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.handheld.debug.Log;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.ParentForm;
import com.mainretail.util.Util;

public class FormInvCycleCount extends ParentForm {
	
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
	
	public FormInvCycleCount() {
		super();
		
		qty = new TextField("Quantity", null, 10, TextField.DECIMAL);
		barcode = new TextField("Barcode", null, 30, TextField.ANY);
		description = new StringItem("", "");
		dummy = new StringItem("", "");
		
		eventInsertBarcode = new EventInsertBarcode(this);
		eventSearchBarcode = new EventSearchBarcode(this);
		
		setAnonymousItemStateListener();
	}
	
	private void refreshBarcodeComponent(boolean enabled) {
		
		try {
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
		} catch (RuntimeException e) {
			e.printStackTrace();
		}
	}
	
		
	public void refresh(){		
		Log.getInstance().log("FormInvCycleCount.refresh() - Inicio");
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
		Log.getInstance().log("FormInvCycleCount.refresh() - Fim");
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
			Log.getInstance().log("FormInvCycleCount.onSelect().InsertBarcode - Inicio");
			//Salvar para o Banco
			InsertBarcode();
			//refresh();
			Log.getInstance().log("FormInvCycleCount.onSelect().InsertBarcode - Fim");
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
	
		send(SVLSEARCHBARCODE, ht, eventSearchBarcode);
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
		Log.getInstance().log("FormInvCycleCount.InsertBarcode() - Inicio");
		InvCountItem invcountitem = new InvCountItem();
		
		invcountitem.idcount = invcount.idcount;
		invcountitem.iduser = getUser().iduser;
		invcountitem.barcode = barcode.getString();
		invcountitem.qty = nullField(qty, 1);
		invcountitem.saleprice = 0;
		
		Hashtable ht = InvCountItemService.toHashtable(invcountitem);
		
		
		send(SVLINSERTBARCODE, ht, eventInsertBarcode);
		Log.getInstance().log("FormInvCycleCount.InsertBarcode() - Fim");
	}
	
	public void setObjects(Hashtable objects) {		
		super.setObjects(objects);
		this.invcount = (InvCount)getObjects().get("INVCOUNT");
	}
	
	
	private class EventInsertBarcode implements HttpEventListener{
		
		private FormInvCycleCount owner;
		
		public EventInsertBarcode(FormInvCycleCount owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			Log.getInstance().log("EventInsertBarcode.httpEvent() - Inicio");
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{
					Log.getInstance().log("EventInsertBarcode.httpEvent().STATUS_CONCLUIDO - Inicio");
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK)	{   
						Log.getInstance().log("EventInsertBarcode.httpEvent().STATUS_CONCLUIDO - HTTP_OK");									
						qty.setString("");
						refresh();
					} else {
						
						Log.getInstance().log("EventInsertBarcode.httpEvent().STATUS_CONCLUIDO - " + responseCode);
						
						String msg = connectionHC.getResponseMessage() ;
						if (msg == null)
						{
							msg = "";
						}
						refresh();
						ErrorAlert.getInstance().showError(getDisplay(), owner,
								String.valueOf(responseCode)+ " " + msg);					
					}
					Log.getInstance().log("EventInsertBarcode.httpEvent().STATUS_CONCLUIDO - Fim");
				}
				else if (status==HttpEventListener.STATUS_ERROR)
				{					
					Log.getInstance().log("EventInsertBarcode.httpEvent().STATUS_ERRO - Inicio");
					ErrorAlert.getInstance().showError(getDisplay(), owner, erro);
					Log.getInstance().log("EventInsertBarcode.httpEvent().STATUS_ERRO - Fim");
					
				}
				else if (status==HttpEventListener.STATUS_CANCELLED)
				{
					getDisplay().setCurrent(owner);					
				}
				
			} catch (Throwable e) {
				refresh();
				ErrorAlert.getInstance().showError(getDisplay(), owner, e);			
			}
			finally {						
				Log.getInstance().log("EventInsertBarcode.httpEvent() - Fim -> " + getDisplay().getCurrent().getTitle()+"/"+((Form)getDisplay().getCurrent()).size()+"/" + getDisplay().getCurrent().getClass().getName());
			}
			
		}		
		
	}
	
	
	private class EventSearchBarcode implements HttpEventListener{
		
		private FormInvCycleCount owner;
		
		public EventSearchBarcode(FormInvCycleCount owner){
			this.owner = owner;
		}
		
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				model = null;
				if (status==HttpEventListener.STATUS_CONCLUDED)
				{					
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{														
						String resposta = new String(connectionHC.getResponse());
						
						model = ModelService.toModel(Util.queryToHashtable(resposta));
						description.setText(model.description);
						qty.setString("");
						
						refreshBarcodeComponent(false);//, owner);
					} else {
						String msg = connectionHC.getResponseMessage() ;						
						if (msg == null)
						{
							msg = "";
						}
						//refreshBarcodeComponent(false, owner);
						ErrorAlert.getInstance().showError(getDisplay(), owner,
								String.valueOf(responseCode)+ " " + msg);					
					}
				}
				else if (status==HttpEventListener.STATUS_ERROR)
				{
					System.err.println("Aqui");
					description.setText(connectionHC.getResponseMessage());
					refreshBarcodeComponent(false);//, owner);					
					ErrorAlert.getInstance().showError(getDisplay(), owner, erro);
					
				}
				else if (status==HttpEventListener.STATUS_CANCELLED)
				{				
					getDisplay().setCurrent(owner);			
				}
				
			} catch (Throwable e) {
				e.printStackTrace();
				ErrorAlert.getInstance().showError(getDisplay(), owner, e);			
			}
		}		
		
	}
	
	public void doMsg(String msg) {
		System.err.println(msg);
	}
}

