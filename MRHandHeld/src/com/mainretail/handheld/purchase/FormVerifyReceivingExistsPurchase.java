package com.mainretail.handheld.purchase;

import com.mainretail.util.ParentForm;

import java.util.Hashtable;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.TextField;

import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.Util;

public class FormVerifyReceivingExistsPurchase extends ParentForm {
	
	private static final String SVLSEARCHPURCHASE = "/searchpurchasesimple";
		
	private Purchase purchase;
			
	private TextField documentnumber;
		
	private EventExistsPurchase eventExistsPurchase;
		
	public FormVerifyReceivingExistsPurchase() {
		super();
			
		eventExistsPurchase = new EventExistsPurchase(this);
		
		purchase = new Purchase();
		documentnumber = new TextField("Document Number", "", 20, TextField.ANY);
	}
		
	public void initForm(){
		super.initForm();
		refresh();
	}
		
	public synchronized void refresh(){
		deleteAll();
		append(documentnumber);
		renameConfirmButtom("Search");
	}
		
	private void renameConfirmButtom(String newName){
		if (getConfirmButtom() != null){
			removeCommand(getConfirmButtom());
			setConfirmButtom(null);
		}
		setConfirmButtom(new Command(newName, Command.OK, 1));
		addCommand(getConfirmButtom());
	}	

	public void onSelect(Displayable d) {
		searchPurchase();
	}


	private void searchPurchase(){
		purchase.documentnumber = documentnumber.getString();
		Hashtable ht = PurchaseService.toHashtable(purchase);
		send(SVLSEARCHPURCHASE, ht, eventExistsPurchase);
	}
		
	private class EventExistsPurchase implements HttpEventListener{
			
		private FormVerifyReceivingExistsPurchase owner;
			
		public EventExistsPurchase(FormVerifyReceivingExistsPurchase owner){
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
							
						purchase = PurchaseService.toPurchase(Util.queryToHashtable(resposta));
						purchase.iduserprereceiving = getUser().iduser;
																	
						Hashtable ht = new Hashtable();
						ht.put("PURCHASE", purchase);
													
						Object form = FormLoader.loadForm(FormVerifyReceiving.class, getDisplay(), owner, ht, "Purchase", null);
						getDisplay().setCurrent((Displayable)form);
							
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
					purchase.documentnumber = "";
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
