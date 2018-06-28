package com.mainretail.handheld.inventory;

import java.util.Enumeration;
import java.util.Hashtable;

import com.mainretail.util.Util;

public class InvCountItemService {

	public static Hashtable toHashtable(InvCountItem invcountitem)
	{
		Hashtable hashinvcountitem = new Hashtable();

		if (invcountitem.idcountitem != 0) {
			hashinvcountitem.put("ICI.idcountitem", String.valueOf(invcountitem.idcountitem));
		}
		
		if (invcountitem.idcount != 0) {
			hashinvcountitem.put("ICI.idcount", String.valueOf(invcountitem.idcount));
		}
		
		if (invcountitem.iduser != 0) {
			hashinvcountitem.put("ICI.iduser", String.valueOf(invcountitem.iduser));
		}
		
		if (invcountitem.idmodel != 0) {
			hashinvcountitem.put("ICI.idmodel", String.valueOf(invcountitem.idmodel));
		}
		
		if (invcountitem.barcode != null) {
			hashinvcountitem.put("ICI.barcode", Util.encodeURL(invcountitem.barcode));
		}

		if (invcountitem.qty != 0) {
			hashinvcountitem.put("ICI.qty", String.valueOf(invcountitem.qty));
		}

		if (invcountitem.saleprice != 0) {
			hashinvcountitem.put("ICI.saleprice", String.valueOf(invcountitem.saleprice));
		}

		if (invcountitem.countdate != null) {
			hashinvcountitem.put("ICI.countdate", String.valueOf(invcountitem.countdate));
		}

		return hashinvcountitem;
	}
	
	public static Hashtable toHashtable(InvCountItem invcountitem, Hashtable ht )
	{
		if (invcountitem.idcountitem != 0) {
			ht.put("ICI.idcountitem", String.valueOf(invcountitem.idcountitem));
		}
		
		if (invcountitem.idcount != 0) {
			ht.put("ICI.idcount", String.valueOf(invcountitem.idcount));
		}
		
		if (invcountitem.iduser != 0) {
			ht.put("ICI.iduser", String.valueOf(invcountitem.iduser));
		}
		
		if (invcountitem.idmodel != 0) {
			ht.put("ICI.idmodel", String.valueOf(invcountitem.idmodel));
		}
		
		if (invcountitem.barcode != null) {
			ht.put("ICI.barcode", Util.encodeURL(invcountitem.barcode));
		}

		if (invcountitem.qty != 0) {
			ht.put("ICI.qty", String.valueOf(invcountitem.qty));
		}

		if (invcountitem.saleprice != 0) {
			ht.put("ICI.saleprice", String.valueOf(invcountitem.saleprice));
		}

		if (invcountitem.countdate != null) {
			ht.put("ICI.countdate", String.valueOf(invcountitem.countdate));
		}

		return ht;
	}

   public static InvCountItem toInvCountItem(Hashtable hashinvcountitem)
   {
	    InvCountItem invcountitem = new InvCountItem();
	    
		if (hashinvcountitem.containsKey("ICI.idcountitem")) {
			invcountitem.idcountitem = Integer.parseInt((String)hashinvcountitem.get("ICI.idcountitem"));
		}

		if (hashinvcountitem.containsKey("ICI.idcount")) {
			invcountitem.idcount = Integer.parseInt((String)hashinvcountitem.get("ICI.idcount"));
		}

		if (hashinvcountitem.containsKey("ICI.iduser")) {
			invcountitem.iduser = Integer.parseInt((String)hashinvcountitem.get("ICI.iduser"));
		}
		
		if (hashinvcountitem.containsKey("ICI.idmodel")) {
			invcountitem.idmodel = Integer.parseInt((String)hashinvcountitem.get("ICI.idmodel"));
		}
		 
		if (hashinvcountitem.containsKey("ICI.barcode")) {
			invcountitem.barcode = Util.decodeURL((String)hashinvcountitem.get("ICI.barcode"));
		}

		if (hashinvcountitem.containsKey("ICI.qty")) {
			invcountitem.qty = Double.parseDouble((String)hashinvcountitem.get("ICI.qty"));
		}
		
		if (hashinvcountitem.containsKey("ICI.saleprice")) {
			invcountitem.saleprice = Double.parseDouble((String)hashinvcountitem.get("ICI.saleprice"));
		}
		
	   return invcountitem;
   }

   public static String toQueryString(InvCountItem invcountitem)
   {
	   Hashtable table = toHashtable(invcountitem);
	   StringBuffer queryBuffer = new StringBuffer();

	   if (table!=null && table.size() > 0) {
		   Enumeration keys = table.keys();
		   while (keys.hasMoreElements()) {
			   if (queryBuffer.length() >0) {
				   queryBuffer.append("&");
			   }
			   String key = (String) keys.nextElement() ;
			   queryBuffer.append(key);
			   queryBuffer.append("=");
			   queryBuffer.append(table.get(key));
		   }
	   }
	   return queryBuffer.toString();		
	}
}