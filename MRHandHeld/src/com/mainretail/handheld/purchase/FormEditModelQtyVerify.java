package com.mainretail.handheld.purchase;

import java.util.Hashtable;

import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.TextField;

import com.mainretail.handheld.ModelVerifyQty;
import com.mainretail.util.ErrorAlert;
import com.mainretail.util.ParentForm;

public class FormEditModelQtyVerify extends ParentForm {
	
	private ModelVerifyQty modelVerifyQty;
	private int mqvIndex;
	
	private TextField model = null;
	private TextField qty = null;
	private TextField qtyVerified = null;
	private TextField qtyNotify = null;
	
	public FormEditModelQtyVerify() {		
		super();
		model = new TextField(null, null, 50, TextField.ANY | TextField.UNEDITABLE);
		qty = new TextField("Qty", null, 10, TextField.DECIMAL | TextField.UNEDITABLE);
		qtyVerified = new TextField("Qty Verified", null, 10, TextField.DECIMAL | TextField.UNEDITABLE);
		qtyNotify = new TextField("Qty Notify", null, 10, TextField.DECIMAL);
	}
	
	public void defaultValues() {		
		model.setString(modelVerifyQty.model.model);
		qty.setString(String.valueOf(modelVerifyQty.qty));
		qtyVerified.setString(String.valueOf(modelVerifyQty.qtyVerified));
		qtyNotify.setString("");
		getDisplay().setCurrentItem(qtyNotify);
	}
	
	public void initForm() {
		super.initForm();
		refresh();
		defaultValues();
	}
	
	public void refresh() {
		deleteAll();
		append(model);
		append(qty);
		append(qtyVerified);
		append(qtyNotify);		
	}
	
	public void setObjects(Hashtable objects) {
		super.setObjects(objects);
		modelVerifyQty = (ModelVerifyQty)getObjects().get("MVQ");
		mqvIndex = ((Integer)getObjects().get("MVQIDX")).intValue();
	}	
	
	
	public void onSelect(Displayable d) {
		if (validateItem()){
			modelVerifyQty.qtyVerified = modelVerifyQty.qtyVerified + nullField(qtyNotify, 1);
			
			getDisplay().setCurrent(getCaller());
			if (getCaller() instanceof FormImportPurchaseItemList){
				FormImportPurchaseItemList formImportPurchaseItemList = (FormImportPurchaseItemList)getCaller();
				formImportPurchaseItemList.setRSItem(mqvIndex, modelVerifyQty);
				formImportPurchaseItemList.refreshComponentArray();
			}
		}
	}
	
	private boolean validateItem(){
		String msg = "";
		
		try{		
			if (qtyNotify.getString().trim().equals("") || (Double.parseDouble(qtyVerified.getString()) < 0) ) {
				msg = "Qty notified must be greater ZERO.";
			}			
		}
		catch(Throwable t){
			msg = t.getMessage();
		}
		
		if (!msg.equals(""))
			ErrorAlert.getInstance().showError(getDisplay(), this, msg);	
		
		return msg.equals("");
	} 
	
}



