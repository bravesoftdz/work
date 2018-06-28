package com.mainretail.handheld.inventory;

import java.util.Hashtable;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Display;
import javax.microedition.midlet.MIDlet;

import com.mainretail.handheld.Config;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.FormLoader;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.ParentMenu;
import com.mainretail.util.SendingForm2;
import com.mainretail.util.Util;

public class InventoryMenu extends ParentMenu implements HttpEventListener{

	private static final String SVLCOUNTEREDEXIST = "/counteredexist";
	private InvCount invcount;	
	
	public InventoryMenu(String title, Display display, MIDlet caller, Class[] forms, String[] titles, String[] images) {
		super(title, display, caller, forms, titles, images);
				
	}
	

	public void populateInfoTable() {		
		super.populateInfoTable();
		addInfo("INVCOUNT", this.invcount);
	}

	public void onValidateForm() {
		Hashtable ht = new Hashtable();
		ht.put("IC.idstore", Config.getInstance().store);
		ht.put("IC.counttype", String.valueOf(getMenuCountType()));
		send(ht);	
	}

	public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable error) {
		try {
			
			if (status == HttpEventListener.STATUS_CONCLUDED )
			{			
				int responseCode = connectionHC.getResponseCode();
				if (responseCode == HttpConnection.HTTP_OK) 
				{														
					String reply = new String(connectionHC.getResponse());
					
					invcount = InvCountService.toInvCount(Util.queryToHashtable(reply));
					
					int i = this.getSelectedIndex();
					
					populateInfoTable();
					
					FormLoader.loadForm(getForms()[i], getDisplay(), this, getInfoTable(), getTitles()[i], getImages()[i]);										
					
				} else {
					
					String msg = connectionHC.getResponseMessage() ;
					if (msg == null)
					{
						msg = "";
					}
					
					ErrorAlert.getInstance().showError(getDisplay(), this,
							String.valueOf(responseCode)+ " " + msg);
					
				}
			}
			else if (status==HttpEventListener.STATUS_ERROR)
			{
				
				ErrorAlert.getInstance().showError(getDisplay(), this, error);
				
				
			}
			else if (status==HttpEventListener.STATUS_CANCELLED)
			{				
				getDisplay().setCurrent(this);			
			}
			
		} catch (Exception e) {
			ErrorAlert.getInstance().showError(getDisplay(), this, e);			
		}
		
	}
		
	private void send(Hashtable ht) {
		try {
			Hashtable parameters = ht;
			HttpConnectionHC httpConnectionHC = new HttpConnectionHC(Config.getInstance().getUrl(SVLCOUNTEREDEXIST), parameters, HttpConnection.GET);
			SendingForm2 sending = new SendingForm2(getDisplay(), this, httpConnectionHC, this);
			sending.start();
			getDisplay().setCurrent(sending);
		} catch (Throwable e) {
			ErrorAlert.getInstance().showError(getDisplay(), this, e);
		}

	}
	
	public int getMenuCountType(){
		
		int result = 0;
		int i = this.getSelectedIndex();
		
		if (getForms()[i] == FormInvCycleCount.class){
			result = 1;
		}
		if (getForms()[i] == FormInvPhysicalCount.class){
			result = 2;
		}
		if (getForms()[i] == FormInvLiveCount.class){
			result = 3;
		}
		if (getForms()[i] == FormInvStartUpCount.class){
			result = 4;
		}
		if (getForms()[i] == FormBarcodePrint.class){
			result = -1;
		}
		
		return result;
	}

}