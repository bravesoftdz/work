package com.mainretail.handheld.inventory;

import java.util.Enumeration;
import java.util.Hashtable;

import com.mainretail.util.Util;

public class InvMovService {

	public static Hashtable toHashtable(InvMov invmov)
	{
		Hashtable hashinvcountitem = new Hashtable();

		if (invmov.idinvmov != 0) {
			hashinvcountitem.put("IM.idinvmov", String.valueOf(invmov.idinvmov));
		}
		
		if (invmov.iduser != 0) {
			hashinvcountitem.put("IM.iduser", String.valueOf(invmov.iduser));
		}
		
		if (invmov.idstore != 0) {
			hashinvcountitem.put("IM.idstore", String.valueOf(invmov.idstore));
		}
		
		if (invmov.idstore != 0) {
			hashinvcountitem.put("IM.idinvmovtype", String.valueOf(invmov.idinvmovtype));
		}
		
		if (invmov.idmodel != 0) {
			hashinvcountitem.put("IM.idmodel", String.valueOf(invmov.idmodel));
		}
		
		//if (invmov.documentid != 0) {
			hashinvcountitem.put("IM.documentid", String.valueOf(invmov.documentid));
		//}
		
		if (invmov.barcode != null) {
			hashinvcountitem.put("IM.barcode", Util.encodeURL(invmov.barcode));
		}

		if (invmov.qty != 0) {
			hashinvcountitem.put("IM.qty", String.valueOf(invmov.qty));
		}

		if (invmov.movdate != null) {
			hashinvcountitem.put("IM.movdate", String.valueOf(invmov.movdate));
		}

		return hashinvcountitem;
	}
	
	public static Hashtable toHashtable(InvMov invmov, Hashtable ht)
	{
		if (invmov.idinvmov != 0) {
			ht.put("IM.idinvmov", String.valueOf(invmov.idinvmov));
		}
		
		if (invmov.iduser != 0) {
			ht.put("IM.iduser", String.valueOf(invmov.iduser));
		}
		
		if (invmov.idstore != 0) {
			ht.put("IM.idstore", String.valueOf(invmov.idstore));
		}
		
		if (invmov.idstore != 0) {
			ht.put("IM.idinvmovtype", String.valueOf(invmov.idinvmovtype));
		}
		
		if (invmov.idmodel != 0) {
			ht.put("IM.idmodel", String.valueOf(invmov.idmodel));
		}
		
		if (invmov.documentid != 0) {
			ht.put("IM.documentid", String.valueOf(invmov.documentid));
		}
		
		if (invmov.barcode != null) {
			ht.put("IM.barcode", Util.encodeURL(invmov.barcode));
		}

		if (invmov.qty != 0) {
			ht.put("IM.qty", String.valueOf(invmov.qty));
		}

		if (invmov.movdate != null) {
			ht.put("IM.movdate", String.valueOf(invmov.movdate));
		}

		return ht;
	}

   public static InvMov toInvMov(Hashtable hashinvmov)
   {
	   InvMov invmov = new InvMov();
	    
		if (hashinvmov.containsKey("IM.idinvmov")) {
			invmov.idinvmov = Integer.parseInt((String)hashinvmov.get("IM.idinvmov"));
		}

		if (hashinvmov.containsKey("IM.iduser")) {
			invmov.iduser = Integer.parseInt((String)hashinvmov.get("IM.iduser"));
		}
		
		if (hashinvmov.containsKey("IM.idstore")) {
			invmov.idstore = Integer.parseInt((String)hashinvmov.get("IM.idstore"));
		} 
		
		if (hashinvmov.containsKey("IM.idinvmovtype")) {
			invmov.idinvmovtype = Integer.parseInt((String)hashinvmov.get("IM.idinvmovtype"));
		}
		
		if (hashinvmov.containsKey("IM.idmodel")) {
			invmov.idmodel = Integer.parseInt((String)hashinvmov.get("IM.idmodel"));
		}
		
		if (hashinvmov.containsKey("IM.documentid")) {
			invmov.documentid = Integer.parseInt((String)hashinvmov.get("IM.documentid"));
		}
		 
		if (hashinvmov.containsKey("IM.barcode")) {
			invmov.barcode = Util.decodeURL((String)hashinvmov.get("IM.barcode"));
		}

		if (hashinvmov.containsKey("IM.qty")) {
			invmov.qty = Double.parseDouble((String)hashinvmov.get("IM.qty"));
		}
		
		/*if (hashinvmov.containsKey("movdate")) {
			invmov.movdate = DateParser.parse((String)hashinvmov.get("movdate"));
		}*/
		
	   return invmov;
   }

   public static String toQueryString(InvMov invmov)
   {
	   Hashtable table = toHashtable(invmov);
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
