package com.mainretail.handheld.sales;

import java.util.Hashtable;

import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.TextField;

import com.mainretail.util.ErrorAlert;
import com.mainretail.util.ParentForm;

public class FormEditPreSaleItem extends ParentForm {
	
	private PreSaleItem preSaleItem;
	
	private TextField model = null;
	private TextField qty = null;
	private TextField saleprice = null;
	private boolean isInsert;

	public FormEditPreSaleItem() {		
		super();
		model = new TextField(null, null, 50, TextField.ANY | TextField.UNEDITABLE);
		qty = new TextField("Qty", null, 10, TextField.DECIMAL);
		saleprice = new TextField("Sale Price", null, 8, TextField.DECIMAL | TextField.UNEDITABLE);
	}

	public void defaultValues() {		
		model.setString(preSaleItem.model.description);
		qty.setString(String.valueOf(preSaleItem.qty));
		saleprice.setString(String.valueOf(preSaleItem.saleprice));
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
		append(saleprice);
	}
	
	public void setObjects(Hashtable objects) {
		super.setObjects(objects);
		preSaleItem = (PreSaleItem)getObjects().get("PSI");
		isInsert = ((Boolean)getObjects().get("ISINSERT")).booleanValue();		
	}	


	public void onSelect(Displayable d) {
		if (validateItem()){
			preSaleItem.qty = nullField(qty, 1);
			preSaleItem.saleprice = Double.valueOf(saleprice.getString()).doubleValue();
			getDisplay().setCurrent(getCaller());
			if (getCaller() instanceof FormFastSale){
				FormFastSale formFastSale = (FormFastSale)getCaller();
				if (isInsert){
					formFastSale.getVetPreSaleItem().insertElementAt(preSaleItem, 0);
				}
				formFastSale.refreshComponentArray();
			}
		}
	}
	
	private boolean validateItem(){
		String msg = "";
		
		try{
			//if (qty.getString().trim().equals("") || (Double.parseDouble(qty.getString()) == 0)) {
			//	msg = "Quantity must be greater ZERO.";
			//}			
			if (saleprice.getString().trim().equals("") || (Double.parseDouble(saleprice.getString()) == 0) ) {
				msg = "Sale Price must be greater ZERO.";
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
