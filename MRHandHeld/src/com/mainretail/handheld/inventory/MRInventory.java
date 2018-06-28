package com.mainretail.handheld.inventory;

import java.io.IOException;

import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Image;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;

import com.mainretail.handheld.debug.LogDAO;
import com.mainretail.handheld.debug.SystemException;

public class MRInventory extends MIDlet {
	
	private Display display;	
	private InventoryMenu mnuInventory;
	
	public MRInventory() {
		super();
	}

	protected void startApp() throws MIDletStateChangeException {
		display = Display.getDisplay(this);
		mnuInventory = new InventoryMenu("Inventory", display, this, new Class[]{FormInvCycleCount.class, FormInvPhysicalCount.class, FormInvLiveCount.class, FormInvStartUpCount.class, FormBarcodePrint.class }, new String[]{"Cycle Count", "Physical Count", "Live Count", "StartUp Count", "Barcode Print Request" }, new String[]{"/cycle.png", "/barcode.png", "/live.png", "/startup.png", "/barcode_print.png"});						
				
		Alert alert;
		try {
			alert = new Alert("MainRetail" , null, Image.createImage("/mr.png"), AlertType.INFO);
			alert.setTimeout(3000);
			//display.setCurrent(alert, mnuInventory);		
			display.setCurrent(alert);
			mnuInventory.doLogin();
		} catch (IOException e){
			//display.setCurrent(mnuInventory);
			e.printStackTrace();
		}
	}

	protected void pauseApp() {
	}

	protected void destroyApp(boolean arg0) throws MIDletStateChangeException {
		try {
			LogDAO.getInstance().closeRecordStore();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
			
	
}