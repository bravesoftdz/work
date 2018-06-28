package com.mainretail.handheld.purchase;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.microedition.io.HttpConnection;
import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.ItemStateListener;
import javax.microedition.lcdui.Spacer;
import javax.microedition.lcdui.TextField;

import com.mainretail.handheld.Config;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.debug.Log;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.HttpConnectionHC;
import com.mainretail.util.HttpEventListener;
import com.mainretail.util.ParentForm;
import com.mainretail.util.TextFieldObject;

public class FormRequest extends ParentForm {
	
	private final static String SVLREQUESTINSERT = "/requestinsert";
	
	private Vector vetRequest = null;

	private TextField barcode = null;
	private TextField qty = null; 
	private Spacer spacerBarcode = null;
	private ChoiceGroup lista = null;
	
	private Command deleteButtom = null;
	private Command findBarcodeButtom = null;
	
	private EventInsertRequest eventInsertRequest;

	public FormRequest() {
		super();
		vetRequest = new Vector();
		lista = new ChoiceGroup("", ChoiceGroup.EXCLUSIVE);
		
		barcode = new TextFieldObject("Barcode", null, 30, TextField.ANY, null);
		spacerBarcode = new Spacer(50, 5);
				
		findBarcodeButtom = new Command("Add", Command.OK, 2);
		deleteButtom = new Command("Delete", Command.OK, 3);
		
		eventInsertRequest = new EventInsertRequest(this);
		
		qty = new TextField("Quantity", null, 10, TextField.DECIMAL);
		
		setAnonymousItemStateListener();
	}
	
	public void defaultValues() {
		barcode.setString("");
		qty.setString("");
		refreshComponentArray();
	}
	
	public void refresh() {
		deleteAll();
		append(barcode);
		append(qty);
		append(spacerBarcode);
		append(lista);
		refreshComponentArray();
		defaultValues();
	}
	
	private void refreshButtons() {
		removeCommand(getConfirmButtom());
		removeCommand(deleteButtom);
		if (!vetRequest.isEmpty()){
			addCommand(getConfirmButtom());
			addCommand(deleteButtom);
		}		
	}

	public void initForm() {
		super.initForm();
		addCommand(findBarcodeButtom);
		refresh();
	}


	public void onSelect(Displayable d) {
		Hashtable ht = RequestService.vectorToHashtable(vetRequest);		
		send(SVLREQUESTINSERT, ht, eventInsertRequest);
	}
	
	private void setAnonymousItemStateListener(){
		this.setItemStateListener(new 
				ItemStateListener(){
					public void itemStateChanged(Item item) {		
						if (item instanceof TextField) {
							TextField textFiled = (TextField)item; 
							int i = textFiled.getString().indexOf(Config.getInstance().upcSufix);
							if (i > 0){
								textFiled.setString(textFiled.getString().substring(0, i));
								endBarcodeScan();
							}
						}
					}
				}
			);
	}
	
	public void endBarcodeScan(){
		getDisplay().setCurrentItem(qty);
	}
	
	public void refreshComponentArray(){
		lista.deleteAll();	
		for (Enumeration en = vetRequest.elements(); en.hasMoreElements();){
			Request request =(Request)en.nextElement();
			lista.append(request.model.barcode + " x " + request.qtyreq + '\n'+ '\n' + '\n',
						null);		
		}
		refreshButtons();
		getDisplay().setCurrentItem(barcode);		
	}

	public void commandAction(Command c, Displayable d) {
		switch (c.getCommandType()) {
		case Command.BACK:{
			onExit();
			break;
		}
		case Command.OK:
		case Command.SCREEN:{
			int i = lista.getSelectedIndex();			
			switch (c.getPriority()) {
			case 1:{				
				onSelect(d);
				break;
			}
			case 2:{
				if (validateRequest()) {
					Model model = new Model();
					model.barcode = barcode.getString();
					
					Request request = RequestService.toRequest(model);
					request.storeid = Integer.parseInt(Config.getInstance().store);
					request.userid = getUser().iduser;
					
					request.qtyreq = nullField(qty, 1);
					
					vetRequest.addElement(request);
					refresh();
				}

				break;
			}
			case 3:{
				if (i >= 0) {
					vetRequest.removeElementAt(i);
					refresh();
				}

				break;
			}
			}
			 
			break;
		}
		
	}

	}
	
	
	private class EventInsertRequest implements HttpEventListener{
		
		private com.mainretail.handheld.purchase.FormRequest owner;
		
		public EventInsertRequest(com.mainretail.handheld.purchase.FormRequest owner){
			this.owner = owner;
		}

		public void httpEvent(int status, HttpConnectionHC connectionHC, Throwable erro) {
			try {
				if (status==HttpEventListener.STATUS_CONCLUDED )
				{
					int responseCode = connectionHC.getResponseCode();
					if (responseCode == HttpConnection.HTTP_OK) 
					{
						Log.getInstance().log("FormRequest.EventInsertRequest HTTP_OK - Inicio");
						owner.getDisplay().setCurrent(owner);
						Log.getInstance().log("FormRequest.EventInsertRequest HTTP_OK - Fim");
						vetRequest.removeAllElements();
						owner.refresh();						
																		
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
	
	private boolean validateRequest(){
		String msg = "";
		
		try{
			
			if (barcode.getString().trim().equals("")) {
				msg = "You must fill Barcode field.";
			}			
			//else if (qty.getString().trim().equals("") || (Double.parseDouble(qty.getString()) == 0)) {
			//	msg = "Quantity must be greater ZERO.";
			//}
			
		}
		catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);	
		
		return msg.equals("");
		
	}


}
