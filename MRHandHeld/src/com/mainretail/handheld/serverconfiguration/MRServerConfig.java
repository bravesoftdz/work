package com.mainretail.handheld.serverconfiguration;

import java.util.Hashtable;

import javax.microedition.lcdui.Display;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;

public class MRServerConfig extends MIDlet {
	private Display display;	
	private FormServerConfiguration formServerConfiguration;
	
	public MRServerConfig() {
		super();
	}

	protected void startApp() throws MIDletStateChangeException {
		display = Display.getDisplay(this);
		formServerConfiguration = new FormServerConfiguration();
		formServerConfiguration.setInfo("Configuration", display, null, "/config.png");
		Hashtable ht = new Hashtable();
		ht.put("MIDLET", this);
		formServerConfiguration.setObjects(ht);
		display.setCurrent(formServerConfiguration);
	}

	protected void pauseApp() {
	}

	protected void destroyApp(boolean arg0) throws MIDletStateChangeException {
	}
}
