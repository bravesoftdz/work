package com.mainretail.handheld.inventory;

import java.util.Enumeration;
import java.util.Hashtable;

public class InvCountService {

	public static Hashtable toHashtable(InvCount invcount)
	{
		Hashtable hashinvcount = new Hashtable();
		if (invcount.idcount != 0) {
			hashinvcount.put("IC.idcount", String.valueOf(invcount.idcount));
		}
		if (invcount.idstore != 0) {
			hashinvcount.put("IC.idstore", String.valueOf(invcount.idstore));
		}
		
		if (invcount.counttype != 0) {
			hashinvcount.put("IC.counttype", String.valueOf(invcount.counttype));
		}

		return hashinvcount;
	}

   public static InvCount toInvCount(Hashtable hashinvcount)
   {
	    InvCount invcount = new InvCount();
	    
		if (hashinvcount.containsKey("IC.idcount")) {
			invcount.idcount = Integer.parseInt((String)hashinvcount.get("IC.idcount"));
		}
		if (hashinvcount.containsKey("IC.idstore")) {
			invcount.idstore = Integer.parseInt((String)hashinvcount.get("IC.idstore"));
		}
		 
		if (hashinvcount.containsKey("IC.counttype")) {
			invcount.counttype = Integer.parseInt((String)hashinvcount.get("IC.counttype"));
		}
	   
	   return invcount;
   }

   public static String toQueryString(InvCount invcount)
   {
	   Hashtable table = toHashtable(invcount);
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