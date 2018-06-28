package com.mainretail.handheld.purchase;

import java.io.IOException;

import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Image;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;

public class MRPurchase extends MIDlet {
	
	private Display display;	
	private PurchaseMenu mnuPurchase;
	
	public MRPurchase() {
		super();
	}

	protected void startApp() throws MIDletStateChangeException {
		display = Display.getDisplay(this);		
		mnuPurchase = new PurchaseMenu("Purchase", display, this, new Class[]{FormPOBuilder.class, FormReceiving.class, FormImportPO.class, FormRequest.class, FormExpressPO.class, FormExpressPurchase.class, /*FormImportPurchase.class, */ FormVerifyReceivingExistsPurchase.class}, new String[]{"PO Builder", "Receiving", "Receiving PO", "Request", "Express PO", "Express Receive", "Verify Receiving Express"}, new String[]{"/po.png", "/receiving.png", "/poimport.png", "/request.png", "/fast_po.png", "/fast_receiving.png", null});
		
		Alert alert;
		try {
			alert = new Alert("MainRetail" , null, Image.createImage("/mr.png"), AlertType.INFO);
			alert.setTimeout(3000);
			display.setCurrent(alert, mnuPurchase);
			mnuPurchase.doLogin();		
		} catch (IOException e){
			e.printStackTrace();
		}
	}

	protected void pauseApp() {
	}

	protected void destroyApp(boolean arg0) throws MIDletStateChangeException {
	}
}