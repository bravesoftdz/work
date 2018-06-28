package com.mainretail.handheld.purchase;

import java.util.Hashtable;

import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.TextField;

import com.mainretail.util.ErrorAlert;
import com.mainretail.util.ParentForm;

public class FormEditPurchaseItem extends ParentForm {
	
	private PurchaseItem purchaseItem;
	
	private TextField model = null;
	private TextField qty = null;
	private TextField costprice = null;
	private TextField saleprice = null;
	private TextField suggretail = null;

	public FormEditPurchaseItem() {		
		super();
		model = new TextField(null, null, 50, TextField.ANY | TextField.UNEDITABLE);
		qty = new TextField("Qty", null, 10, TextField.DECIMAL);
		costprice = new TextField("Cost Price", null, 10, TextField.DECIMAL);
		saleprice = new TextField("Selling Price", null, 10, TextField.DECIMAL);
		suggretail = new TextField("Sugg Retail", null, 10, TextField.DECIMAL);
	}

	public void defaultValues() {		
		model.setString(purchaseItem.model.description);
		qty.setString(String.valueOf(purchaseItem.qty));
		costprice.setString(String.valueOf(purchaseItem.newcostprice));
		saleprice.setString(String.valueOf(purchaseItem.newsaleprice));
		suggretail.setString(String.valueOf(purchaseItem.newsuggretail));		
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
		append(costprice);
		append(saleprice);
		append(suggretail);		
	}
	
	public void setObjects(Hashtable objects) {
		super.setObjects(objects);
		purchaseItem = (PurchaseItem)getObjects().get("PUI");
	}	


	public void onSelect(Displayable d) {
		if (validateItem()){
			purchaseItem.qty = nullField(qty, 1);
			purchaseItem.newcostprice = Double.valueOf(costprice.getString()).doubleValue();
			purchaseItem.newsaleprice = Double.valueOf(saleprice.getString()).doubleValue();
			purchaseItem.newsuggretail = Double.valueOf(suggretail.getString()).doubleValue();		
			getDisplay().setCurrent(getCaller());
			if (getCaller() instanceof FormPurchaseItemList){
				FormPurchaseItemList formPurchaseItemList = (FormPurchaseItemList)getCaller(); 
				formPurchaseItemList.refreshComponentArray();
			}
		}
	}
	
	private boolean validateItem(){
		String msg = "";
		
		try{
			//if (qty.getString().trim().equals("") || (Double.parseDouble(qty.getString()) == 0)) {
			//	msg = "Quantity must be greater ZERO.";
			//}			
			if (costprice.getString().trim().equals("") || (Double.parseDouble(costprice.getString()) == 0) ) {
				msg = "Cost Price must be greater ZERO.";
			}
			else if (saleprice.getString().trim().equals("") || (Double.parseDouble(saleprice.getString()) == 0) ) {
				msg = "Sale Price must be greater ZERO.";
			}
			else if (suggretail.getString().trim().equals("")) {
				msg = "Sugg Price is empty.";
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
