package com.mainretail.handheld.purchase;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.handheld.PessoaService;
import com.mainretail.util.Util;

public class PurchaseItemService {
	

   
	public static PurchaseItem productToPurchaseItem(Model model){
		
		PurchaseItem purchaseitem = new PurchaseItem();
		purchaseitem.model = model;
				
		return purchaseitem;
	}
	   
	public static Hashtable vectorToHashtable(Vector vector){
		Hashtable hashpurchaseitem = new Hashtable();
		
		PurchaseItem purchaseitem = null;
		int i = 0;
		String strObj;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();)
		{
			i++;
			purchaseitem = (PurchaseItem)en.nextElement();
			strObj = "PUI_" + String.valueOf(i) + ".";
			
			if (purchaseitem.model != null){
				
				Hashtable htModel = ModelService.toHashtable(purchaseitem.model);
				for (Enumeration enumModel = htModel.keys(); enumModel.hasMoreElements();){
					String key = (String)enumModel.nextElement();
					hashpurchaseitem.put(strObj + key, String.valueOf((String)htModel.get(key)));
				}
			}
			
			if (purchaseitem.vendor != null){
				
				Hashtable htPessoa = PessoaService.toHashtable(purchaseitem.vendor);
				for (Enumeration enumPessoa = htPessoa.keys(); enumPessoa.hasMoreElements();){
					String key = (String)enumPessoa.nextElement();
					hashpurchaseitem.put(strObj + key, String.valueOf((String)htPessoa.get(key)));
				}
			}
					
			if (purchaseitem.idpurchaseitem != 0) {
				hashpurchaseitem.put(strObj + "idpurchaseitem", String.valueOf(purchaseitem.idpurchaseitem));
			}
			
			if (purchaseitem.idpurchase != 0) {
				hashpurchaseitem.put(strObj + "idpurchase", String.valueOf(purchaseitem.idpurchase));
			}
			
			if (purchaseitem.idpoitem != 0) {
				hashpurchaseitem.put(strObj + "idpoitem", String.valueOf(purchaseitem.idpoitem));
			}
			
			if (purchaseitem.barcode != null) {
				hashpurchaseitem.put(strObj + "barcode", Util.encodeURL(purchaseitem.barcode));
			}
			
			if (purchaseitem.newcostprice != 0) {
				hashpurchaseitem.put(strObj + "newcostprice", String.valueOf(purchaseitem.newcostprice));
			}
	
			if (purchaseitem.newsaleprice != 0) {
				hashpurchaseitem.put(strObj + "newsaleprice", String.valueOf(purchaseitem.newsaleprice));
			}
			
			if (purchaseitem.newsuggretail != 0) {
				hashpurchaseitem.put(strObj + "newsuggretail", String.valueOf(purchaseitem.newsuggretail));
			}
	
			if (purchaseitem.qty != 0) {
				hashpurchaseitem.put(strObj + "qty", String.valueOf(purchaseitem.qty));
			}
			
			if (purchaseitem.costprice != 0) {
				hashpurchaseitem.put(strObj + "costprice", String.valueOf(purchaseitem.costprice));
			}
			
			if (purchaseitem.freightcost != 0) {
				hashpurchaseitem.put(strObj + "freightcost", String.valueOf(purchaseitem.freightcost));
			}
			
			if (purchaseitem.othercost != 0) {
				hashpurchaseitem.put(strObj + "othercost", String.valueOf(purchaseitem.othercost));
			}
		}
		return hashpurchaseitem;
	}
	
	public static Vector queryStringToVector(String query)   {
			Vector vector = new Vector();
			Hashtable ht = Util.queryToHashtable(query);			
			
			String strObj = null;
 
			int i = 1;
			
			while(query.indexOf(strObj = new String("PUI_" + String.valueOf(i) + ".")) >= 0){
				
				PurchaseItem purchaseitem = new PurchaseItem();
				
				// Model
				if (query.indexOf(strObj + "M.") >= 0){
					purchaseitem.model = ModelService.toModel(ht, strObj);
				}
				
                // Pessoa
				if (query.indexOf(strObj + "P.") >= 0){
					purchaseitem.vendor = PessoaService.hashTableToPessoa(ht, strObj);
				}
				
		    	if (ht.containsKey(strObj + "idpurchaseitem")) {
					purchaseitem.idpurchaseitem = Integer.parseInt((String)ht.get(strObj + "idpurchaseitem"));
				}

				if (ht.containsKey(strObj + "idpurchase")) {
					purchaseitem.idpurchase = Integer.parseInt((String)ht.get(strObj + "idpurchase"));
				}
				
				if (ht.containsKey(strObj + "idpoitem")) {
					purchaseitem.idpoitem = Integer.parseInt((String)ht.get(strObj + "idpoitem"));
				}
				 
				if (ht.containsKey(strObj + "barcode")) {
					purchaseitem.barcode =  Util.decodeURL((String)ht.get(strObj + "barcode"));
				}

				if (ht.containsKey(strObj + "newcostprice")) {
					purchaseitem.newcostprice = Double.parseDouble((String)ht.get(strObj + "newcostprice"));
				}
				
				if (ht.containsKey(strObj + "newsaleprice")) {
					purchaseitem.newsaleprice = Double.parseDouble((String)ht.get(strObj + "newsaleprice"));
				}
				
				if (ht.containsKey(strObj + "newsuggretail")) {
					purchaseitem.newsuggretail = Double.parseDouble((String)ht.get(strObj + "newsuggretail"));
				}
				
				if (ht.containsKey(strObj + "qty")) {
					purchaseitem.qty = Double.parseDouble((String)ht.get(strObj + "qty"));
				}
				
				if (ht.containsKey(strObj + "costprice")) {
					purchaseitem.costprice = Double.parseDouble((String)ht.get(strObj + "costprice"));
				}
				
				if (ht.containsKey(strObj + "freightcost")) {
					purchaseitem.freightcost = Double.parseDouble((String)ht.get(strObj + "freightcost"));
				}
				
				if (ht.containsKey(strObj + "othercost")) {
					purchaseitem.othercost = Double.parseDouble((String)ht.get(strObj + "othercost"));
				}
				
				vector.addElement(purchaseitem);
				
				i++;
			}
			
		   return vector;
	}
	
	public static PurchaseItem toPurchaseItem(Barcode barcode){
		PurchaseItem purchaseitem = new PurchaseItem();
		
		if (barcode != null){
			purchaseitem.model = barcode.model;
			purchaseitem.barcode = barcode.idbarcode;
		} 
		
		return purchaseitem;		
	}

	public static PurchaseItem toPurchaseItem(POItem poItem){
		PurchaseItem purchaseItem = new PurchaseItem();
		
		if (poItem != null){
			purchaseItem.model = poItem.model;				
			purchaseItem.idpoitem = poItem.idpoitem;
			purchaseItem.barcode = poItem.barcode;
			purchaseItem.newcostprice = poItem.costprice;
			purchaseItem.newsaleprice = poItem.saleprice;
			purchaseItem.newsuggretail = poItem.suggretail;
			purchaseItem.qty = poItem.qty - poItem.qtyrealmov;
			purchaseItem.costprice = poItem.costprice;
		} 
		
		return purchaseItem;		
	}
	
	public static String PurchaseItemToString(PurchaseItem PUI) {
		Vector vetTemp = new Vector();
		vetTemp.addElement(PUI);
		
		Hashtable ht = vectorToHashtable(vetTemp);
		
		return Util.hashtableToQuery(ht);
	}
	
	public static PurchaseItem StringToPurchaseItem(String query) {
		Vector vetTemp = queryStringToVector(query);
		return (PurchaseItem)vetTemp.elementAt(0);
	}

}


