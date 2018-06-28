package com.mainretail.handheld.serverconfiguration;

import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.TextField;
import javax.microedition.midlet.MIDlet;
import javax.microedition.rms.RecordStoreException;

import com.mainretail.handheld.Config;
import com.mainretail.util.ParentForm;

public class FormServerConfiguration extends ParentForm {
	
	private TextField host;
	private TextField upcSufix;
	private TextField store;
	private ChoiceGroup saveLog;
			
	public FormServerConfiguration() {
		super();
		host = new TextField("Host", null, 15, TextField.ANY);
		upcSufix = new TextField("UPC Sufix", null, 1, TextField.ANY);
		store = new TextField("Store #", null, 5, TextField.NUMERIC);
		saveLog = new ChoiceGroup("", ChoiceGroup.MULTIPLE, new String[] {"SaveLog"}, null); 
	}

	public void refresh(){
		append(host);
		append(upcSufix);
		append(store);
		append(saveLog);
		defaultValues();
	}
	
	public void defaultValues(){
		host.setString(Config.getInstance().urlHost);
		upcSufix.setString(Config.getInstance().upcSufix);
		store.setString(Config.getInstance().store);
		
		if (Config.getInstance().saveLog) 
			saveLog.setSelectedIndex(0,true);
		else	
			saveLog.setSelectedIndex(0,false);
			
		getDisplay().setCurrentItem(host); 
	}
	
	public void initForm(){
		super.initForm();						
		refresh();
	}
	
	public void onSelect(Displayable d) {		
				
		try {
			Config.getInstance().urlHost = host.getString();
			Config.getInstance().upcSufix = upcSufix.getString();
			Config.getInstance().store = store.getString();
			
			if (saveLog.isSelected(0))
				Config.getInstance().saveLog = true;
			else
				Config.getInstance().saveLog = false;
			
			Config.getInstance().save();
			onExit();
		} catch (RecordStoreException e) {
			e.printStackTrace();
		}
	}

	public void onExit() {
		((MIDlet)getObjects().get("MIDLET")).notifyDestroyed();
	}
	
	

}