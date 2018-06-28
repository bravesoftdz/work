package com.mainretail.handheld.purchase;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.TextField;

import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.ParentForm;
import com.mainretail.util.Util;

public class FormImportPO extends ParentForm {
	private static final String SVLSEARCHPO = "/searchpo";
	
	private Vector vetPurchaseItem = null;
	private Purchase purchase = null;
	private PO po;
	
	private TextField ponumber;
	
	private EventSearchPO eventSearchPO;
	
	public FormImportPO() {
		super();
		
		eventSearchPO = new EventSearchPO(this);
		
		vetPurchaseItem = new Vector();
		po = new PO();
		ponumber = new TextField("PO Number", "", 20, TextField.ANY);
	}
	
	public void initForm(){
		super.initForm();
		refresh();
	}
	
	public synchronized void refresh(){
		deleteAll();
		append(ponumber);
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
		searchPO();
	}


	private void searchPO(){
		po.idpo = Integer.parseInt(ponumber.getString());
		Hashtable ht = POService.toHashtable(po);
		send(SVLSEARCHPO, ht, eventSearchPO);
	}
	
	private class EventSearchPO implements HttpEventListener{
		
		private FormImportPO owner;
		
		public EventSearchPO(FormImportPO owner){
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
						
						po = POService.toPO(Util.queryToHashtable(resposta));
						
						purchase = POService.toPurchase(po);
						purchase.iduserprereceiving = getUser().iduser;
						
						vetPurchaseItem.removeAllElements();
						
						Vector vetPOItem = POItemService.queryStringToVector(resposta);
						for(Enumeration en = vetPOItem.elements(); en.hasMoreElements();){
							PurchaseItem pui = PurchaseItemService.toPurchaseItem((POItem)en.nextElement());
							pui.vendor = purchase.vendor;
							vetPurchaseItem.addElement(pui);
						}
						
						Hashtable ht = new Hashtable();
						ht.put("VETPUI", vetPurchaseItem);
						ht.put("PURCHASE", purchase);
						ht = Util.joinHashtables(getObjects(), ht);
						
						ponumber.setString("");
						
						Object form = FormLoader.loadForm(FormPurchaseItemList.class, getDisplay(), owner, ht, "Purchase", null);
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
					ponumber.setString(null);
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


