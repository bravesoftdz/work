package com.mainretail.handheld.sales;

import java.util.Date;
import java.util.Hashtable;

import com.mainretail.util.Util;

public class InvoiceService {
	
	public static Hashtable toHashtable(Invoice invoice)
	{
		Hashtable hashinvoice = new Hashtable();
		
		String strObj;
		
		strObj = "IN.";
		
		if (invoice.idpresale != 0) {
			hashinvoice.put(strObj + "idpresale", String.valueOf(invoice.idpresale));
		}
		
		if (invoice.idcustomer != 0) {
			hashinvoice.put(strObj + "idcustomer", String.valueOf(invoice.idcustomer));
		}
		
		if (invoice.idtouristgroup != 0) {
			hashinvoice.put(strObj + "idtouristgroup", String.valueOf(invoice.idtouristgroup));
		}
		
		if (invoice.idmedia != 0) {
			hashinvoice.put(strObj + "idmedia", String.valueOf(invoice.idmedia));
		}
		
		if (invoice.iddelivertype != 0) {
			hashinvoice.put(strObj + "iddelivertype", String.valueOf(invoice.iddelivertype));
		}
		
		if (invoice.idothercommission != 0) {
			hashinvoice.put(strObj + "idothercommission", String.valueOf(invoice.idothercommission));
		}
		
		if (invoice.idstore != 0) {
			hashinvoice.put(strObj + "idstore", String.valueOf(invoice.idstore));
		}
		
		if (invoice.firstname != null) {
			hashinvoice.put(strObj + "firstname", Util.encodeURL(invoice.firstname));
		}
		
		if (invoice.lastname != null) {
			hashinvoice.put(strObj + "lastname", Util.encodeURL(invoice.lastname));
		}
		
		if (invoice.salecode != null) {
			hashinvoice.put(strObj + "salecode", Util.encodeURL(invoice.salecode));
		}
		
		if (invoice.zip != null) {
			hashinvoice.put(strObj + "zip", Util.encodeURL(invoice.zip));
		}
		
		if (invoice.note != null) {
			hashinvoice.put(strObj + "note", Util.encodeURL(invoice.note));
		}
		
		hashinvoice.put(strObj + "layaway", String.valueOf(invoice.layaway));
		hashinvoice.put(strObj + "printnotes", String.valueOf(invoice.printnotes));
						
		if (invoice.presaledate != null) {
			hashinvoice.put(strObj + "presaledate", String.valueOf(invoice.presaledate.getTime()));
		}

		return hashinvoice;
	}
	
	public static Invoice toInvoice(Hashtable ht) {
		Invoice invoice = new Invoice();
		
		String strObj = "IN.";
		
		if (ht.containsKey(strObj + "idpresale")) {
			invoice.idpresale = Integer.parseInt((String)ht.get(strObj + "idpresale"));
		}

		if (ht.containsKey(strObj + "idcustomer")) {
			invoice.idcustomer = Integer.parseInt((String)ht.get(strObj + "idcustomer"));
		} 
		
		if (ht.containsKey(strObj + "idtouristgroup")) {
			invoice.idtouristgroup = Integer.parseInt((String)ht.get(strObj + "idtouristgroup"));
		}
		
		if (ht.containsKey(strObj + "idmedia")) {
			invoice.idmedia = Integer.parseInt((String)ht.get(strObj + "idmedia"));
		}
		
		if (ht.containsKey(strObj + "iddelivertype")) {
			invoice.iddelivertype = Integer.parseInt((String)ht.get(strObj + "iddelivertype"));
		}
		
		if (ht.containsKey(strObj + "idothercommission")) {
			invoice.idothercommission = Integer.parseInt((String)ht.get(strObj + "idotherCommission"));
		}
		
		if (ht.containsKey(strObj + "idstore")) {
			invoice.idstore = Integer.parseInt((String)ht.get(strObj + "idstore"));
		}
		
		if (ht.containsKey(strObj + "firstname")) {
			invoice.firstname = Util.decodeURL((String)ht.get(strObj + "firstname"));
		}
		
		if (ht.containsKey(strObj + "lastname")) {
			invoice.lastname = Util.decodeURL((String)ht.get(strObj + "lastname"));
		}
		
		if (ht.containsKey(strObj + "salecode")) {
			invoice.salecode = Util.decodeURL((String)ht.get(strObj + "salecode"));
		}
		if (ht.containsKey(strObj + "zip")) {
			invoice.zip = Util.decodeURL((String)ht.get(strObj + "zip"));
		}
		
		if (ht.containsKey(strObj + "note")) {
			invoice.note = Util.decodeURL((String)ht.get(strObj + "note"));
		}
		
		if (ht.containsKey(strObj + "layaway")) {
			invoice.layaway = Util.stringToBoolean((String)ht.get(strObj + "layaway"));
		}
		
		if (ht.containsKey(strObj + "printnotes")) {
			invoice.printnotes = Util.stringToBoolean((String)ht.get(strObj + "printnotes"));
		}
		
		if (ht.containsKey(strObj + "presaledate")) {
			invoice.presaledate = new Date(Long.parseLong((String)ht.get(strObj + "presaledate")));
		}
		
		return invoice;
   }

   public static String toQueryString(Invoice invoice)
   {
	   Hashtable ht = toHashtable(invoice);
	   return Util.hashtableToQuery(ht);	
	}

}
