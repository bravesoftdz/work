package com.mainretail.handheld.sales;

import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import com.mainretail.handheld.Model;
import com.mainretail.handheld.ModelService;
import com.mainretail.util.Util;

public class PreSaleItemService {
	
public static PreSaleItem productToPreSaleItem(Model model){
		
		PreSaleItem presaleitem = new PreSaleItem();
		presaleitem.model = model;
		
		return presaleitem;
	}
	   
	public static Hashtable vectorToHashtable(Vector vector)
	{
		Hashtable ht = new Hashtable();
		
		PreSaleItem presaleitem = null;
		int i = 0;
		String strObj;
		
		for (Enumeration en = vector.elements(); en.hasMoreElements();)
		{
			i++;
			presaleitem = (PreSaleItem)en.nextElement();
			strObj = "PSI_" + String.valueOf(i) + ".";
			
			if (presaleitem.model != null){
				
				Hashtable htModel = ModelService.toHashtable(presaleitem.model);
				for (Enumeration enumModel = htModel.keys(); enumModel.hasMoreElements();){
					String key = (String)enumModel.nextElement();
					ht.put(strObj + key, String.valueOf((String)htModel.get(key)));
				}
			}
			
			if (presaleitem.idpresale != 0) {
				ht.put(strObj + "idpresale", String.valueOf(presaleitem.idpresale));
			}
			
			if (presaleitem.idcliente != 0) {
				ht.put(strObj + "idcliente", String.valueOf(presaleitem.idcliente));
			}
			
			if (presaleitem.idstore != 0) {
				ht.put(strObj + "idstore", String.valueOf(presaleitem.idstore));
			}
			
			if (presaleitem.iduser != 0) {
				ht.put(strObj + "iduser", String.valueOf(presaleitem.iduser));
			}
			
			if (presaleitem.idcomission != 0) {
				ht.put(strObj + "idcomission", String.valueOf(presaleitem.idcomission));
			}
			if (presaleitem.idpreinvmovexchange != 0) {
				ht.put(strObj + "idpreinvmovexchange", String.valueOf(presaleitem.idpreinvmovexchange));
			}
			
			if (presaleitem.idpreinventmov != 0) {
				ht.put(strObj + "idpreinventmov", String.valueOf(presaleitem.idpreinventmov));
			}
			
			if (presaleitem.iddepartment != 0) {
				ht.put(strObj + "iddepartment", String.valueOf(presaleitem.iddepartment));
			}
			
			if (presaleitem.qty != Double.NaN || presaleitem.qty != 0 ) {
				ht.put(strObj + "qty", String.valueOf(presaleitem.qty));
			}
			
			if (presaleitem.saleprice != Double.NaN || presaleitem.saleprice != 0 ) {
				ht.put(strObj + "saleprice", String.valueOf(presaleitem.saleprice));
			}
			
			if (presaleitem.costprice != Double.NaN || presaleitem.costprice != 0 ) {
				ht.put(strObj + "costprice", String.valueOf(presaleitem.costprice));
			}
			
			if (presaleitem.discount != Double.NaN || presaleitem.discount != 0 ) {
				ht.put(strObj + "discount", String.valueOf(presaleitem.discount));
			}
			
			ht.put(strObj + "resetdiscount", String.valueOf(presaleitem.resetdiscount));
			ht.put(strObj + "manager", String.valueOf(presaleitem.manager));
			ht.put(strObj + "promo", String.valueOf(presaleitem.promo));
			
			if (presaleitem.movdate != null) {
				ht.put(strObj + "movdate", String.valueOf(presaleitem.movdate.getTime()));
			}
			
			if (presaleitem.presaledate != null) {
				ht.put(strObj + "presaledate", String.valueOf(presaleitem.presaledate.getTime()));
			}
		
		}
		return ht;
	}
	
	public static Vector queryStringToVector(String query){
		Vector vector = new Vector();
		Hashtable ht = Util.queryToHashtable(query);			
		
		String strObj = null;
		int i = 1;
		
		while(query.indexOf(strObj = new String("PSI_" + String.valueOf(i) + ".")) >= 0){
			
			PreSaleItem presaleitem = new PreSaleItem();
			
			// Model
			if (query.indexOf(strObj + "M.") >= 0){
				presaleitem.model = ModelService.toModel(ht, strObj);
			}
			
			if (ht.containsKey(strObj + "idpresale")) {
				presaleitem.idpresale = Integer.parseInt((String)ht.get(strObj + "idpresale"));
			}
			
			if (ht.containsKey(strObj + "idcliente")) {
				presaleitem.idcliente = Integer.parseInt((String)ht.get(strObj + "idcliente"));
			}
			
			if (ht.containsKey(strObj + "idstore")) {
				presaleitem.idstore = Integer.parseInt((String)ht.get(strObj + "idstore"));
			}
			
			if (ht.containsKey(strObj + "iduser")) {
				presaleitem.iduser = Integer.parseInt((String)ht.get(strObj + "iduser"));
			}
			
			if (ht.containsKey(strObj + "idcomission")) {
				presaleitem.idcomission = Integer.parseInt((String)ht.get(strObj + "idcomission"));
			}
			
			if (ht.containsKey(strObj + "idpreinvmovexchange")) {
				presaleitem.idpreinvmovexchange = Integer.parseInt((String)ht.get(strObj + "idpreinvmovexchange"));
			}
			
			if (ht.containsKey(strObj + "idpreinventmov")) {
				presaleitem.idpreinventmov = Integer.parseInt((String)ht.get(strObj + "idpreinventmov"));
			}
			
			if (ht.containsKey(strObj + "iddepartment")) {
				presaleitem.iddepartment = Integer.parseInt((String)ht.get(strObj + "iddepartment"));
			}
			
			if (ht.containsKey(strObj + "qty")) {
				presaleitem.qty = Double.parseDouble((String)ht.get(strObj + "qty"));
			}
			
			if (ht.containsKey(strObj + "saleprice")) {
				presaleitem.saleprice = Double.parseDouble((String)ht.get(strObj + "saleprice"));
			}
			
			if (ht.containsKey(strObj + "costprice")) {
				presaleitem.costprice = Double.parseDouble((String)ht.get(strObj + "costprice"));
			}
					
			if (ht.containsKey(strObj + "discount")) {
				presaleitem.discount = Double.parseDouble((String)ht.get(strObj + "discount"));
			}
			
			if (ht.containsKey(strObj + "resetdiscount")) {
				presaleitem.resetdiscount = Util.stringToBoolean((String)ht.get(strObj + "resetdiscount"));
			}
			
			if (ht.containsKey(strObj + "manager")) {
				presaleitem.manager = Util.stringToBoolean((String)ht.get(strObj + "manager"));
			}
			
			if (ht.containsKey(strObj + "promo")) {
				presaleitem.promo = Util.stringToBoolean((String)ht.get(strObj + "promo"));
			}
			
			if (ht.containsKey(strObj + "movdate")) {
				presaleitem.movdate = new Date(Long.parseLong((String)ht.get(strObj + "movdate")));
			}
			
			if (ht.containsKey(strObj + "presaledate")) {
				presaleitem.presaledate = new Date(Long.parseLong((String)ht.get(strObj + "presaledate")));
			}
					
	    	vector.addElement(presaleitem);
			
			i++;
		}
		
		return vector;
	}
	
}
