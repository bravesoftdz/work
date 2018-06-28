package com.mainretail.handheld;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.util.KeyValueParser;
import com.mainretail.util.Util;

public class BarcodeVerifyQtyService {

	public BarcodeVerifyQtyService() {
		super();
	}
	
	public static Hashtable vectorToHashtable(Vector vector){
		Hashtable ht = new Hashtable();
		
		BarcodeVerifyQty bvq = null;
		int i = 0;
		String strObj;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();){
			i++;
			bvq = (BarcodeVerifyQty)en.nextElement();
			strObj = "BVQ_" + String.valueOf(i) + ".";
			
			if (bvq.barcode != null) {
				ht.put(strObj + "barcode", Util.encodeURL(bvq.barcode));
			}			
	
			if (bvq.qty != Double.NaN || bvq.qty != 0) {
				ht.put(strObj + "qty", String.valueOf(bvq.qty));
			}
			
			strObj = null;
			bvq = null;
			
		}
		return ht;
	}
	
	public static Vector queryStringToVector(String query){
		Vector vector = new Vector();
		//Hashtable ht = Util.queryToHashtable(query);
		KeyValueParser ht = new KeyValueParser();
			
		String strObj = null;
 
		int i = 1;
			
		while(query.indexOf(strObj = new String("BVQ_" + String.valueOf(i) + ".")) >= 0){
				
			BarcodeVerifyQty barcodeVerifyQty = new BarcodeVerifyQty();
			
			if (ht.containsKey(query, strObj + "barcode")) {
				barcodeVerifyQty.barcode =  Util.decodeURL((String)ht.get());
			}
			
			if (ht.containsKey(query, strObj + "qty")){
				barcodeVerifyQty.qty = Double.parseDouble((String)ht.get());
			}
				
			vector.addElement(barcodeVerifyQty);
				
			i++;
			strObj = null;
			barcodeVerifyQty = null;
		}
			
		return vector;
	}
	
	
	public static String BarcodeVerifyQtyToString(BarcodeVerifyQty bvq) {
		Vector vetTemp = new Vector();
		vetTemp.addElement(bvq);
		
		Hashtable ht = vectorToHashtable(vetTemp);
		
		return Util.hashtableToQuery(ht);
	}
	
	public static BarcodeVerifyQty StringToBarcodeVerifyQty(String query) {
		Vector vetTemp = queryStringToVector(query);
		return (BarcodeVerifyQty)vetTemp.elementAt(0);
	}

}

