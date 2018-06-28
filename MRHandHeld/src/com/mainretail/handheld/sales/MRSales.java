package com.mainretail.handheld.sales;

import java.io.IOException;

import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Image;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;

import org.zaval.lw.LwToolkit;

public class MRSales extends MIDlet {
	
	private Display display;	
	private SalesMenu mnuSales;
	
	public MRSales() {
		super();
	}

	protected void startApp() throws MIDletStateChangeException {
		display = Display.getDisplay(this);
		
		if (count == 0)
		  LwToolkit.startVCL(null);
		
		count++;
		
		mnuSales = new SalesMenu("Sales", display, this, new Class[]{FormFastSale.class}, new String[]{"Fast Sale"}, new String[]{"/fastsale.png"});
				
		Alert alert;
		try {
			alert = new Alert("MainRetail" , null, Image.createImage("/mr.png"), AlertType.INFO);
			alert.setTimeout(2000);
			display.setCurrent(alert, mnuSales);
			mnuSales.doLogin();		
		} catch (IOException e){
			display.setCurrent(mnuSales);
			e.printStackTrace();
		}
	}

	protected void pauseApp() {
	}

	protected void destroyApp(boolean arg0) throws MIDletStateChangeException {
		count--;
	    if (count == 0) LwToolkit.stopVCL();
	}
	
	private static int count = 0;
}