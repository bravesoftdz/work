package com.mainretail.handheld.purchase;

import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.handheld.Barcode;
import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.util.Util;

public class POItemService {
	
	public static POItem productToPOItem(Model model){
		
		POItem poitem = new POItem();
		poitem.model = model;
		
		return poitem;
	}
	   
	public static Hashtable vectorToHashtable(Vector vector)
	{
		Hashtable ht = new Hashtable();
		
		POItem poitem = null;
		int i = 0;
		String strObj;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();)
		{
			i++;
			poitem = (POItem)en.nextElement();
			strObj = "POI_" + String.valueOf(i) + ".";
			
			if (poitem.model != null){
				
				Hashtable htModel = ModelService.toHashtable(poitem.model);
				for (Enumeration enumModel = htModel.keys(); enumModel.hasMoreElements();){
					String key = (String)enumModel.nextElement();
					ht.put(strObj + key, String.valueOf((String)htModel.get(key)));
				}
			}
			
			if (poitem.idpoitem != 0) {
				ht.put(strObj + "idpoitem", String.valueOf(poitem.idpoitem));
			}
			
			if (poitem.inventmovtypeid != 0) {
				ht.put(strObj + "inventmovtypeid", String.valueOf(poitem.inventmovtypeid));
			}
			
			if (poitem.storeid != 0) {
				ht.put(strObj + "storeid", String.valueOf(poitem.storeid));
			}
			
			if (poitem.idpessoa != 0) {
				ht.put(strObj + "idpessoa", String.valueOf(poitem.idpessoa));
			}
			
			if (poitem.userid != 0) {
				ht.put(strObj + "userid", String.valueOf(poitem.userid));
			}
			
			if (poitem.documentid != 0) {
				ht.put(strObj + "documentid", String.valueOf(poitem.documentid));
			}
			
			if (poitem.barcode != null) {
				ht.put(strObj + "barcode", Util.encodeURL(poitem.barcode));
			}
			
			if (poitem.costprice != Double.NaN || poitem.costprice != 0 ) {
				ht.put(strObj + "costprice", String.valueOf(poitem.costprice));
			}
			
			if (poitem.saleprice != Double.NaN || poitem.saleprice != 0 ) {
				ht.put(strObj + "saleprice", String.valueOf(poitem.saleprice));
			}
			
			if (poitem.suggretail != Double.NaN || poitem.suggretail != 0 ) {
				ht.put(strObj + "suggretail", String.valueOf(poitem.suggretail));
			}
			
			if (poitem.qty != Double.NaN || poitem.qty != 0 ) {
				ht.put(strObj + "qty", String.valueOf(poitem.qty));
			}
			
			if (poitem.qtyrealmov != Double.NaN || poitem.qtyrealmov != 0 ) {
				ht.put(strObj + "qtyrealmov", String.valueOf(poitem.qtyrealmov));
			}
			
			if (poitem.movdate != null) {
				ht.put(strObj + "movdate", String.valueOf(poitem.movdate.getTime()));
			}
			
			if (poitem.dateestimatedmov != null) {
				ht.put(strObj + "dateestimatedmov", String.valueOf(poitem.dateestimatedmov.getTime()));
			}
			
			if (poitem.daterealmov != null) {
				ht.put(strObj + "daterealmov", String.valueOf(poitem.daterealmov.getTime()));
			}
					
		}
		return ht;
	}
	
	public static Vector queryStringToVector(String query){
		Vector vector = new Vector();
		Hashtable ht = Util.queryToHashtable(query);			
		
		String strObj = null;
		int i = 1;
		
		while(query.indexOf(strObj = new String("POI_" + String.valueOf(i) + ".")) >= 0){
			
			POItem poitem = new POItem();
			
			// Model
			if (query.indexOf(strObj + "M.") >= 0){
				poitem.model = ModelService.toModel(ht, strObj);
			}
			
			if (ht.containsKey(strObj + "idpoitem")) {
				poitem.idpoitem = Integer.parseInt((String)ht.get(strObj + "idpoitem"));
			}
			
			if (ht.containsKey(strObj + "inventmovtypeid")) {
				poitem.inventmovtypeid = Integer.parseInt((String)ht.get(strObj + "inventmovtypeid"));
			}
			
			if (ht.containsKey(strObj + "storeid")) {
				poitem.storeid = Integer.parseInt((String)ht.get(strObj + "storeid"));
			}
			
			if (ht.containsKey(strObj + "idpessoa")) {
				poitem.idpessoa = Integer.parseInt((String)ht.get(strObj + "idpessoa"));
			}
			
			if (ht.containsKey(strObj + "userid")) {
				poitem.userid = Integer.parseInt((String)ht.get(strObj + "userid"));
			}
			
			if (ht.containsKey(strObj + "documentid")) {
				poitem.documentid = Integer.parseInt((String)ht.get(strObj + "documentid"));
			}
			
			if (ht.containsKey(strObj + "barcode")) {
				poitem.barcode = Util.decodeURL((String)ht.get(strObj + "barcode"));
			}

			if (ht.containsKey(strObj + "costprice")) {
				poitem.costprice = Double.parseDouble((String)ht.get(strObj + "costprice"));
			}
			
			if (ht.containsKey(strObj + "saleprice")) {
				poitem.saleprice = Double.parseDouble((String)ht.get(strObj + "saleprice"));
			}
			
			if (ht.containsKey(strObj + "suggretail")) {
				poitem.suggretail = Double.parseDouble((String)ht.get(strObj + "suggretail"));
			}
			
			if (ht.containsKey(strObj + "qty")) {
				poitem.qty = Double.parseDouble((String)ht.get(strObj + "qty"));
			}
			
			if (ht.containsKey(strObj + "qtyrealmov")) {
				poitem.qtyrealmov = Double.parseDouble((String)ht.get(strObj + "qtyrealmov"));
			}
			
			if (ht.containsKey(strObj + "movdate")) {
				poitem.movdate = new Date(Long.parseLong((String)ht.get(strObj + "movdate")));
			}
			
			if (ht.containsKey(strObj + "dateestimatedmov")) {
				poitem.dateestimatedmov = new Date(Long.parseLong((String)ht.get(strObj + "dateestimatedmov")));
			}
			
			if (ht.containsKey(strObj + "daterealmov")) {
				poitem.daterealmov = new Date(Long.parseLong((String)ht.get(strObj + "daterealmov")));
			} 
			
	    	vector.addElement(poitem);
			
			i++;
		}
		
		return vector;
	}
	
	public static POItem toPOItem(Barcode barcode){
		POItem poitem = new POItem();
		
		if (barcode != null){
			poitem.model = barcode.model;
			poitem.barcode = barcode.idbarcode;
		} 
		
		return poitem;		
	}
	
	public static String POItemToString(POItem POI) {
		Vector vetTemp = new Vector();
		vetTemp.addElement(POI);
		
		Hashtable ht = vectorToHashtable(vetTemp);
		
		return Util.hashtableToQuery(ht);
	}
	
	public static POItem StringToPOItem(String query) {
		Vector vetTemp = queryStringToVector(query);
		return (POItem)vetTemp.elementAt(0);
	}

}
