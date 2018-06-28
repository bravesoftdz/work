package com.mainretail.handheld.purchase;

import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.TextField;

import com.mainretail.handheld.BarcodeService;
import com.mainretail.handheld.Config;
import com.mainretail.handheld.ModelVerifyQty;
import com.mainretail.handheld.ModelVerifyQtyService;
import com.mainretail.handheld.ParentFormPersistent;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.Util;

public class FormImportPurchase extends ParentFormPersistent {
	private static final String SVLSEARCHPURCHASE = "/validatereceiving";
	
	//private Vector vetModelVerifyQty = null;
	private Vector vetBarcode = null;
	private Purchase purchase = null;
	
	private TextField documentnumber;
	
	private EventSearchPurchase eventSearchPurchase;
	
	public FormImportPurchase() {
		super();
		
		eventSearchPurchase = new EventSearchPurchase(this);
		
		purchase = new Purchase();
		//vetModelVerifyQty = new Vector();
		//vetBarcode = new Vector();
		documentnumber = new TextField("Document Number", "", 20, TextField.ANY);
	}
	
	public void beforeExit() {
		//vetModelVerifyQty.removeAllElements();
		//removeAllRSItems();
		discardBarcodeVector();
		purchase = null;
		//vetModelVerifyQty = null;	
	}
	
	public void initForm(){
		super.initForm();
		//loadRecordStore();
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
		send(SVLSEARCHPURCHASE, ht, eventSearchPurchase);
	}
	
	private class EventSearchPurchase implements HttpEventListener{
		
		private FormImportPurchase owner;
		
		public EventSearchPurchase(FormImportPurchase owner){
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
						
						//purchase = PurchaseService.toPurchase(Util.queryToHashtable(resposta));
						purchase = PurchaseService.toPurchase(resposta);
					
						purchase.iduserprereceiving = getUser().iduser;
						
						Vector vetTemp = null;
						loadRecordStore();
						
						if (!purchase.documentnumber.equals(Config.getInstance().lastVerifyReceiving)){						
							// Retorna vetor de ModelQtyVerify 
							vetTemp = ModelVerifyQtyService.queryStringToVector(resposta);
							
							removeAllRSItems();
							Config.getInstance().lastVerifyReceiving = purchase.documentnumber;
							Config.getInstance().save();
							try {								
								 while (!vetTemp.isEmpty()){
									addRSItem((ModelVerifyQty)vetTemp.elementAt(0));
									vetTemp.removeElementAt(0);
									System.gc();
								};
								
							}
							catch(Exception e) {
								e.printStackTrace();
							}
						}

						unloadRecordStore();
						vetTemp = null;
						
						Hashtable ht = new Hashtable();
						ht.put("RSMVQ", getRecosrdStoreName());
						
						// Retorna vetor de Barcode
						
						/*
						vetTemp = BarcodeService.queryStringToVector(resposta);						
						vetBarcode.removeAllElements();
						for (Enumeration en = vetTemp.elements(); en.hasMoreElements();) {
							vetBarcode.addElement((Barcode)en.nextElement());
						}
						*/
						discardBarcodeVector();
						vetBarcode = BarcodeService.queryStringToVector(resposta);
						ht.put("VETBCD", vetBarcode);
						//discardBarcodeVector();
						
						ht.put("PURCHASE", purchase);
						ht = Util.joinHashtables(getObjects(), ht);
						
						documentnumber.setString("");
						
						Object form = FormLoader.loadForm(FormImportPurchaseItemList.class, getDisplay(), owner, ht, "Purchase", null);
						getDisplay().setCurrent((Displayable)form);
						
						ht = null;												
						
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
					documentnumber.setString(null);
					ErrorAlert.getInstance().showError(getDisplay(), owner, erro);
				}
				else if (status==HttpEventListener.STATUS_CANCELLED)
				{				
					getDisplay().setCurrent(owner);			
				}
				
			} catch (Throwable e) {
				ErrorAlert.getInstance().showError(getDisplay(), owner, e);			
			}
			finally{
				
				connectionHC.unload();
			}
		}		
		
	}

	public String getRecosrdStoreName() {
		return "FormImportPurchaseItemList";
	}

	public Object StringToItem(String query) {
		return ModelVerifyQtyService.StringToModelVerifyQty(query);
	}

	public String ItemToString(Object obj) {
		return ModelVerifyQtyService.ModelVerifyQtyToString((ModelVerifyQty)obj);
	}
	
	public void discardBarcodeVector() {
		if (vetBarcode != null) {
			vetBarcode.removeAllElements();
			vetBarcode = null;
			System.gc();
		}
	}

}

