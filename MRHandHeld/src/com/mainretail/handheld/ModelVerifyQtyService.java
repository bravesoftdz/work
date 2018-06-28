package com.mainretail.handheld;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.util.KeyValueParser;
import com.mainretail.util.Util;

public class ModelVerifyQtyService {

	public ModelVerifyQtyService() {
		super();
	}
	
	public static Hashtable vectorToHashtable(Vector vector){
		Hashtable ht = new Hashtable();
		
		ModelVerifyQty mvq = null;
		int i = 0;
		String strObj;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();){
			i++;
			mvq = (ModelVerifyQty)en.nextElement();
			strObj = "MVQ_" + String.valueOf(i) + ".";
			
			if (mvq.model != null){
				
				Hashtable htModel = ModelService.toHashtable(mvq.model);
				for (Enumeration enumModel = htModel.keys(); enumModel.hasMoreElements();){
					String key = (String)enumModel.nextElement();
					ht.put(strObj + key, String.valueOf((String)htModel.get(key)));
				}
			}
					
	
			if (mvq.qty != Double.NaN || mvq.qty != 0) {
				ht.put(strObj + "qty", String.valueOf(mvq.qty));
			}
			
			if (mvq.qtyVerified != Double.NaN || mvq.qtyVerified != 0) {
				ht.put(strObj + "qtyVerified", String.valueOf(mvq.qtyVerified));
			}
			
			strObj = null;
			mvq = null;
			
		}
		return ht;
	}
	
	public static Vector queryStringToVector(String query){
		Vector vector = new Vector();
		//Hashtable ht = Util.queryToHashtable(query);
		KeyValueParser ht = new KeyValueParser();
			
		String strObj = null;
 
		int i = 1;
			
		while(query.indexOf(strObj = new String("MVQ_" + String.valueOf(i) + ".")) >= 0){
				
			ModelVerifyQty modelVerifyQty = new ModelVerifyQty();
			
				
				// Model
			if (query.indexOf(strObj + "M.") >= 0){
				modelVerifyQty.model = ModelService.toModel(query, strObj);
			}	
				
			if (ht.containsKey(query, strObj + "qty")){
				modelVerifyQty.qty = Double.parseDouble((String)ht.get());
			}
				
			if (ht.containsKey(query, strObj + "qtyVerified")){
				modelVerifyQty.qtyVerified = Double.parseDouble((String)ht.get());
			}
				
			vector.addElement(modelVerifyQty);
				
			i++;
			strObj = null;
			modelVerifyQty = null;
		}
			
		return vector;
	}
	
	
	public static String ModelVerifyQtyToString(ModelVerifyQty mvq) {
		Vector vetTemp = new Vector();
		vetTemp.addElement(mvq);
		
		Hashtable ht = vectorToHashtable(vetTemp);
		
		return Util.hashtableToQuery(ht);
	}
	
	public static ModelVerifyQty StringToModelVerifyQty(String query) {
		Vector vetTemp = queryStringToVector(query);
		return (ModelVerifyQty)vetTemp.elementAt(0);
	}

}
