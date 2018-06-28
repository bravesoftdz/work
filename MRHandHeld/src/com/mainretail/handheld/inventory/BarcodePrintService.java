package com.mainretail.handheld.inventory;

import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.BarcodeService;
import com.mainretail.util.Util;

public class BarcodePrintService {
	
	public static Hashtable vectorToHashtable(Vector vector)
	{
		Hashtable ht = new Hashtable();
		
		BarcodePrint barcodeprint = null;
		int i = 0;
		String strObj;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();)
		{
			i++;
			barcodeprint = (BarcodePrint)en.nextElement();
			strObj = "BP_" + String.valueOf(i) + ".";
			
			if (barcodeprint.barcode != null){
				
				Hashtable htBarcode = BarcodeService.toHashtable(barcodeprint.barcode);
				for (Enumeration enumBarcode = htBarcode.keys(); enumBarcode.hasMoreElements();){
					String key = (String)enumBarcode.nextElement();
					ht.put(strObj + key, String.valueOf((String)htBarcode.get(key)));
				}
			}
			
			if (barcodeprint.qtd != 0) {
				ht.put(strObj + "qtd", String.valueOf(barcodeprint.qtd));
			}
			
			if (barcodeprint.iduser != 0) {
				ht.put(strObj + "iduser", String.valueOf(barcodeprint.iduser));
			}
			
			if (barcodeprint.date != null) {
				ht.put(strObj + "date", String.valueOf(barcodeprint.date.getTime()));
			}
							
		}
		return ht;
	}
	
	public static Vector queryStringToVector(String query){
		Vector vector = new Vector();
		Hashtable ht = Util.queryToHashtable(query);			
		
		String strObj = null;
		int i = 1;
		
		while(query.indexOf(strObj = new String("BP_" + String.valueOf(i) + ".")) >= 0){
			
			BarcodePrint barcodeprint = new BarcodePrint();
			
			// Barcode
			if (query.indexOf(strObj + "B.") >= 0){
				barcodeprint.barcode = BarcodeService.toBarcode(ht, strObj);
			}
			
			if (ht.containsKey(strObj + "qtd")) {
				barcodeprint.qtd = Integer.parseInt((String)ht.get(strObj + "qtd"));
			}
			
			if (ht.containsKey(strObj + "iduser")) {
				barcodeprint.iduser = Integer.parseInt((String)ht.get(strObj + "iduser"));
			}
			
			if (ht.containsKey(strObj + "date")) {
				barcodeprint.date = new Date(Long.parseLong((String)ht.get(strObj + "date")));
			}
			
			vector.addElement(barcodeprint);
			
			i++;
		}
		
		return vector;
	}
	
	public static BarcodePrint toBarcodePrint(Barcode barcode){
		
		BarcodePrint barcodeprint = new BarcodePrint();
		
		barcodeprint.barcode = barcode;
				
		return barcodeprint;	
	}
	
}
