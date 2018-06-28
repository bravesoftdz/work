package com.mainretail.handheld;

import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.util.Util;

public class BarcodeService {
	
	public static Hashtable toHashtable(Barcode barcode)
	{
		Hashtable hashbarcode = new Hashtable();
		
		String strObj = "B.";
		
		if (barcode.model != null){
			Hashtable htModel = ModelService.toHashtable(barcode.model, "model.");
			for (Enumeration enumModel = htModel.keys(); enumModel.hasMoreElements();){
				String key = (String)enumModel.nextElement();
				hashbarcode.put(strObj + key, String.valueOf((String)htModel.get(key)));
			}
		}
		
		if (barcode.idbarcode != null) {
			hashbarcode.put(strObj + "idbarcode", Util.encodeURL(barcode.idbarcode));
		}
		
		if (barcode.data != null) {
			hashbarcode.put(strObj + "documentduedate", String.valueOf(barcode.data.getTime()));
		}
		
		return  hashbarcode;
	}

   public static Barcode toBarcode(Hashtable hashBarcode) {
		return toBarcode(hashBarcode, "");
   }
   
   public static Barcode toBarcode(Hashtable hashBarcode, String alias) {
	    Barcode barcode = new Barcode ();
	    
	    String query = Util.hashtableToQuery(hashBarcode);
	    
	    String strObj = alias + "B.";
	    
	    // Model
		if (query.indexOf(strObj  + "model.") >= 0){
			barcode.model = ModelService.toModel(hashBarcode, strObj, "model.");
		}
		
		query = "";
		
		if (hashBarcode.containsKey(strObj + "idbarcode")) {
			barcode.idbarcode = Util.decodeURL((String)hashBarcode.get(strObj + "idbarcode"));
		}

		if (hashBarcode.containsKey(strObj + "data")) {
			barcode.data = new Date(Long.parseLong((String)hashBarcode.get(strObj + "data")));
		}

		return barcode;
   }
   
   
   public static Hashtable vectorToHashtable(Vector vector){
		Hashtable ht = new Hashtable();
		
		Barcode barcode = null;
		int i = 0;
		String strObj;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();){
			i++;
			barcode = (Barcode)en.nextElement();
			strObj = "B_" + String.valueOf(i) + ".";
			
			if (barcode.model != null){
				
				Hashtable htModel = ModelService.toHashtable(barcode.model);
				for (Enumeration enumModel = htModel.keys(); enumModel.hasMoreElements();){
					String key = (String)enumModel.nextElement();
					ht.put(strObj + key, String.valueOf((String)htModel.get(key)));
				}
			}
					
	
			if (barcode.idbarcode != null) {
				ht.put(strObj + "idbarcode", barcode.idbarcode);
			}
			
			if (barcode.data != null) {
				ht.put(strObj + "data", String.valueOf(barcode.data));
			}
			
			if (barcode.data != null) {
				ht.put(strObj + "data", String.valueOf(barcode.data.getTime()));
			}
			
		}
		return ht;
	}
   
	public static Vector queryStringToVector(String query){
		Vector vector = new Vector();
		Hashtable ht = Util.queryToHashtable(query);			
			
		String strObj = null;
 
		int i = 1;
			
		while(query.indexOf(strObj = new String("B_" + String.valueOf(i) + ".")) >= 0){
				
			Barcode barCode = new Barcode();
				
				// Model
			if (query.indexOf(strObj + "M.") >= 0){
				barCode.model = ModelService.toModel(ht, strObj);
			}
					
			if (ht.containsKey(strObj + "idbarcode")){
				barCode.idbarcode = (String)ht.get(strObj + "idbarcode");
			}
				
			if (ht.containsKey(strObj + "data")){
				barCode.data = new Date(Long.parseLong((String)ht.get(strObj + "data")));
			}
				
			vector.addElement(barCode);
				
			i++;
		}
			
		return vector;
	}
   
   
	
   public static String toQueryString(Barcode barcode) {
	   Hashtable ht = toHashtable(barcode);
	   return Util.hashtableToQuery(ht);
   }

}
