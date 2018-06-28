package com.mainretail.handheld;

import java.util.Hashtable;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.TextField;
import javax.microedition.midlet.MIDlet;

import com.mainretail.util.ErrorAlert;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.ParentForm;
import com.mainretail.util.SendingForm2;

public class FormLogin extends ParentForm implements HttpEventListener {
    
	private TextField txtPW;
	
	public static final String SVLLOGIN = "/userlogin";	
		
	public FormLogin() {
		super();
		txtPW = new TextField("Password","",10,TextField.PASSWORD); 
						
	}
	
	public void refresh(){
		deleteAll();
		append(txtPW);
		defaultValues();
	}
	
	public void defaultValues(){
		
		txtPW.setString("");
		getDisplay().setCurrentItem(txtPW); 
	}

	public void onSelect(Displayable d) {
		if (!txtPW.getString().trim().equals("")){
			loginUser();
		}
		
	}
	
	public void initForm(){
		super.initForm();						
		refresh();
	}
	
	private void loginUser(){
  		
		System.out.println(txtPW.toString());
		
		User user = new User();
		user.pw = txtPW.getString(); 
		  		
		Hashtable ht = UserService.toHashtable(user);														
		
		send(ht);
	}	

	
	private void send(Hashtable ht) {
		try {
			Hashtable parameters = ht;
			HttpConnectionHC httpConnectionHC = new HttpConnectionHC(Config.getInstance().getUrl(FormLogin.SVLLOGIN), parameters, HttpConnection.GET);
			SendingForm2 sending = new SendingForm2(getDisplay(), getCaller(), httpConnectionHC, this);
			sending.start();
			getDisplay().setCurrent(sending);
		} catch (Throwable e) {
			ErrorAlert.getInstance().showError(getDisplay(), getCaller(), e);
		}

	}	
	
	
	public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable error) {		
		((HttpEventListener)getObjects().get("EVENTHANDLER")).httpEvent(status, connectionHC, error);
	}

	public void onExit() {
		((MIDlet)getObjects().get("MIDLET")).notifyDestroyed();
	}

}
