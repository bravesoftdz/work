package com.mainretail.util;

import java.io.IOException;
import java.util.Hashtable;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Image;
import javax.microedition.lcdui.List;
import javax.microedition.midlet.MIDlet;

import com.mainretail.handheld.Config;
import com.mainretail.handheld.FormLogin;
import com.mainretail.handheld.ParameterList;
import com.mainretail.handheld.ParameterListService;
import com.mainretail.handheld.User;
import com.mainretail.handheld.UserService;

public class ParentMenu extends List implements CommandListener{
	
	private Display display;
	private MIDlet caller;
	private Class[] forms;
	private String[] titles;
	private String[] images;
	private FormLogin formLogin = null;
	private User user;
	//private Object selectedForm = null;
	private Hashtable infoTable;
	private InsuranceEvent insuranceEvent;
	
	private ParentMenu getParentMenu(){
		return this;
	}
	
	private class InsuranceEvent implements HttpEventListener{
		public InsuranceEvent(){
			
		}
		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable error) {
		try {
				
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{			
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{														
						String reply = new String(connectionHC.getResponse());
						
			  			user = UserService.toUser(Util.queryToHashtable(reply));
			  			ParameterList parameterList = ParameterListService.queryStringToParameterList(reply);
			  			Config.getInstance().removeBarcodeDigit = Integer.valueOf((String)parameterList.getObjectValueAt(ParameterList.PARAM_REMOVE_BARCODE_DIGIT)).intValue();
			  			parameterList = null;
			  			
			  			System.gc();
			  			
			  			getDisplay().setCurrent(getParentMenu());
					
					} else {
						
						String msg = connectionHC.getResponseMessage() ;
						if (msg == null)
						{
							msg = "";
						}
						
						ErrorAlert.getInstance().showError(getDisplay(), formLogin,
								String.valueOf(responseCode)+ " " + msg);
						
					}
				}
				else if (status==HttpEventListener.STATUS_ERROR)
				{
					
					ErrorAlert.getInstance().showError(getDisplay(), formLogin, error);
					
					
				}
				else if (status==HttpEventListener.STATUS_CANCELLED)
				{				
					getDisplay().setCurrent(formLogin);			
				}
				
			} catch (Exception e) {
				ErrorAlert.getInstance().showError(getDisplay(), formLogin, e);			
			}	
		}
	}


	public ParentMenu(String title, Display display, MIDlet caller, 
			          Class[] forms, String[] titles, String[] images) {
		
		super(title, List.IMPLICIT);
		
		insuranceEvent = new InsuranceEvent();
		
		infoTable = new Hashtable();
		
		// Inicializa membros
		this.display = display;
		this.caller = caller;		
		this.titles = titles;
		this.forms = forms;
		this.images = images;
		
		// Inializa menu com os títulos
		for (int i = 0; i < titles.length; i++){
			Image img = null;		
			if (images[i] != null){
				try {
					img = Image.createImage(images[i]);
				} catch (IOException e) {
					System.out.println(e);
				}				
			}
			append(titles[i], img);
		}
		
		// Inicializa botões padrão
		setButtons();
	}
	
	private void setButtons(){
		addCommand(new Command("Start", Command.OK, 1));
		addCommand(new Command("Exit", Command.EXIT, 1));				
		setCommandListener(this);
	}
	
	public void onSelect(Displayable d){
		onValidateForm();		
	}
	
	public void onValidateForm(){
		
	}
	
	
	protected Display getDisplay() {
		return display;
	}

	public void commandAction(Command c, Displayable d) {
		switch (c.getCommandType()) {
			case Command.EXIT:{
				caller.notifyDestroyed();				
				break;
			}
			case (Command.OK ):
			case (Command.SCREEN ):{
				onSelect(d);
				break;
			}
		}
		
	}
		
	
	protected boolean ValidateAccess() {
		return true;
	}
	
	
	public void populateInfoTable(){		
		addInfo("USER", getUser());		
	}
	
	
	
	public void addInfo(Object key, Object value){
		infoTable.put(key, value);
		
	}
	
	public void doLogin(){
		if (formLogin == null){		
			formLogin = new FormLogin();
			formLogin.setInfo("Login", display, this, null);
			Hashtable ht = new Hashtable();
			ht.put("MIDLET", caller);
			ht.put("EVENTHANDLER", insuranceEvent);
			formLogin.setObjects(ht);
		}
		display.setCurrent(formLogin);			
	}
	
	
	/*
	private Object createForm(Class formClass){
		Object object = null;
				
		try {
			
			//Class classeForm = Class.forName(formClassName);

			object =  formClass.newInstance();
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return object;
	}
	*/
	
	
	public User getUser() {
		return user;
	}
	
	public MIDlet getCaller() {
		return caller;
	}


	public FormLogin getFormLogin() {
		return formLogin;
	}
	
	public Class[] getForms() {
		return forms;
	}

	public String[] getImages() {
		return images;
	}

	public String[] getTitles() {
		return titles;
	}

	public Hashtable getInfoTable() {
		return infoTable;
	}
	
}