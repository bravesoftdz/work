package com.mainretail.handheld.purchase;


import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;

import com.mainretail.handheld.PessoaService;
import com.mainretail.util.KeyValueParser;
import com.mainretail.util.Util;

public class PurchaseService {
	
	public static Hashtable toHashtable(Purchase purchase)
	{
		Hashtable hashpurchase = new Hashtable();
		
		String strObj;
		
		strObj = "PU.";
		
		if (purchase.vendor != null){
			Hashtable htPessoa = PessoaService.pessoaToHashtable(purchase.vendor, "vendor.");
			for (Enumeration enumPessoa = htPessoa.keys(); enumPessoa.hasMoreElements();){
				String key = (String)enumPessoa.nextElement();
				hashpurchase.put(strObj + key, String.valueOf((String)htPessoa.get(key)));
			}
		}
				
		if (purchase.idpurchase != 0) {
			hashpurchase.put(strObj + "idpurchase", String.valueOf(purchase.idpurchase));
		}
		
		if (purchase.idstore != 0) {
			hashpurchase.put(strObj + "idstore", String.valueOf(purchase.idstore));
		}
		
		if (purchase.iduserprereceiving != 0) {
			hashpurchase.put(strObj + "iduserprereceiving", String.valueOf(purchase.iduserprereceiving));
		}
		
		if (purchase.idpo != 0) {
			hashpurchase.put(strObj + "idpo", String.valueOf(purchase.idpo));
		}
		
		if (purchase.documenttype != null) {
			hashpurchase.put(strObj + "documenttype", Util.encodeURL(purchase.documenttype));
		}
		
		if (purchase.documentnumber != null) {
			hashpurchase.put(strObj + "documentnumber", Util.encodeURL(purchase.documentnumber));
		}
		
		if (purchase.freight != 0) {
			hashpurchase.put(strObj + "freight", String.valueOf(purchase.freight));
		}

		if (purchase.othercharges != 0) {
			hashpurchase.put(strObj + "othercharges", String.valueOf(purchase.othercharges));
		}
		
		if (purchase.subtotal != 0) {
			hashpurchase.put(strObj + "subtotal", String.valueOf(purchase.subtotal));
		}
		
		if (purchase.dateprereceiving != null) {
			hashpurchase.put(strObj + "dateprereceiving", String.valueOf(purchase.dateprereceiving.getTime()));
		}

		if (purchase.documentdate != null) {
			hashpurchase.put(strObj + "documentdate", String.valueOf(purchase.documentdate.getTime()));
		}
		
		if (purchase.documentduedate != null) {
			hashpurchase.put(strObj + "documentduedate", String.valueOf(purchase.documentduedate.getTime()));
		} 
		
		if (purchase.datefinalreceiving != null) {
			hashpurchase.put(strObj + "datefinalreceiving", String.valueOf(purchase.datefinalreceiving.getTime()));
		}
		
		return hashpurchase;
	}
	
	public static Purchase toPurchase(Hashtable ht) {
		Purchase purchase = new Purchase();
		
		String query = Util.hashtableToQuery(ht);
		
		String strObj = "PU.";
		
		// Pessoa
		if (query.indexOf(strObj + "vendor.") >= 0){
			purchase.vendor = PessoaService.hashTableToPessoa(ht, strObj, "vendor.");
		}
		
		query = null;
		
		System.gc();
		
		if (ht.containsKey(strObj + "idpurchase")) {
			purchase.idpurchase = Integer.parseInt((String)ht.get(strObj + "idpurchase"));
		}

		if (ht.containsKey(strObj + "idstore")) {
			purchase.idstore = Integer.parseInt((String)ht.get(strObj + "idstore"));
		} 
		
		if (ht.containsKey(strObj + "iduserprereceiving")) {
			purchase.iduserprereceiving = Integer.parseInt((String)ht.get(strObj + "iduserprereceiving"));
		}
		
		if (ht.containsKey(strObj + "idpo")) {
			purchase.idpo = Integer.parseInt((String)ht.get(strObj + "idpo"));
		}
		
		if (ht.containsKey(strObj + "documenttype")) {
			purchase.documenttype = Util.decodeURL((String)ht.get(strObj + "documenttype"));
		}
		 
		if (ht.containsKey(strObj + "documentnumber")) {
			purchase.documentnumber = Util.decodeURL((String)ht.get(strObj + "documentnumber"));
		}

		if (ht.containsKey(strObj + "freight")) {
			purchase.freight = Double.parseDouble((String)ht.get(strObj + "freight"));
		}
		
		if (ht.containsKey(strObj + "othercharges")) {
			purchase.othercharges = Double.parseDouble((String)ht.get(strObj + "othercharges"));
		}
		
		if (ht.containsKey(strObj + "subtotal")) {
			purchase.subtotal = Double.parseDouble((String)ht.get(strObj + "subtotal"));
		}

		if (ht.containsKey(strObj + "dateprereceiving")) {
			purchase.dateprereceiving = new Date(Long.parseLong((String)ht.get(strObj + "dateprereceiving")));
		}
		
		if (ht.containsKey(strObj + "documentdate")) {
			purchase.documentdate = new Date(Long.parseLong((String)ht.get(strObj + "documentdate")));
		}
		
		if (ht.containsKey(strObj + "documentduedate")) {
			purchase.documentduedate = new Date(Long.parseLong((String)ht.get(strObj + "documentduedate")));
		} 
		
		if (ht.containsKey(strObj + "datefinalreceiving")) {
			purchase.datefinalreceiving = new Date(Long.parseLong((String)ht.get(strObj + "datefinalreceiving")));
		}

		strObj = null;
		
		return purchase;
   }

   public static String toQueryString(Purchase purchase)  {
	   Hashtable ht = toHashtable(purchase);
	   return Util.hashtableToQuery(ht);	
   } 

   
   
   public static Purchase toPurchase(String query) {
	   Purchase purchase = new Purchase();
		
	   //String query = Util.hashtableToQuery(ht);
		
	   KeyValueParser ht = new KeyValueParser();
	   String strObj = "PU.";
	
	   // Pessoa
	   if (query.indexOf(strObj + "vendor.") >= 0){
			purchase.vendor = PessoaService.hashTableToPessoa(query, strObj, "vendor.");
	   }
		
	   //query = null;
		
		System.gc();
		
		if (ht.containsKey(query, strObj + "idpurchase")) {
			purchase.idpurchase = Integer.parseInt((String)ht.get());
		}
		
		if (ht.containsKey(query, strObj + "idstore")) {
			purchase.idstore = Integer.parseInt((String)ht.get());
		} 
		
		if (ht.containsKey(query, strObj + "iduserprereceiving")) {
			purchase.iduserprereceiving = Integer.parseInt((String)ht.get());
		}
		
		if (ht.containsKey(query, strObj + "idpo")) {
			purchase.idpo = Integer.parseInt((String)ht.get());
		}
		
		if (ht.containsKey(query, strObj + "documenttype")) {
			purchase.documenttype = Util.decodeURL((String)ht.get());
		}
		 
		if (ht.containsKey(query, strObj + "documentnumber")) {
			purchase.documentnumber = Util.decodeURL((String)ht.get());
		}
		
		if (ht.containsKey(query, strObj + "freight")) {
			purchase.freight = Double.parseDouble((String)ht.get());
		}
		
		if (ht.containsKey(query, strObj + "othercharges")) {
			purchase.othercharges = Double.parseDouble((String)ht.get());
		}
		
		if (ht.containsKey(query, strObj + "subtotal")) {
			purchase.subtotal = Double.parseDouble((String)ht.get());
		}
		
		if (ht.containsKey(query, strObj + "dateprereceiving")) {
			purchase.dateprereceiving = new Date(Long.parseLong((String)ht.get()));
		}
		
		if (ht.containsKey(query, strObj + "documentdate")) {
			purchase.documentdate = new Date(Long.parseLong((String)ht.get()));
		}
		
		if (ht.containsKey(query, strObj + "documentduedate")) {
			purchase.documentduedate = new Date(Long.parseLong((String)ht.get()));
		} 
		
		if (ht.containsKey(query, strObj + "datefinalreceiving")) {
			purchase.datefinalreceiving = new Date(Long.parseLong((String)ht.get()));
		}
		
		strObj = null;
		
		return purchase;
   }

}
