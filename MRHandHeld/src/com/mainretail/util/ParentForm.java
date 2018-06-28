package com.mainretail.util;
import java.util.Hashtable;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.TextField;

import org.zaval.lw.event.LwActionListener;

import com.mainretail.handheld.Config;
import com.mainretail.handheld.User;
import com.mainretail.handheld.debug.Log;

public abstract class ParentForm extends Form implements CommandListener, InitialInfo, LwActionListener{
	private Display display;
	private Displayable caller;
	private Hashtable objects;
	private User user;
	private Command confirmButtom;
	private Command backButtom;
	
	public ParentForm() {
		super("");
		confirmButtom = new Command(getConfirmButtomName(), Command.OK, 1);
		backButtom = new Command("Back", Command.BACK, 1);
	}
	
	public abstract void onSelect(Displayable d);
	
	public String getConfirmButtomName(){
		return new String("Save");
	}

	public void initForm(){
		
		addCommand(confirmButtom);
		addCommand(backButtom);
		setCommandListener(this);
	}

	public void commandAction(Command c, Displayable d) {
		processCommand(c, d);
	}
	
	public void processCommand(Command c, Displayable d) {
		switch (c.getCommandType()) {
			case Command.BACK:{
				onExit();
				break;
			}
			case Command.OK:
			case Command.SCREEN:{
				onSelect(d); 
				break;
			}
		}
	}
	
		
	public Display getDisplay(){
		return display;
	}
	
	public Displayable getCaller(){	
		return caller;
	}
	
	public void setInfo(String title, Display display, Displayable caller, String image) {
		this.caller = caller;
		this.display = display;
		
		
		setTitle(title);
		/*if (image != null)
			try {
				append(new ImageItem(null, Image.createImage(image), Item.LAYOUT_TOP, null, Item.PLAIN));
			} catch (IOException e) {			
				e.printStackTrace();
			}*/
		initForm();
	}

	public void defaultValues(){		
		
	}

	public void refresh() {		
		
	}
	
	public void onExit(){
		beforeExit();
		display.setCurrent(caller);
		System.gc();
	}

	public void beforeExit() {
	}

	public Hashtable getObjects() {
		return objects;
	}	
	
	public void setObjects(Hashtable objects) {		
		this.objects = objects;
		setUser((User)objects.get("USER"));
	}
	
	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}
	
	public void send(String servlet, Hashtable ht, HttpEventListener listener) {
		Log.getInstance().log("FormQtyVerifyResult.enviar() - Inicio");
		try {
			HttpConnectionHC httpConnectionHC = new HttpConnectionHC(Config.getInstance().getUrl(servlet), ht, HttpConnection.POST);
			SendingForm2 sendingForm = new SendingForm2(getDisplay(), this, httpConnectionHC, listener);
			getDisplay().setCurrent(sendingForm);
			sendingForm.start();
			sendingForm = null;
			
		} catch (Throwable e) {
			Log.getInstance().log("FormQtyVerifyResult.enviar() - Erro");
			ErrorAlert.getInstance().showError(getDisplay(), this, e);
		}
		Log.getInstance().log("FormQtyVerifyResult.enviar() - Fim");
		
	}

	public Command getConfirmButtom() {
		return confirmButtom;
	}

	public void setConfirmButtom(Command confirmButtom){
		this.confirmButtom = confirmButtom;
	}
	
	public int getItemIsShowing(Item item){
		int result = -1;
		
		for(int i = 0; i < this.size(); i++ ){
			if (this.get(i).equals(item)){
				result = i;
				break;
			}
		}
		
		return result;
	}

	public Command getBackButtom() {
		return backButtom;
	}

	public void setBackButtom(Command backButtom) {
		this.backButtom = backButtom;
	}
	
	public double nullField(TextField t, double n) {
		if ((t.getString() == null) || t.getString().trim().equals("")) {
			return n;
		}
		else
			return Double.parseDouble(t.getString());
	}
	
	
	public void waitTaskReturn(long time) {
		try {
			Thread.sleep(time);
		} catch (InterruptedException e) {		
		}
	}
	
	
	public void actionPerformed(Object src, Object data) {
		lwActionListenerCallback(src, data);
	}
	
	public void lwActionListenerCallback(Object src, Object data) {
		
	}
}
